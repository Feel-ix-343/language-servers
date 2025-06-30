# Language Servers Collection

A comprehensive Nix flake providing a curated collection of language servers for development environments.

## Overview

This flake packages together the most commonly used language servers across different programming languages, making it easy to set up a complete development environment with LSP support.

## Usage

### Quick Start

```bash
# Enter development shell with all language servers
nix develop github:Feel-ix-343/language-servers

# Or use directly in your flake
{
  inputs = {
    language-servers.url = "github:Feel-ix-343/language-servers";
  };
  
  outputs = { self, nixpkgs, language-servers }: {
    devShells.default = nixpkgs.lib.mkShell {
      buildInputs = [ language-servers.packages.${system}.default ];
    };
  };
}
```

### Install as Package

```bash
# Install the language servers collection
nix profile install github:Feel-ix-343/language-servers

# Or build locally
nix build
```

### Use Specific Language Servers

```bash
# Run specific language servers
nix run github:Feel-ix-343/language-servers#pyright
nix run github:Feel-ix-343/language-servers#tsserver
nix run github:Feel-ix-343/language-servers#rust-analyzer
```

## Supported Language Servers

### Python
- **pyright** - Microsoft's fast Python type checker and language server
- **python-lsp-server (pylsp)** - Community-driven Python language server
- **jedi-language-server** - Language server based on Jedi
- **ruff-lsp** - Fast Python linter and formatter language server

### JavaScript/TypeScript
- **typescript-language-server** - Official TypeScript language server
- **vscode-langservers-extracted** - HTML, CSS, JSON, ESLint language servers

### Systems Programming
- **rust-analyzer** - Rust language server
- **gopls** - Official Go language server
- **clangd** - C/C++ language server
- **zls** - Zig language server

### Functional Programming
- **haskell-language-server** - Haskell language server
- **ocaml-lsp** - OCaml language server
- **elixir-ls** - Elixir language server
- **erlang-ls** - Erlang language server

### JVM Languages
- **jdt-language-server** - Java language server
- **kotlin-language-server** - Kotlin language server
- **metals** - Scala language server

### Other Languages
- **omnisharp-roslyn** - C# language server
- **phpactor** / **intelephense** - PHP language servers
- **ruby-lsp** / **solargraph** - Ruby language servers
- **sourcekit-lsp** - Swift language server
- **r-languageserver** - R language server
- **julia** - Julia (includes language server)
- **dart** - Dart language server

### Configuration & Markup
- **nil** / **nixd** - Nix language servers
- **lua-language-server** - Lua language server
- **yaml-language-server** - YAML language server
- **taplo** - TOML language server
- **lemminx** - XML language server
- **marksman** - Markdown language server
- **texlab** - LaTeX language server

### Web Development
- **tailwindcss-language-server** - Tailwind CSS language server
- **vscode-css-languageserver** - CSS/SCSS/Less language server
- **graphql-language-service** - GraphQL language server
- **@volar/vue-language-server** - Vue.js language server
- **svelte-language-server** - Svelte language server
- **@angular/language-server** - Angular language server
- **@prisma/language-server** - Prisma language server

### DevOps & Infrastructure
- **dockerfile-language-server** - Dockerfile language server
- **terraform-ls** - Terraform language server
- **ansible-language-server** - Ansible language server
- **sqlls** - SQL language server

### Shell & Scripting
- **bash-language-server** - Bash language server
- **powershell** - PowerShell language server

### Runtime Environments
- **deno** - Deno runtime with language server
- **bun** - Bun runtime with language server

## Editor Configuration

### Helix

Add to your `~/.config/helix/languages.toml`:

```toml
[[language]]
name = "python"
language-servers = ["pyright", "ruff"]

[language-server.pyright]
command = "pyright-langserver"
args = ["--stdio"]

[language-server.ruff]
command = "ruff-lsp"
```

### Neovim (with LSP)

```lua
-- Example configuration for nvim-lspconfig
local lspconfig = require('lspconfig')

-- Python
lspconfig.pyright.setup{}
lspconfig.ruff_lsp.setup{}

-- TypeScript
lspconfig.tsserver.setup{}

-- Rust
lspconfig.rust_analyzer.setup{}

-- Go
lspconfig.gopls.setup{}
```

### VS Code

Many of these language servers are automatically used by VS Code extensions. For manual configuration, add to your `settings.json`:

```json
{
  "python.languageServer": "Pylance",
  "typescript.preferences.includePackageJsonAutoImports": "auto"
}
```

## Development

### Building Locally

```bash
git clone https://github.com/Feel-ix-343/language-servers
cd language-servers
nix build
```

### Testing

```bash
# Test the development shell
nix develop

# Test specific language servers
nix run .#pyright -- --help
nix run .#tsserver -- --help
```

### Adding New Language Servers

1. Add the package to the `buildEnv` in `flake.nix`
2. Optionally add an app entry for easy access
3. Update this README with usage instructions
4. Test the build: `nix build`

## Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Add your language server to the flake
3. Update the README
4. Test the build
5. Submit a pull request

## License

MIT License - see LICENSE file for details.

## Related Projects

- [nixpkgs](https://github.com/NixOS/nixpkgs) - The source of all these language servers
- [Language Server Protocol](https://microsoft.github.io/language-server-protocol/) - The LSP specification
- [awesome-language-servers](https://github.com/langserver/awesome-language-servers) - Comprehensive list of language servers