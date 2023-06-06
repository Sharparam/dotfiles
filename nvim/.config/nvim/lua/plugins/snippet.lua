return {
  {
    'L3MON4D3/LuaSnip',
    build = function()
      if jit.os:find('Windows') then return nil end
      return 'echo "NOTE: jsregexp optional, failure to build is OK"; make install_jsregexp'
    end,
    dependencies = {
      {
        'rafamadriz/friendly-snippets',
        config = function()
          require('luasnip.loaders.from_vscode').lazy_load()
        end
      }
    }
  }
}
