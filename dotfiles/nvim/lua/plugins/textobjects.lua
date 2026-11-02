return {
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	{
		{
			"nvim-mini/mini.ai",
			event = "VeryLazy",
			dependencies = {
				"folke/which-key.nvim",
			},
			opts = function()
				local ai = require("mini.ai")
				return {
					n_lines = 500,
					custom_textobjects = {
						o = ai.gen_spec.treesitter({ -- code block
							a = { "@block.outer", "@conditional.outer", "@loop.outer" },
							i = { "@block.inner", "@conditional.inner", "@loop.inner" },
						}),
						f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
						c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
						t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
						d = { "%f[%d]%d+" }, -- digits
						e = { -- word with case
							{
								"%u[%l%d]+%f[^%l%d]",
								"%f[%S][%l%d]+%f[^%l%d]",
								"%f[%P][%l%d]+%f[^%l%d]",
								"^[%l%d]+%f[^%l%d]",
							},
							"^().*()$",
						},
						g = function(ai_type) -- buffer
							local start_line, end_line = 1, vim.fn.line("$")
							if ai_type == "i" then
								-- skip first and last blank lines for `i` textobject
								local first_nonblank, last_nonblank =
									vim.fn.nextnonblank(start_line), vim.fn.prevnonblank(end_line)
								-- safe fallback for empty/blank buffers
								if first_nonblank ~= 0 and last_nonblank ~= 0 then
									start_line, end_line = first_nonblank, last_nonblank
								end
							end
							local to_col = math.max(vim.fn.getline(end_line):len(), 1)
							return { from = { line = start_line, col = 1 }, to = { line = end_line, col = to_col } }
						end,
						u = ai.gen_spec.function_call(), -- u for "Usage"
						U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
					},
				}
			end,
			config = function(_, opts)
				require("mini.ai").setup(opts)

				local ok, wk = pcall(require, "which-key")
				if ok then
					wk.add({
						mode = { "o", "x" },
						{ "a", group = "around" },
						{ "i", group = "inside" },
						{ "ao", desc = "Block (outer)" },
						{ "io", desc = "Block (inner)" },
						{ "af", desc = "Function (outer)" },
						{ "if", desc = "Function (inner)" },
						{ "ac", desc = "Class (outer)" },
						{ "ic", desc = "Class (inner)" },
						{ "at", desc = "Tag (outer)" },
						{ "it", desc = "Tag (inner)" },
						{ "ad", desc = "Digits (outer)" },
						{ "id", desc = "Digits (inner)" },
						{ "ae", desc = "Word with case (outer)" },
						{ "ie", desc = "Word with case (inner)" },
						{ "ag", desc = "Buffer (outer)" },
						{ "ig", desc = "Buffer (inner)" },
						{ "au", desc = "Usage (outer)" },
						{ "iu", desc = "Usage (inner)" },
						{ "aU", desc = "Usage without dot (outer)" },
						{ "iU", desc = "Usage without dot (inner)" },
					})
				end
			end,
		},
	},
}
