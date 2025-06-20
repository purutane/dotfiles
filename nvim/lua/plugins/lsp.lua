return {
  {
    'neovim/nvim-lspconfig',
    cmd = {
      'LspInfo',
      'LspInstall',
      'LspUninstall',
      'LspStart',
      'LspStop',
      'LspRestart',
    },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      {
        'hrsh7th/cmp-nvim-lsp',
        'mason-org/mason.nvim',
        'mason-org/mason-lspconfig.nvim',
      },
    },
    init = function()
      -- LSPs key mappings
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
        callback = function(ev)
          local opts = { buffer = ev.buf, noremap = true, silent = true }
          -- Code navigation
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
          -- Document
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, opts)
          -- Code format and
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', '<leader>f', function()
            local filetype = vim.bo.filetype
            if filetype == 'astro' then
              vim.lsp.buf.format({
                async = true,
                filter = function(client)
                  return client.name == 'null-ls'
                end,
              })
            else
              vim.lsp.buf.format({ async = true })
            end
          end, opts)
          -- Workspace registration
          vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set('n', '<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          -- Diagnostics navigation
          vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
          vim.keymap.set('n', '[d', function()
            vim.diagnostic.jump({ count = -1, float = true })
          end, opts)
          vim.keymap.set('n', ']d', function()
            vim.diagnostic.jump({ count = 1, float = true })
          end, opts)
          vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
        end,
      })
      -- global handler (set diagnostic source)
      local original_handler = vim.lsp.handlers['textDocument/publishDiagnostics']
      vim.lsp.handlers['textDocument/publishDiagnostics'] = function(err, result, ctx, config)
        local client = vim.lsp.get_client_by_id(ctx.client_id)
        local client_name = client and client.name or 'unknown'

        for _, diagnostic in ipairs(result.diagnostics) do
          if not diagnostic.source or diagnostic.source == '' then
            diagnostic.source = client_name
          end
        end
        original_handler(err, result, ctx, config)
      end
      -- vim.diagnostic
      vim.diagnostic.config({
        virtual_text = false,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = ' ',
            [vim.diagnostic.severity.WARN] = ' ',
            [vim.diagnostic.severity.INFO] = ' ',
            [vim.diagnostic.severity.HINT] = ' ',
          },
          numhl = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '',
          },
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = 'rounded',
          source = true,
          format = function(diagnostic)
            return string.format('%s (%s)', diagnostic.message, diagnostic.source)
          end,
          winhighlight = 'NormalFloat:NormalFloat,Border:FloatBorder',
        },
      })
    end,
    config = function()
      -- capabilities
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      -- common
      local lspconfig = require('lspconfig')
      -- lua_ls
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              library = {
                vim.fn.expand('$VIMRUNTIME/lua'),
                vim.fn.stdpath('config') .. '/lua',
              },
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })
      -- pyright
      local function get_python_path()
        local python_path = vim.fn.system('pyenv which python 2>/dev/null'):gsub('%s+$', '')
        if python_path == '' then
          local system_cmd =
            'PYENV_VERSION=system pyenv which python3 2>/dev/null || PYENV_VERSION=system pyenv which python2 2>/dev/null'
          return vim.fn.system(system_cmd):gsub('%s+$', '')
        end
        return python_path
      end
      local pythonPath = get_python_path()
      lspconfig.pyright.setup({
        capabilities = capabilities,
        root_dir = function(fname)
          local project_root = require('lspconfig.util').root_pattern('.python-version')(fname)
          if not project_root then
            local file_dir = vim.fn.fnamemodify(fname, ':h')
            local cwd = vim.fn.getcwd()

            -- local cwd = vim.fn.getcwd()
            return file_dir ~= '.' and file_dir or cwd
          end
          return project_root
        end,
        single_file_support = true,
        settings = {
          python = {
            pythonPath = pythonPath,
            analysis = {
              typeCheckingMode = 'basic',
              autoSearchPaths = true,
              diagnosticMode = 'workspace',
              useLibraryCodeForTypes = true,
            },
          },
        },
        before_init = function(_, config)
          local cwd = vim.fn.getcwd()

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
        root_dir = require('lspconfig.util').root_pattern('.python-version'),
        settings = {
          lint = {
            select = {
              'E', -- flake8
              'F', -- flake8
              'W', -- flake8
              'I', -- isort
              'UP', --pyupgrade
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
      -- bashls
      lspconfig.bashls.setup({
        capabilities = capabilities,
        root_dir = function(fname)
          return require('lspconfig.util').find_git_ancestor(fname) or vim.fn.getcwd()
        end,
        filetypes = { 'sh', 'bash', 'zsh' },
        settings = {
          bashIde = {
            globPattern = {
              '**/*.sh',
              '**/*.bash',
              '**/*.zsh',
            },
            enableSourceErrorDiagnostics = true,
            shellcheckPath = '',
            shellcheckArgs = {},
            includeAllWorkspaceSymbols = true,
          },
        },
      })
      -- terraformls
      lspconfig.terraformls.setup({
        capabilities = capabilities,
        -- root_dir = require('lspconfig.util').root_pattern('.terraform', '*.tf'),
        root_dir = function(fname)
          local util = require('lspconfig.util')
          local root = util.root_pattern('.terraform', '*.tf')(fname)
          if root then
            return root
          end
          return vim.fn.getcwd()
        end,
        filetypes = { 'terraform', 'terraform-vars', 'hcl' },
        cmd = { 'terraform-ls', 'serve' },
        settings = {
          terraform = {
            experimentalFeatures = {
              validateOnSave = true,
              prefillRequiredFields = true,
            },
          },
        },
        on_attach = function(client)
          client.server_capabilities.documentHighlightProvider = false
        end,
      })
      -- tflint (static analysis only)
      lspconfig.tflint.setup({
        capabilities = capabilities,
        -- root_dir = require('lspconfig.util').root_pattern('.terraform', '*.tf'),
        root_dir = function(fname)
          local util = require('lspconfig.util')
          local root = util.root_pattern('.terraform', '*.tf')(fname)
          if root then
            return root
          end
          return vim.fn.getcwd()
        end,
        filetypes = { 'terraform', 'terraform-vars', 'hcl' },
        cmd = { 'tflint', '--langserver' },
        on_attach = function(client)
          local original_capabilities = client.server_capabilities
          for capability, _ in pairs(original_capabilities) do
            if capability ~= 'textDocumentSync' then
              original_capabilities[capability] = false
            end
          end
        end,
      })
      -- ts_ls (typescript, javascript)
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        root_dir = require('lspconfig.util').root_pattern('package.json', 'tsconfig.json', '.git'),
        filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
        settings = {
          typescript = {
            format = {
              enable = true,
            },
          },
        },
      })
      -- astro
      lspconfig.astro.setup({
        capabilities = capabilities,
        filetypes = { 'astro' },
        init_options = {
          settings = {
            typescript = {
              tsdk = vim.fn.stdpath('data') .. '/mason/packages/typescript-language-server/node_modules/typescript/lib',
            },
          },
        },
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
      })
      -- html
      lspconfig.html.setup({
        capabilities = capabilities,
        filetypes = { 'html' },
        init_options = {
          configurationSection = {
            'html',
            'css',
            'javascript',
          },
          embeddedLanguages = {
            css = true,
            javascript = true,
          },
        },
      })
      -- cssls
      lspconfig.cssls.setup({
        capabilities = capabilities,
        filetypes = { 'css', 'scss', 'sass', 'less' },
        settings = {
          css = {
            validate = true,
            lint = {
              unknownAtRules = 'ignore',
            },
          },
        },
      })
    end,
  },
}
