vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local lib = require('nvim-tree.lib')
local view = require('nvim-tree.view')
local open = require('nvim-tree.actions.node.open-file')

local function collapse_all()
  require("nvim-tree.actions.tree-modifiers.collapse-all").fn()
end

local function partial(f, x)
  return function(...)
    return f(x, ...)
  end
end

local function open_node(action)
  local node = lib.get_node_at_cursor()

  if node.link_to and not node.nodes then
      open.fn(action, node.link_to)
      view.close()
  elseif node.nodes ~= nil then
      lib.expand_or_collapse(node)
  else
      open.fn(action, node.absolute_path)
      view.close()
  end
end

local function open_nvim_tree(data)
  -- buffer is a [No Name]
  local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not no_name and not directory then
    return
  end

  -- change to the directory
  if directory then
    vim.cmd.cd(data.file)
  end

  -- open the tree
  require("nvim-tree.api").tree.open()
end

local HEIGHT_RATIO = 0.8  -- You can change this
local WIDTH_RATIO = 0.5   -- You can change this too
require('nvim-tree').setup({
  hijack_cursor = true,
  update_cwd = false,
  reload_on_bufenter = true,
  view = {
    mappings = {
      custom_only = false,
      list = {
        { key = 'l', action = 'edit', action_cb = partial(open_node, 'edit') },
        { key = 'L', action = 'vsplit_preview', action_cb = partial(open_node, 'vsplit') },
        { key = 'h', action = 'close_node' },
        { key = 'H', action = 'collapse_all', action_cb = collapse_all }
      }
    },
    float = {
      enable = true,
      open_win_config = function()
        local screen_w = vim.opt.columns:get()
        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
        local window_w = screen_w * WIDTH_RATIO
        local window_h = screen_h * HEIGHT_RATIO
        local window_w_int = math.floor(window_w)
        local window_h_int = math.floor(window_h)
        local center_x = (screen_w - window_w) / 2
        local center_y = ((vim.opt.lines:get() - window_h) / 2)
                         - vim.opt.cmdheight:get()
        return {
          border = 'rounded',
          relative = 'editor',
          row = center_y,
          col = center_x,
          width = window_w_int,
          height = window_h_int,
        }
        end,
    },
    width = function()
      return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
    end,
  },
  actions = {
    open_file = {
      quit_on_open = false
    }
  },
  update_focused_file = {
    enable = true,
    update_root = true,
  },
})

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
