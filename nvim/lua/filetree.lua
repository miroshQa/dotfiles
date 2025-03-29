local Tree = require("tree")

---@class FileNode: dm.NodeTrait
local FileNode = {}
FileNode.__index = FileNode

function FileNode.new(path, name)
  ---@class FileNode
  local self = setmetatable({}, FileNode)
  self.path = path
  self.name = name or vim.fn.fnamemodify(path, ":t")
  self.expanded = false
  self.children = nil
  self.id = path
  return self
end

function FileNode:is_expandable()
  return vim.fn.isdirectory(self.path) == 1
end

function FileNode:get_children()
  if self.children == nil then
    self.children = {}
    local handle = vim.uv.fs_scandir(self.path)
    while handle do
      local name, type = vim.uv.fs_scandir_next(handle)
      if not name then break end
      if name ~= "." and name ~= ".." then
        local child_path = self.path .. "/" .. name
        table.insert(self.children, FileNode.new(child_path, name))
      end
    end
  end
  return self.children
end

function FileNode:get_repr(depth)
  local indent = string.rep("  ", depth)
  local icon = self:is_expandable() and "📁 " or "📄 "
  local hl = self:is_expandable() and "Directory" or "File"
  local indicator = self:is_expandable() and (self.expanded and "▼ " or "▶ ") or "  "
  return {
    { text = indent,            hl = nil },
    { text = indicator,         hl = "TreeMarker" },
    { text = icon .. self.name, hl = hl }
  }
end

-- Example usage:
local function create_file_tree()
  -- Create root node
  local root_path = vim.fn.getcwd()
  local root = FileNode.new(root_path)

  -- Create and render tree
  local tree = Tree.new_with_buf(root)
  tree:render()

  -- Display buffer
  vim.api.nvim_command("vsplit")
  vim.api.nvim_win_set_buf(0, tree.buf)

  local function toggle_node(line)
    local node = tree:node_by_line(line)
    if node and node:is_expandable() then
      node.expanded = not node.expanded
      tree:render()
    end
  end

  -- Set up keymaps
  vim.api.nvim_buf_set_keymap(tree.buf, "n", "<CR>", "", {
    callback = function()
      local line = vim.api.nvim_win_get_cursor(0)[1] - 1 -- 0-based
      toggle_node(line)
    end
  })

  -- Modify the create_file_or_dir function to include cursor movement
  local function create_file_or_dir(is_dir)
    return function()
      local line = vim.api.nvim_win_get_cursor(0)[1] - 1 -- 0-based
      local node = tree:node_by_line(line)
      if not node then return end

      -- Determine parent directory
      local parent_path = node.path
      local parent_node = node
      if not node:is_expandable() then
        parent_path = vim.fn.fnamemodify(node.path, ":h")
        parent_node = tree:node_by_id(parent_path)
      end

      -- Get new item name
      local prompt = is_dir and "New directory name: " or "New file name: "
      local name = vim.fn.input(prompt)
      if name == "" then return end

      -- Create filesystem entry
      local new_path = parent_path .. "/" .. name
      -- ... (existing creation code remains the same) ...

      -- Update tree structure
      if parent_node then
        parent_node.children = nil
        parent_node.expanded = true
      end

      tree:render()

      -- Find and move to new node
      local new_line
      for l = 0, vim.api.nvim_buf_line_count(tree.buf) - 1 do
        local n = tree:node_by_line(l)
        if n and n.id == new_path then
          new_line = l
          break
        end
      end

      if new_line then
        -- Convert to 1-based line number and set cursor
        vim.api.nvim_win_set_cursor(0, { new_line + 1, 0 })
      end

      vim.notify(("Created %s: %s"):format(is_dir and "directory" or "file", new_path))
    end
  end

  vim.api.nvim_buf_set_keymap(tree.buf, "n", "a", "", {
    callback = create_file_or_dir(false)
  })

  vim.api.nvim_buf_set_keymap(tree.buf, "n", "A", "", {
    callback = create_file_or_dir(true)
  })
end

-- Define highlights
vim.cmd [[
  highlight TreeMarker guifg=#FFA500
  highlight Directory guifg=#569CD6
  highlight File guifg=#FFFFFF
]]


create_file_tree()
