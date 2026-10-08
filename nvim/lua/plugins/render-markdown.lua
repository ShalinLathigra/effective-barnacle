return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = {
      'nvim-treesitter/nvim-treesitter',
      "nvim-tree/nvim-web-devicons"
  },
  opts = {
    code = {
      sign = true,
      width = "block",        -- Extends the background color across the block
      right_pad = 1,
      highlight = "NormalSB", -- Uses your theme's sidebar background for code blocks
    },
    heading = {
      -- Distinct colors for H1 through H6
      backgrounds = { 'RenderMarkdownH1Bg', 'RenderMarkdownH2Bg', 'RenderMarkdownH3Bg' }, 
    }
  },
}

-- return {
--         "lukas-reineke/headlines.nvim",
--         dependencies = "nvim-treesitter/nvim-treesitter",
--         config = true, -- or `opts = {}`
--     }
