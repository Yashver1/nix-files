local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local i = ls.insert_node
local t = ls.text_node
local d = ls.dynamic_node
local f = ls.function_node
local fmta = require("luasnip.extras.fmt").fmta

local function matrix_cells(_, snip)
  local rows = tonumber(snip.captures[2])
  local cols = tonumber(snip.captures[3])
  local nodes = {}
  local idx = 1
  for r = 1, rows do
    for c = 1, cols do
      table.insert(nodes, i(idx))
      idx = idx + 1
      if c < cols then
        table.insert(nodes, t(" & "))
      end
    end
    if r < rows then
      table.insert(nodes, t({ " \\\\", "" }))
    end
  end
  return sn(nil, nodes)
end

return {
  s(
    { trig = "([bBpvV])mat(%d+)x(%d+)", regTrig = true, snippetType = "autosnippet" },
    fmta(
      [[
      \begin{<>matrix}
          <>
      \end{<>matrix}
    ]],
      {
        f(function(_, snip)
          return snip.captures[1]
        end),
        d(1, matrix_cells),
        f(function(_, snip)
          return snip.captures[1]
        end),
      }
    )
  ),
}
