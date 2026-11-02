return {
	"obsidian-nvim/obsidian.nvim",
	keys = {
		{
			"<leader>on",
			function()
				vim.ui.input({ prompt = "Note title: " }, function(title)
					if title and title ~= "" then
						vim.cmd({ cmd = "Obsidian", args = { "new", title } })
					end
				end)
			end,
			desc = "New Obsidian note",
		},
		{
			"<leader>oN",
			function()
				vim.ui.input({ prompt = "Note title: " }, function(title)
					if title and title ~= "" then
						vim.cmd({ cmd = "Obsidian", args = { "new_from_template", title, "IProperties" } })
					end
				end)
			end,
			desc = "New Obsidian note from IProperties template",
		},
		{ "<leader>oq", "<cmd>Obsidian quick_switch<cr>", desc = "Quick Switch" },
		{ "<leader>oo", "<cmd>Obsidian open<cr>", desc = "Open in Obsidian App" },
		{ "<leader>ob", "<cmd>Obsidian backlinks<cr>", desc = "Show Obsidian Backlinks" },
		{ "<leader>ot", "<cmd>Obsidian template<cr>", desc = "Insert Obsidian Template" },
		{ "<leader>os", "<cmd>Obsidian search<cr>", desc = "Search Obsidian Notes" },
		{ "<leader>ol", "<cmd>Obsidian link<cr>", desc = "Link Selection to Note", mode = "v" },
		{ "<leader>oe", "<cmd>Obsidian extract_note<cr>", desc = "Extract Selection to Note", mode = "v" },
	},
	opts = {
		legacy_commands = false,
		picker = {
			name = "fzf-lua",
		},
		workspaces = {
			{
				name = "personal",
				path = "/Users/yashver/Documents/FirstSync",
			},
		},
		templates = {
			folder = "Templates",
		},
		frontmatter = {
			enabled = false,
		},
		note_id_func = function(title)
			if title ~= nil and title ~= "" then
				return title
			else
				return tostring(os.time())
			end
		end,
	},
}
