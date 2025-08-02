# Qwen Project Context

This file provides context for the Qwen AI coding assistant about the current project.

## Project Name
Nix Playground and experimentation project

## Project Description
This project contains Nix expressions for configuring and managing a development environment. It includes configurations for various tools, packages, and system settings using the Nix package manager. It's used for learning Nix and experimenting with configurations.

## Key Technologies
- Nix
- Nix Flakes
- Nixpkgs

## Primary Language
- Nix expression language

## Project Structure
- `flake.nix`: Defines the flake inputs and outputs. This is the primary entry point for flake-based Nix commands.
- `default.nix`: The default Nix expression. Often used for compatibility with non-flake Nix commands or specific package definitions.
- `shell.nix`: Defines the development shell environment, typically used with `nix-shell` or `nix develop`.
- `gemini.nix`: Configuration related to Qwen, potentially defining Qwen-specific packages or settings.
- `qwen-code.nix`: Specific configuration for Qwen Code, likely setting up its development environment or integrating it.
- `test.nix`: Likely contains Nix code related to testing configurations or expressions.
- Other `.nix` files (`attrValues.nix`): Contain specific configurations, modules, or utility functions.

## Architecture / Patterns
- Declarative configuration using Nix expressions.
- Modularity: Configuration is split across multiple `.nix` files.
- Flake-based structure for reproducible environments and clear dependencies.

## Naming Conventions
- Nix files are named using `camelCase.nix` (e.g., `qwenCode.nix`) or `kebab-case.nix` (e.g., `shell.nix`). Consistency within the project is key. Prefer `kebab-case` for file names.
- Attribute names within Nix expressions should be descriptive and follow Nixpkgs conventions where applicable.

## Development Workflow
- Use `nix develop` to enter the development shell defined in `flake.nix` or `shell.nix`.
- Use `nix build .#<target>` to build specific outputs defined in `flake.nix`.
- Use `nix flake update` to update flake inputs (e.g., nixpkgs) to their latest versions.
- Use `nix flake check` to run checks defined in the flake.
- Use `nix eval` to evaluate Nix expressions for debugging.

## Common Commands
- `nix develop`: Enter the development environment.
- `nix build .#<targetName>`: Build a specific flake output (replace `<targetName>`).
- `nix flake show`: Show the flake structure and outputs.
- `nix flake update`: Update flake inputs.
- `nix flake check`: Run flake checks.
- `nix eval .#<attrPath>`: Evaluate a specific attribute in the flake.

## Linting / Formatting
- Use `nix fmt` to format Nix code if a formatter is configured in `flake.nix`.
- Use `statix check` for linting Nix code if available in the environment.
- Ensure proper indentation (typically 2 spaces) and alignment in Nix expressions.

## Guidance for Qwen
- This project uses Nix flakes as the primary method for managing dependencies and building.
- Always be mindful of Nix syntax, especially regarding lazy evaluation, attribute sets, and function definitions.
- Prefer using `pkgs.callPackage` or similar patterns for modularity when defining new packages or configurations.
- When suggesting changes, consider the project's structure and existing patterns in `.nix` files.
- If a task involves a new package or configuration, look for examples within the existing `.nix` files before proposing a new structure.
- Always ensure that suggested Nix code is syntactically correct and follows idiomatic Nix practices.
- If unsure about a Nixpkgs attribute or function, it's better to look it up or suggest a way to find it (e.g., `nix repl '<nixpkgs>'`) rather than guessing.