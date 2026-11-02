return {
  "dchinmay2/godbolt.nvim",
  config = function(_, opts)
    vim.b.godbolt_exec = true
    local function godbolt_pick()
      local lang = ({ cpp = "c++", c = "c", rust = "rust" })[vim.bo.filetype]
          or vim.bo.filetype
      vim.system(
        { "curl", "-s", "https://godbolt.org/api/compilers/" .. lang },
        { text = true },
        vim.schedule_wrap(function(out)
          local lines = vim.split(out.stdout, "\n", { trimempty = true })
          table.remove(lines, 1) -- header row "Compiler Name | ..."
          require("fzf-lua").fzf_exec(lines, {
            prompt = "Godbolt> ",
            actions = {
              ["default"] = function(selected)
                local id = selected[1]:match("^(%S+)")
                vim.cmd("GodboltCompiler " .. id)
              end,
            },
          })
        end)
      )
    end
    vim.api.nvim_create_user_command("GodboltFzf", godbolt_pick, {})
  end
}
