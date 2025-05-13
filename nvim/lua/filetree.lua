local M = {}

local api = vim.api
local uv = vim.uv
local tree = require("tree")

-- rust like enums. similiar to typescript. 
-- https://github.com/jrop/u.nvim/blob/v2/examples/filetree.lua

---@alias dm.FileNode {kind: "file", path: string, parent: dm.FileTreeNode?}
---@alias dm.DirNode {kind: "directory", loaded: boolean, path: string, children: dm.FileTreeNode[], parent: dm.FileTreeNode?, expanded: boolean}
---@alias dm.FileTreeNode dm.FileNode | dm.DirNode

---@param root dm.DirNode
local reload_node = function(root)
  root.children = {}
  for name, type in vim.fs.dir(root.path) do
    ---@type dm.FileTreeNode
    local child = {
      kind = type,
      loaded = false,
      path = vim.fs.joinpath(root.path, name),
      parent = root
    }
    table.insert(root.children, child)
  end
  root.loaded = true
end


---@type fun(node: dm.FileTreeNode, depth: number, parent: dm.FileTreeNode?): dm.HlLine
local function renderer(node, depth, _)
  local dir_icon = node.expanded and " " or " "
  local icon = node.kind == "directory" and { dir_icon, "Directory" } or { " ", "File" }
  local indent = { string.rep(" ", depth * 2) }
  local name = { vim.fs.basename(node.path) }
  local segments = { indent, icon, name }
  return segments
end

---@class dm.IHasBuf
---@Field buf number

---@class dm.FileTree: dm.IHasBuf
local ftree = {
  buf = vim.api.nvim_create_buf(false, true),
  ---@type dm.TreeRenderSnapshot
  snapshot = nil,
  ---@type dm.DirNode
  root = {
    loaded = false,
    kind = "directory",
    path = assert(vim.uv.cwd())
  },
  ---@param self dm.FileTree
  refresh = function(self)
    self.snapshot = tree.render({
      root = self.root,
      buf = self.buf,
      renderer = renderer,
    })
  end,
  ---@param self any
  ---@return dm.FileTreeNode
  get_cur_node = function(self)
    local cursor = vim.api.nvim_win_get_cursor(0)
    local line = cursor[1] - 1
    return self.snapshot.nodes_by_line[line]
  end
}

-- The responsibility of this enityt is to provide view what can be openned and closed
local view = {
  win = -1,
  make_win_cfg = function()
    local height = math.ceil(math.min(vim.o.lines, math.max(20, vim.o.lines - 5)))
    local width = math.ceil(math.min(vim.o.columns, math.max(80, vim.o.columns - 10)))
    ---@type vim.api.keyset.win_config
    local cfg = {
      relative = "editor",
      border = "rounded",
      width = width,
      height = height,
      row = math.ceil(vim.o.lines - height) * 0.5 - 1,
      col = math.ceil(vim.o.columns - width) * 0.5 - 1
    }
    return cfg
  end,
  toggle = function(self)
    if api.nvim_win_is_valid(self.win) then
      api.nvim_win_close(self.win, true)
    else
      self.win = vim.api.nvim_open_win(ftree.buf, true, self.make_win_cfg())
    end
  end,
  model = ftree,
}

vim.keymap.set("n", "<CR>", function()
  local cur = ftree:get_cur_node()
  cur.expanded = not cur.expanded
  if cur.kind == "directory" and cur.expanded and not cur.loaded then
    reload_node(cur)
  elseif cur.kind == "file" then
    view:toggle()
    vim.cmd("e " .. cur.path)
  end
  ftree:refresh()
end, { buffer = ftree.buf })

vim.keymap.set("n", "a", function()
  local cur = ftree:get_cur_node()
  vim.ui.input({ prompt = "Enter file name: " }, function(res)
    local dest
    local to_reload
    if cur.kind == "directory" then
      dest = vim.fs.joinpath(cur.path, res)
      to_reload = cur
    elseif cur.kind == "file" then
      dest = vim.fs.joinpath(vim.fs.dirname(cur.path), res)
      to_reload = cur.parent
    end
    local _ = io.open(dest, "w")
    reload_node(to_reload)
    ftree:refresh()
  end)
end, { buffer = ftree.buf })


vim.keymap.set("n", "d", function()
  local cur = ftree:get_cur_node()
  local prompt = string.format("Remove %s? [y/n]", cur.path)
  vim.ui.input({ prompt = prompt }, function(res)
    if res == "y" or res == 'Y' then
      vim.fs.rm(cur.path)
      reload_node(cur.parent)
      ftree:refresh()
    end
  end)
end, { buffer = ftree.buf })


ftree:refresh()
function M.toggle()
  view:toggle()
end

return M
