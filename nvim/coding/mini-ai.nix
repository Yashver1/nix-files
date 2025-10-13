{...}:{

plugins.mini-ai = {
  enable = true;
  luaConfig.content = ''
    local ai = require("mini.ai")
    ai.setup({
      n_lines = 500,
      custom_textobjects = {
        o = ai.gen_spec.treesitter({
          a = { "@block.outer", "@conditional.outer", "@loop.outer" },
          i = { "@block.inner", "@conditional.inner", "@loop.inner" },
        }),

        f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),

        c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),

        t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },

        d = { "%f[%d]%d+" },

        e = {
          { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
          "^().*()$",
        },

        g = {
          a = function()
            local last = vim.fn.line("$")
            local lastcol = math.max(vim.fn.getline(last):len(), 1)
            return { from = { line = 1, col = 1 }, to = { line = last, col = lastcol } }
          end,
          i = function()
            local last = vim.fn.line("$")
            local first_nonblank = 1
            while first_nonblank <= last and vim.fn.getline(first_nonblank):match("^%s*$") do
              first_nonblank = first_nonblank + 1
            end
            local last_nonblank = last
            while last_nonblank >= 1 and vim.fn.getline(last_nonblank):match("^%s*$") do
              last_nonblank = last_nonblank - 1
            end
            if first_nonblank > last_nonblank then
              return { from = { line = 1, col = 1 }, to = { line = 1, col = 1 } }
            end
            local lastcol = math.max(vim.fn.getline(last_nonblank):len(), 1)
            return { from = { line = first_nonblank, col = 1 }, to = { line = last_nonblank, col = lastcol } }
          end,
        },

        u = ai.gen_spec.function_call(),
        U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }),
      },
    })
  '';
};


}
