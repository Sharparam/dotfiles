local wk = require 'which-key'

wk.register({
  b = { name = '+buffer' },
  f = { name = '+file' },
  g = {
    name = '+git',
    f = { name = '+find' }
  },
  h = {
    name = '+help',
    b = {
      name = '+bindings',
      b = { '<Cmd>WhichKey<CR>', 'Show all mappings' }
    }
  },
  o = { name = '+open' },
  -- p = { name = '+project' },
  s = { name = '+search' }
}, {
  prefix = '<Leader>'
})
