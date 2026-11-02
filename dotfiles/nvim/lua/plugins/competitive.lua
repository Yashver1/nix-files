return {
  'xeluxee/competitest.nvim',
  dependencies = 'MunifTanjim/nui.nvim',
  opts = {
    received_problems_path = "$(HOME)/workspace/competitive-programming/$(JUDGE)/$(CONTEST)/$(PROBLEM).$(FEXT)",
    received_contests_directory = "$(HOME)/workspace/competitive-programming/$(JUDGE)/$(CONTEST)",
    received_contests_problems_path = "$(PROBLEM)/main.$(FEXT)",
    template_file = "~/workspace/competitive-programming/template/file.$(FEXT)",
    compile_command = {
      cpp = {
        exec = "g++",
        args = {
          "-I/Users/yashver/.config/cp-headers",
          "-Wall", "$(FNAME)", "-o", "$(FNOEXT)"
        }
      }
    }
  },
  config = function(_, opts) require('competitest').setup(opts) end,
}
