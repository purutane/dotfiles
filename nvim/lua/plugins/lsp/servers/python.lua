local M = {}

function M.setup(capabilities)
  local lspconfig = require('lspconfig')

  local function get_python_path()
    -- 1. Active virtual environment
    local venv_path = vim.env.VIRTUAL_ENV
    if venv_path then
      local python_path = venv_path .. '/bin/python'
      if vim.fn.executable(python_path) == 1 then
        return python_path
      end
    end

    -- 2. Project-local .venv
    local cwd = vim.fn.getcwd()
    local local_venv = cwd .. '/.venv/bin/python'
    if vim.fn.executable(local_venv) == 1 then
      return local_venv
    end

    -- 3. UV-managed Python
    local python_version_file = cwd .. '/.python-version'
    if vim.fn.filereadable(python_version_file) == 1 then
      local version = vim.fn.readfile(python_version_file)[1]
      if version and version ~= '' then
        local uv_python = vim.fn.system('uv python find ' .. version .. ' 2>/dev/null'):gsub('%s+$', '')
        if uv_python ~= '' and vim.fn.executable(uv_python) == 1 then
          return uv_python
        end
      end
    end

    -- 4. Best available UV-managed Python
    local uv_python = vim.fn.system('uv python find 2>/dev/null'):gsub('%s+$', '')
    if uv_python ~= '' and vim.fn.executable(uv_python) == 1 then
      return uv_python
    end

    -- 5. System Python fallback
    local system_python = vim.fn.system('which python3 2>/dev/null || which python2 2>/dev/null'):gsub('%s+$', '')
    if system_python ~= '' and vim.fn.executable(system_python) == 1 then
      return system_python
    end

    -- final fallback
    return 'python3'
  end

  -- pyright
  lspconfig.pyright.setup({
    capabilities = capabilities,
    root_dir = function(fname)
      local util = require('lspconfig.util')

      -- Detect by project markers
      local markers = {
        'pyproject.toml',
        '.python-version',
        'requirements.txt',
        'setup.py',
        '.git',
      }

      for _, marker in ipairs(markers) do
        local project_root = util.root_pattern(marker)(fname)
        if project_root then
          return project_root
        end
      end

      -- Fallback to current working directory if no project markers found
      local file_dir = vim.fn.fnamemodify(fname, ':h')
      local cwd = vim.fn.getcwd()
      return file_dir ~= '.' and file_dir or cwd
    end,
    single_file_support = true,
    settings = {
      python = {
        pythonPath = get_python_path(),
        analysis = {
          typeCheckingMode = 'basic',
          autoSearchPaths = true,
          diagnosticMode = 'workspace',
          useLibraryCodeForTypes = true,
          autoImportCompletions = true,
        },
      },
    },
    before_init = function(_, config)
      local cwd = vim.fn.getcwd()

      -- Dynamically update python path
      config.settings.python.pythonPath = get_python_path()

      config.settings = config.settings or {}
      config.settings.python = config.settings.python or {}

      config.workspaceFolders = {
        {
          uri = 'file://' .. cwd,
          name = vim.fn.fnamemodify(cwd, ':t'),
        },
      }
    end,
  })
  -- ruff
  lspconfig.ruff.setup({
    capabilities = capabilities,
    root_dir = function(fname)
      local util = require('lspconfig.util')
      return util.root_pattern('pyproject.toml', '.python-version', 'requirements.txt', 'setup.py', '.git')(fname)
        or vim.fn.getcwd()
    end,
    settings = {
      lint = {
        select = {
          'E', -- pycodestyle errors
          'F', -- pyflakes
          'W', -- pycodestyle warnings
          'I', -- isort
          'UP', -- pyupgrade
          'N', -- pep8-naming
          'B', -- flake8-bugbear
          'A', -- flake8-builtins
          'C4', -- flake8-comprehensions
          'DTZ', -- flake8-datetimez
          'T10', -- flake8-debugger
          'EM', -- flake8-errmsg
          'ISC', -- flake8-implicit-str-concat
          'RET', -- flake8-return
          'SIM', -- flake8-simplify
          'TCH', -- flake8-type-checking
          'PTH', -- flake8-use-pathlib
          'PL', -- pylint
          'RUF', -- ruff-specific rules
        },
        ignore = {},
      },
      format = {
        quote_style = 'double',
        indent_style = 'space',
        line_length = 120,
      },
      virtualenv = {
        auto_discover = true,
      },
    },
    on_attach = function(client, _)
      client.server_capabilities.hoverProvider = false
      client.server_capabilities.documentHighlightProvider = false
      client.server_capabilities.documentSymbolProvider = false
    end,
  })
end

return M
