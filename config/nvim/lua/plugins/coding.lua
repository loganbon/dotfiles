return {
  "lewis6991/impatient.nvim",
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*",
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    keys = {
      --   {
      --     "<tab>",
      --     function()
      --       return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
      --     end,
      --     expr = true,
      --     silent = true,
      --     mode = "i",
      --   },
      --   {
      --     "<tab>",
      --     function()
      --       require("luasnip").jump(1)
      --     end,
      --     mode = "s",
      --   },
      --   {
      --     "<s-tab>",
      --     function()
      --       require("luasnip").jump(-1)
      --     end,
      --     mode = { "i", "s" },
      --   },
    },
  },

  -- auto completion
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      'numToStr/Comment.nvim'
    },
    opts = function()
      local cmp = require("cmp")
      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
        formatting = {
          --format = function(_, item)
          --local icons = require("config").defaults.icons.kinds
          --if icons[item.kind] then
          --item.kind = icons[item.kind] .. item.kind
          --end
          --return item
          --end,
        },
        experimental = {
          ghost_text = {
            hl_group = "LspCodeLens",
          },
        },
      }
    end,
  },

  -- auto pairs
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    config = function()
      require("mini.pairs").setup({})
    end,
  },

  {
    'terrortylor/nvim-comment',
    event = "VeryLazy",
    config = function()
      require("nvim_comment").setup(
        { comment_empty = false }
      )
    end,
  },

  {
    'ojroques/nvim-bufdel',
    event = "VeryLazy",
    cmd = 'BufDel',
    opts = {},
  },

  -- {
  --   "folke/persistence.nvim",
  --   event = "BufReadPre",
  --   opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals" } },
  --   -- stylua: ignore
  --   keys = {
  --       { "<leader>qs", function() require("persistence").load() end,                desc = "Restore Session" },
  --       { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
  --       { "<leader>qd", function() require("persistence").stop() end,                desc = "Don't Save Current Session" },
  --   },
  -- },

  -- Git
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
    keys = {
      { "<leader>gs", "<cmd>G<cr>",                     desc = "Git Status" },
      { "<leader>gc", "<cmd>G commit<cr>",              desc = "Git Commit" },
      { "<leader>gp", "<cmd>G push<cr>",                desc = "Git Push" },
      { "<leader>gP", "<cmd>G pull<cr>",                desc = "Git Pull" },
      { "<leader>gl", "<cmd>G log<cr>",                 desc = "Git Log" },
      { "<leader>gP", "<cmd>G pull<cr>",                desc = "Git Pull" },
      { "<leader>gh", "<cmd>vert bo help fugitive<cr>", desc = "Git Help" }
    }
  },

  {
    'airblade/vim-gitgutter',
    event = 'VeryLazy',
  },

  {
    'ruifm/gitlinker.nvim',
    event = 'VeryLazy',
    keys = {
      {
        "<leader>gb",
        '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<CR>',
        desc = "Github Browser (Line)"
      },
    },
  },

  {
    "mg979/vim-visual-multi",
    event = 'VeryLazy'
  }
}
