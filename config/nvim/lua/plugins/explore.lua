local Util = require("util")

return {
  -- {
  --   "nvim-tree/nvim-tree.lua",
  --   opts = {
  --     hijack_cursor = true,
  --     update_cwd = false,
  --     reload_on_bufenter = true,
  --     view = {
  --       mappings = {
  --         custom_only = false,
  --         list = {
  --           {
  --             key = 'l',
  --             action = 'edit',
  --             action_cb = function()
  --               local lib = require('nvim-tree.lib')
  --               local view = require('nvim-tree.view')
  --               local open = require('nvim-tree.actions.node.open-file')
  --               local node = lib.get_node_at_cursor()

  --               if node.link_to and not node.nodes then
  --                 open.fn('edit', node.link_to)
  --                 view.close()
  --               elseif node.nodes ~= nil then
  --                 lib.expand_or_collapse(node)
  --               else
  --                 open.fn('edit', node.absolute_path)
  --                 view.close()
  --               end
  --             end
  --           },
  --           -- { key = 'L', action = 'vsplit_preview', action_cb = partial(open_node, 'vsplit') },
  --           { key = 'h', action = 'close_node' },
  --           -- { key = 'H', action = 'collapse_all',   action_cb = collapse_all }
  --         },
  --       },
  --       float = {
  --         enable = true,
  --         open_win_config = function()
  --           local HEIGHT_RATIO = 0.8 -- You can change this
  --           local WIDTH_RATIO = 0.5  -- You can change this too
  --           local screen_w = vim.opt.columns:get()
  --           local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
  --           local window_w = screen_w * WIDTH_RATIO
  --           local window_h = screen_h * HEIGHT_RATIO
  --           local window_w_int = math.floor(window_w)
  --           local window_h_int = math.floor(window_h)
  --           local center_x = (screen_w - window_w) / 2
  --           local center_y = ((vim.opt.lines:get() - window_h) / 2)
  --               - vim.opt.cmdheight:get()
  --           return {
  --             border = 'rounded',
  --             relative = 'editor',
  --             row = center_y,
  --             col = center_x,
  --             width = window_w_int,
  --             height = window_h_int,
  --           }
  --         end,
  --       },
  --       width = function()
  --         local WIDTH_RATIO = 0.5 -- You can change this too
  --         return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
  --       end,
  --     },
  --     actions = {
  --       open_file = {
  --         quit_on_open = false
  --       }
  --     },
  --     update_focused_file = {
  --       enable = true,
  --       update_root = true,
  --     },
  --   },
  -- },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(tostring(vim.fn.argv(0)))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    cmd = "Neotree",
    keys = {
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = Util.get_root() })
        end,
        desc = "NeoTree",
      },
    },
    deactivate = function()
      vim.cmd([[ Neotree close ]])
    end,
    opts = {
      filesystem = {
        bind_to_cwd = true,
        follow_current_file = true,
      },
      window = {
        -- position = "left",
        mappings = {
          ["h"] = function(state)
            local node = state.tree:get_node()
            if node.type == "directory" and node:is_expanded() then
              require("neo-tree.sources.filesystem").toggle_directory(state, node)
            else
              require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
            end
          end,
          ["l"] = "open",
          ["L"] = "open_vsplit",
          ["<space>"] = "none",
          ["p"] = { "toggle_preview", config = { use_float = true } },
          ["<esc>"] = "revert_preview",
          ["C"] = "close_all_nodes",
          ["a"] = {
            "add",
            -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
            -- some commands may take optional config options, see `:h neo-tree-mappings` for details
            config = {
              show_path = "relative", -- "none", "relative", "absolute"
            },
          },
          ["d"] = "delete",
          ["r"] = "rename",
          ["y"] = "copy_to_clipboard",
          ["c"] = "copy",
          ["m"] = "move",
          ["q"] = "close_window",
          ["R"] = "refresh",
          ["?"] = "show_help",
          ["<"] = "prev_source",
          [">"] = "next_source",
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
  },

  -- search/replace in multiple files
  {
    "windwp/nvim-spectre",
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
  },

  -- smart finder
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false,
    keys = {
      { "<leader><space>", "<cmd>Telescope find_files<cr>",                          desc = "Find Files (root dir)" },
      ---- find
      { "<leader>fb",      "<cmd>Telescope buffers<cr>",                             desc = "Buffers" },
      --{ "<leader>fB", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
      { "<leader>fg",      "<cmd>Telescope live_grep<cr>",                           desc = "Find in Files (Grep)" },
      { "<leader>ff",      "<cmd>Telescope find_files<cr>",                          desc = "Find Files" },
      -- { "<leader>fF", Util.telescope("find_files", { cwd = false }), desc = "Find Files (root dir)" },
      -- { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      ---- git
      --{ "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
      --{ "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
      ---- search
      { "<leader>sa",      "<cmd>Telescope autocommands<cr>",                        desc = "Auto Commands" },
      { "<leader>sb",      "<cmd>Telescope current_buffer_fuzzy_find<cr>",           desc = "Buffer" },
      { "<leader>sc",      "<cmd>Telescope command_history<cr>",                     desc = "Command History" },
      { "<leader>sC",      "<cmd>Telescope commands<cr>",                            desc = "Commands" },
      { "<leader>sd",      "<cmd>Telescope diagnostics<cr>",                         desc = "Diagnostics" },
      -- { "<leader>sg", Util.telescope("live_grep"), desc = "Grep (root dir)" },
      -- { "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
      { "<leader>sh",      "<cmd>Telescope help_tags<cr>",                           desc = "Help Pages" },
      { "<leader>sH",      "<cmd>Telescope highlights<cr>",                          desc = "Search Highlight Groups" },
      { "<leader>sk",      "<cmd>Telescope keymaps<cr>",                             desc = "Key Maps" },
      { "<leader>sM",      "<cmd>Telescope man_pages<cr>",                           desc = "Man Pages" },
      { "<leader>sm",      "<cmd>Telescope marks<cr>",                               desc = "Jump to Mark" },
      { "<leader>so",      "<cmd>Telescope vim_options<cr>",                         desc = "Options" },
      -- { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
      -- { "<leader>sw", Util.telescope("grep_string"), desc = "Word (root dir)" },
      -- { "<leader>sW", Util.telescope("grep_string", { cwd = false }), desc = "Word (cwd)" },
      { "<leader>fc",      Util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
    },
    opts = {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        file_ignore_patterns = { "__pycache__" },
        mappings = {
          i = {
            ["<c-t>"] = function(...)
              return require("trouble.providers.telescope").open_with_trouble(...)
            end,
            ["<a-t>"] = function(...)
              return require("trouble.providers.telescope").open_selected_with_trouble(...)
            end,
            ["<C-Down>"] = function(...)
              return require("telescope.actions").cycle_history_next(...)
            end,
            ["<C-Up>"] = function(...)
              return require("telescope.actions").cycle_history_prev(...)
            end,
            ["<C-d>"] = function(...)
              return require("telescope.actions").preview_scrolling_down(...)
            end,
            ["<C-u>"] = function(...)
              return require("telescope.actions").preview_scrolling_up(...)
            end,
            ["<leader>q"] = function(...)
              return require("telescope.actions").close(...)
            end,
          },
          n = {
            ["q"] = function(...)
              return require("telescope.actions").close(...)
            end,
          },
        },
      },
    },
  },
}
