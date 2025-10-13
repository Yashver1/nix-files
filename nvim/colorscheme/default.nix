{pkgs,...}: {

	extraPlugins = [(pkgs.vimUtils.buildVimPlugin {
	    name = "vague";
	    src = pkgs.fetchFromGitHub {
		owner = "vague-theme";
		repo = "vague.nvim";
		rev = "cdbfdc8cc1122b8aa9609a7a681c5c501976a387";
		hash = "sha256-bUFTpI5sKmA3qktISFZH5pHLRE57lqClZPp5AfFd/ac=";
	}; 
	})];

	extraConfigLua = ''
		Color = function(color)
		  vim.cmd.colorscheme(color)
		  vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
		  vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
		  vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
		  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		  vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#252530", bg = "none" })

		  vim.diagnostic.config({
		    float = { border = "rounded" },
		    underline = true,
		    signs = true,
		    update_in_insert = false,
		  })
		end

		require("vague").setup({
			Color("vague"),
		})
	'';

}


