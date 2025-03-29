---@alias dm.HlLine {text: string, hl: string}
---@alias dm.NodeRepr nil | dm.HlLine[]

---@class dm.NodeTrait Supposedly it should be template parameter to Tree but since lua-ls doesn't have good support for generics...
---@field expanded boolean
---@field id string
---@field get_children fun(self): dm.NodeTrait[]
---@field get_repr fun(self, depth): dm.NodeRepr


---@class dm.Tree
local Tree = {}

function Tree.new(buf, root)
  ---@class dm.Tree
  local self = setmetatable({}, {__index = Tree})
  self.buf = buf
  self.root = root
  self._nodes_by_line = {}
  self._nodes_by_id = {}
  self._ns_id = vim.api.nvim_create_namespace("")
  return self
end

function Tree.new_with_buf(root)
  return Tree.new(vim.api.nvim_create_buf(false, true), root)
end

function Tree:render()
  self._nodes_by_line = {}
  self._nodes_by_id = {}
  local lines = {}
  local highlights = {} -- {line, hl_group, start_col, end_col}
  local line_num = 0

  local function render_node(node, depth)
    local segments = node:get_repr(depth) or {}

    -- Build line text and highlights
    local line_text = ""
    local current_col = 0
    for _, seg in ipairs(segments) do
      line_text = line_text .. seg.text
      if seg.hl then
        table.insert(highlights, {
          line = line_num,
          hl = seg.hl,
          start = current_col,
          ["end"] = current_col + #seg.text
        })
      end
      current_col = current_col + #seg.text
    end

    -- Record node and advance line number
    table.insert(lines, line_text)
    self._nodes_by_line[line_num] = node
    self._nodes_by_id[node.id] = node
    line_num = line_num + 1

    -- Render children if expanded
    if node.expanded then
      for _, child in ipairs(node:get_children()) do
        render_node(child, depth + 1)
      end
    end
  end

  render_node(self.root, 0)

  -- Update buffer
  vim.api.nvim_buf_set_lines(self.buf, 0, -1, false, lines)
  vim.api.nvim_buf_clear_namespace(self.buf, self._ns_id, 0, -1)

  for _, h in ipairs(highlights) do
    vim.api.nvim_buf_add_highlight(
      self.buf,
      self._ns_id,
      h.hl,
      h.line,
      h.start,
      h["end"]
    )
  end
end

function Tree:node_by_line(linenr)
  return self._nodes_by_line[linenr]
end

function Tree:node_by_id(id)
  return self._nodes_by_id[id]
end


return Tree
