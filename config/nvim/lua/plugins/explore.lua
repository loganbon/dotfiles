local Util = require("util")

return {
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
      vim.cmd([[Neotree close]])
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
      --"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
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
      --{ "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find Files (root dir)" },
      ---- find
      --{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      --{ "<leader>fB", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Find in Files (Grep)" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files (cwd)" },
      ---- { "<leader>fF", Util.telescope("find_files", { cwd = false }), desc = "Find Files (root dir)" },
      --{ "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      ---- git
      --{ "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
      --{ "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
      ---- search
      --{ "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
      --{ "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      --{ "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      --{ "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
      --{ "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
      ---- { "<leader>sg", Util.telescope("live_grep"), desc = "Grep (root dir)" },
      ---- { "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
      --{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      --{ "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
      --{ "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      --{ "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      --{ "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      --{ "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
      --{ "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
      ---- { "<leader>sw", Util.telescope("grep_string"), desc = "Word (root dir)" },
      ---- { "<leader>sW", Util.telescope("grep_string", { cwd = false }), desc = "Word (cwd)" },
      { "<leader>fc", Util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
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
            ["<C-f>"] = function(...)
              return require("telescope.actions").preview_scrolling_down(...)
            end,
            ["<C-b>"] = function(...)
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
