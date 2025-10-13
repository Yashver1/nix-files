{...}:{

	plugins.which-key = {
		enable = true;
		luaConfig = {
			content = ''
				local wk = require("which-key")
				      wk.setup({
					preset = "helix",
					spec = {
					  {
					    mode = { "n", "v" },
					    { "<leader><tab>", group = "tabs" },
					    { "<leader>c", group = "code" },
					    { "<leader>d", group = "debug" },
					    { "<leader>dp", group = "profiler" },
					    { "<leader>f", group = "file/find" },
					    { "<leader>g", group = "git" },
					    { "<leader>gh", group = "hunks" },
					    { "<leader>q", group = "quit/session" },
					    { "<leader>s", group = "search" },
					    { "<leader>u", group = "ui" },
					    { "<leader>x", group = "diagnostics/quickfix" },
					    { "[", group = "prev" },
					    { "]", group = "next" },
					    { "g", group = "goto" },
					    { "gs", group = "surround" },
					    { "z", group = "fold" },
					    {
					      "<leader>b",
					      group = "buffer",
					      expand = function()
						return require("which-key.extras").expand.buf()
					      end,
					    },
					    {
					      "<leader>w",
					      group = "windows",
					      proxy = "<c-w>",
					      expand = function()
						return require("which-key.extras").expand.win()
					      end,
					    },
					    -- better descriptions
					    { "gx", desc = "Open with system app" },
					  },
					},
				      })

				      vim.keymap.set("n", "<leader>?", function()
					require("which-key").show({ global = false })
				      end, { desc = "Buffer Keymaps (which-key)" })

				      vim.keymap.set("n", "<c-w><space>", function()
					require("which-key").show({ keys = "<c-w>", loop = true })
				      end, { desc = "Window Hydra Mode (which-key)" })

				local i = {
				    [" "] = "Whitespace",
				    ['"'] = 'Balanced "',
				    ["'"] = "Balanced '",
				    ["`"] = "Balanced `",
				    ["("] = "Balanced (",
				    [")"] = "Balanced ) including white-space",
				    [">"] = "Balanced > including white-space",
				    ["<lt>"] = "Balanced <",
				    ["]"] = "Balanced ] including white-space",
				    ["["] = "Balanced [",
				    ["}"] = "Balanced } including white-space",
				    ["{"] = "Balanced {",
				    ["?"] = "User Prompt",
				    _ = "Underscore",
				    a = "Argument",
				    b = "Balanced ), ], }",
				    c = "Class",
				    d = "Digit(s)",
				    e = "Word in CamelCase & snake_case",
				    f = "Function",
				    g = "Entire file",
				    i = "Indent",
				    o = "Block, conditional, loop",
				    q = "Quote `, \", '",
				    t = "Tag",
				    u = "Use/call function & method",
				    U = "Use/call without dot in name",
				  }
				  local a = vim.deepcopy(i)
				  for k, v in pairs(a) do
				    a[k] = v:gsub(" including.*", "")
				  end

				  local ic = vim.deepcopy(i)
				  local ac = vim.deepcopy(a)
				  for key, name in pairs({ n = "Next", l = "Last" }) do
				    i[key] = vim.tbl_extend("force", { name = "Inside " .. name .. " textobject" }, ic)
				    a[key] = vim.tbl_extend("force", { name = "Around " .. name .. " textobject" }, ac)
				  end
				  require("which-key").register({
				    mode = { "o", "x" },
				    i = i,
				    a = a,
				  })

				 '';

		};


	};

}
