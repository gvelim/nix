{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nixvim = {
    	url = "github:nix-community/nixvim";
    	inputs.nixpkgs.follows = "nixpkgs";
    };
 };

  outputs = { self, nixpkgs, flake-utils, nixvim } : 
    flake-utils.lib.eachDefaultSystem (system :
      let 
        pkgs = nixpkgs.legacyPackages.${system};
        name = "simple";
        src = ./.;
	nvim = nixvim.legacyPackages.${system}.makeNixvim {
	plugins.treesitter = {
	  enable = true;
	  settings = {
	     highlight.enable = true;
	     auto_install = true;
	  };
	  grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
	  bash
          json
          lua
          make
          markdown
          nix
          regex
          toml
          vim
          vimdoc
          xml
          yaml
	  ];
	  };
	  plugins.lsp.enable = true;
	  plugins.lsp.servers.nixd = {
	  	enable = true;
    		settings = {
        	  options.nixvim.expr = ''(builtins.getFlake "/path/to/flake").packages.${system}.neovimNixvim.options'';
    		};
	  };
	};
      in {
        packages.default = derivation {
            inherit system name src;
            builder = with pkgs; "${bash}/bin/bash";
            args = [ "-c" "echo foo > $out" ];
          };
	devShells.default = with pkgs ; mkShell {
	  buildInputs = [
	  	nixd 
		nvim
	  ];
	};
      }
    );
}
