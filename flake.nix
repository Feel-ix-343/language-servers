{
  description = "A comprehensive collection of language servers for development";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages = {
          # Language servers collection
          language-servers = pkgs.buildEnv {
            name = "language-servers";
            paths = with pkgs; [
              # Python
              pyright
              python3Packages.python-lsp-server  # pylsp
              python3Packages.jedi-language-server
              ruff  # Ruff LSP functionality is built into ruff itself
              
              # JavaScript/TypeScript
              nodePackages.typescript-language-server
              nodePackages.vscode-langservers-extracted  # HTML, CSS, JSON, ESLint
              
              # Rust
              rust-analyzer
              
              # Go
              gopls
              
              # C/C++
              clang-tools  # clangd
              
              # Nix
              nil
              nixd
              
              # Lua
              lua-language-server
              
              # Haskell
              haskell-language-server
              
              # Java
              jdt-language-server
              
              # C#
              omnisharp-roslyn
              
              # PHP
              phpactor
              # intelephense # Unfree license - remove or enable unfree packages if needed
              
              # Ruby
              ruby-lsp
              solargraph
              
              # Swift
              sourcekit-lsp
              
              # Kotlin
              kotlin-language-server
              
              # Scala
              metals
              
              # OCaml
              ocamlPackages.ocaml-lsp
              
              # Elixir
              elixir-ls
              
              # Erlang
              erlang-ls
              
              # Zig
              zls
              
              # Dart
              dart
              
              # R
              # r-languageserver # Package not found in nixpkgs
              
              # Julia
              julia-lts  # includes language server
              
              # Bash
              nodePackages.bash-language-server
              
              # YAML
              yaml-language-server
              
              # TOML
              taplo
              
              # XML
              lemminx
              
              # CSS/SCSS/Less (and HTML, JSON, ESLint)
              # nodePackages.vscode-css-languageserver-bin # Removed, replaced by vscode-langservers-extracted above
              
              # Tailwind CSS
              tailwindcss-language-server
              
              # GraphQL
              nodePackages.graphql-language-service-cli
              
              # Dockerfile
              dockerfile-language-server-nodejs
              
              # LaTeX
              texlab
              
              # Markdown
              marksman
              
              # SQL
              sqls
              
              # Terraform
              terraform-ls
              
              # Ansible
              ansible-language-server
              
              # PowerShell
              powershell
              
              # Vue
              nodePackages."@volar/vue-language-server"
              
              # Svelte
              nodePackages.svelte-language-server
              
              # Angular
              angular-language-server
              
              # Prisma
              # nodePackages."@prisma/language-server" # Package has been removed as broken
              
              # Deno
              deno
              
              # Bun
              bun
            ];
          };
          
          default = self.packages.${system}.language-servers;
        };

        # Development shell with all language servers
        devShells.default = pkgs.mkShell {
          buildInputs = [ self.packages.${system}.language-servers ];
          
          shellHook = ''
            echo "Language servers environment loaded!"
            echo "Available language servers:"
            echo "  Python: pyright, pylsp, jedi-language-server, ruff-lsp"
            echo "  JavaScript/TypeScript: typescript-language-server"
            echo "  Rust: rust-analyzer"
            echo "  Go: gopls"
            echo "  C/C++: clangd"
            echo "  Nix: nil, nixd"
            echo "  Lua: lua-language-server"
            echo "  Haskell: haskell-language-server"
            echo "  Java: jdt-language-server"
            echo "  And many more..."
          '';
        };

        # Apps for easy access
        apps = {
          # Python
          pyright = flake-utils.lib.mkApp {
            drv = pkgs.pyright;
            exePath = "/bin/pyright-langserver";
          };
          
          pylsp = flake-utils.lib.mkApp {
            drv = pkgs.python-lsp-server;
            exePath = "/bin/pylsp";
          };
          
          # TypeScript
          tsserver = flake-utils.lib.mkApp {
            drv = pkgs.nodePackages.typescript-language-server;
            exePath = "/bin/typescript-language-server";
          };
          
          # Rust
          rust-analyzer = flake-utils.lib.mkApp {
            drv = pkgs.rust-analyzer;
            exePath = "/bin/rust-analyzer";
          };
          
          # Go
          gopls = flake-utils.lib.mkApp {
            drv = pkgs.gopls;
            exePath = "/bin/gopls";
          };
          
          # Default app
          default = self.apps.${system}.pyright;
        };
      });
}