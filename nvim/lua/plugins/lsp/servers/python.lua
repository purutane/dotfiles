local M = {}

function M.setup(capabilities)
  local lspconfig = require('lspconfig')

  local function get_python_path()
    -- Helper function for safe system command execution
    local function safe_system_call(cmd)
      local success, result = pcall(function()
        return vim.fn.system(cmd):gsub('%s+$', '')
      end)

      if not success then
        return nil, 'Command execution failed'
      end

      -- Check if command succeeded (exit code 0)
      if vim.v.shell_error ~= 0 then
        return nil, 'Command returned non-zero exit code'
      end

      return result, nil
    end

    -- Helper function to check if file is executable
    local function is_executable(path)
      return path and path ~= '' and vim.fn.executable(path) == 1
    end

    -- 1. Active virtual environment
    local venv_path = vim.env.VIRTUAL_ENV
    if venv_path then
      local python_path = venv_path .. '/bin/python'
      if is_executable(python_path) then
        return python_path
      end
    end

    -- 2. Project-local .venv
    local cwd = vim.fn.getcwd()
    local local_venv = cwd .. '/.venv/bin/python'
    if is_executable(local_venv) then
      return local_venv
    end

    -- 3. UV-managed Python
    local python_version_file = cwd .. '/.python-version'
    if vim.fn.filereadable(python_version_file) == 1 then
      local success, version_content = pcall(function()
        return vim.fn.readfile(python_version_file)
      end)

      if success and version_content and #version_content > 0 then
        local version = version_content[1]
        if version and version ~= '' then
          local uv_python, err = safe_system_call('uv python find ' .. vim.fn.shellescape(version) .. ' 2>/dev/null')
          if uv_python and is_executable(uv_python) then
            return uv_python
          end
        end
      end
    end

    -- 4. Best available UV-managed Python
    local uv_python, err = safe_system_call('uv python find 2>/dev/null')
    if uv_python and is_executable(uv_python) then
      return uv_python
    end

    -- 5. System Python fallback
    local system_python, err = safe_system_call('which python3 2>/dev/null || which python2 2>/dev/null')
    if system_python and is_executable(system_python) then
      return system_python
    end

    -- final fallback
    vim.notify('No suitable Python interpreter found, using fallback: python3', vim.log.levels.WARN)
    return 'python3'
  end

  local function get_python_root_dir(fname)
    local util = require('lspconfig.util')

    local markers = {
      'pyproject.toml',
      '.python-version',
      'requirements.txt',
      'setup.py',
      'setup.cfg',
      'poetry.lock',
      '.git',
    }

    for _, marker in ipairs(markers) do
      local project_root = util.root_pattern(marker)(fname)
      if project_root then
        return project_root
      end
    end

    -- Fallback to file directory or current working directory
    local file_dir = vim.fn.fnamemodify(fname, ':h')
    local cwd = vim.fn.getcwd()
    return file_dir ~= '.' and file_dir or cwd
  end

  -- pyright
  lspconfig.pyright.setup({
    capabilities = capabilities,
    root_dir = get_python_root_dir,
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
    root_dir = get_python_root_dir,
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
      client.server_capabilities.defiinitionProvider = false
      client.server_capabilities.referencesProvider = false
      client.server_capabilities.renameProvider = false
    end,
  })
end

return M
