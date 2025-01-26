return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<Leader>tP"] = {
            function() require("precognition").toggle() end,
            desc = "Toggle precognition"
          }
        }
      }
    }
  }
}
