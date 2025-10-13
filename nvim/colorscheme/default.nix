{pkgs,...}: {

       extraPlugins = [(pkgs.vimUtils.buildVimPlugin {
	    name = "vague";
	    src = pkgs.fetchFromGitHub {
		owner = "vage";
		repo = "<repo>";
		rev = "<commit hash>";
		hash = "<nix NAR hash>";
	};
       })];

}
