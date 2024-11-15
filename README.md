<p align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Neovim-mark.svg/1200px-Neovim-mark.svg.png" alt="Neovim" height="120">
  <h2 align="center">Neovim Manager</h2>
  <p align="center">A Neovim config manager CLI made with :heart:</p>
</p>

**Neovim Manager** is a Bash-based Command Line Interface (CLI) designed to simplify the management of [Neovim](https://neovim.io/) configurations. This tool enables you to effortlessly install, update, and organize your [Neovim](https://neovim.io/) setups.

> This project is WIP, and we welcome contributions!

## Features

- Neovim config selection using FZF
- Launching `system` and default config directly form the CLI
- Neovim manager config edition

## Prerequisites

Before using Neovim Manager, ensure you have the following installed:

- A Unix-like environment (Linux, macOS, or WSL on Windows)
- [Neovim](https://neovim.io) (v0.5 or later)
- [Git](https://git-scm.com)

## Installation

To install Neovim Manager, run one of the following commands in your terminal:

```bash
curl -sSL https://raw.githubusercontent.com/ajmasia/neovim-manager/main/install.sh | bash

# or

wget -qO- https://raw.githubusercontent.com/ajmasia/neovim-manager/main/install.sh | bash
```

## Usage

`neovim-manager -h` will display the help message:

Here you can see the available commands:

| Command             | Description                                |
| ------------------- | ------------------------------------------ |
| `nvim-manager`      | Launches the Neovim Manager CLI            |
| `nvim-manager sys`  | Launches the system Neovim config          |
| `nvim-manager def`  | Launches the default Neovim config         |
| `nvim-manager conf` | Edits the Neovim Manager config            |
| `nvim-manager sel`  | Launch the FZF selection of Neovim configs |

## Contributing

We welcome contributions! If you'd like to report bugs, suggest features, or contribute code:

1. Fork the repository.
2. Create a new branch for your feature or fix.
3. Submit a pull request.

For issues, use the [Issues tab](https://github.com/ajmasia/neovim-manager/issues).

## Development Setup

Clone the repository:

```bash
git clone https://github.com/ajmasia/neovim-manager.git
cd neovim-manager
```

Test the CLI locally:

```bash
./neovim-manager <command>
```

## Roadmap

- [ ] Improve install script
- [ ] Add update option to the CLI
- [ ] Add option no install [Lazyvim](https://www.lazyvim.org/installation) in a clean separated config

## License

This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for details.

## Acknowledgements

Thank you for using Neovim Manager! We hope this tool enhances your productivity and makes managing [Neovim](https://neovim.io/) configurations a breeze.

For questions or feedback, feel free to reach out via the [repository](https://github.com/ajmasia/neovim-manager).
