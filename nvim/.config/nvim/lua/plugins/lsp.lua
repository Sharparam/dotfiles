return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'folke/neoconf.nvim',
        cmd = 'Neoconf',
        config = true
      },
      {
        'folke/neodev.nvim',
        opts = {}
      },
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      {
        'hrsh7th/cmp-nvim-lsp',
        dependencies = 'hrsh7th/nvim-cmp'
      }
    },
    config = function()
      local lspconfig = require 'lspconfig'
      local cnl_caps = require('cmp_nvim_lsp').default_capabilities()
      require('mason-lspconfig').setup_handlers {
        function(server_name)
          lspconfig[server_name].setup {
            capabilities = cnl_caps
          }
        end
      }
    end
  },
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    build = ':MasonUpdate',
    config = true
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = 'williamboman/mason.nvim',
    opts = {
      ensure_installed = {
        'ansiblels', -- Ansible
        'dockerls', -- Docker
        'docker_compose_language_service', -- Docker Compose
        'fennel_language_server', -- Fennel
        'html', -- HTML
        'jsonls', -- JSON
        'tsserver', -- JavaScript/TypeScript
        'lua_ls', -- Lua
        'perlnavigator', -- Perl
        'raku_navigator', -- Raku
        'solargraph', -- Ruby
        'rust_analyzer', -- Rust
        'taplo', -- TOML
        'vimls', -- VimL
        'lemminx', -- XML
        'yamlls' -- YAML
      }
    },
    config = function(_, opts)
      require('mason-lspconfig').setup(opts)
    end
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = 'williamboman/mason.nvim'
  }
}
