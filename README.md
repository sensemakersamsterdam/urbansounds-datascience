# Urban Sounds Data Science

[![Python 3.12](https://img.shields.io/badge/python-3.12-blue.svg)](https://www.python.org/downloads/)
[![Quarto](https://img.shields.io/badge/Made%20with-Quarto-blue.svg)](https://quarto.org/)

## Table of Contents

- [About the Project](#about-the-project)
- [Objectives](#objectives)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Project Structure](#project-structure)
- [Development Workflow](#development-workflow)
- [Makefile Commands](#makefile-commands)
- [Contributing](#contributing)
- [License](#license)

## About the Project

This repository contains analysis about a citizen science on urban sound classification.

## Objectives

- Share analysis and restults on a website
- Share code
- Shere reproduclible computation environment


## Prerequisites

Before getting started, ensure you have the following installed on your system:

### Required Software
- **Operating System**: Linux or macOS (Windows with WSL2 should work)
- **Python**: 3.12 (managed via conda/micromamba)
- **Conda/Micromamba**: For environment management
- **Quarto**: For rendering notebooks and building the website
- **Make**: For running build commands
- **Git**: For version control
- **Git LFS**: For large file storage (audio samples)

### Optional (Recommended)
- **CUDA-capable GPU**: For faster model inference
- **Jupyter Lab**: For interactive notebook development

## Installation

### 1. Install System Dependencies

#### On Ubuntu/Debian:
```bash
sudo apt update
sudo apt install build-essential git git-lfs
```

#### On macOS:
```bash
# Install Homebrew if not already installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install git git-lfs
```

### On Arch Linux

```bash
sudo pacman -Syu base-devel git git-lfs
```

### 2. Install Micromamba

Micromamba is a lightweight conda package manager that simplifies environment management. You can install it using the following command:


```bash
# Download and install micromamba
"${SHELL}" <(curl -L micro.mamba.pm/install.sh)
# Restart your shell or run: source ~/.bashrc
```

### 3. Install Quarto
Visit [quarto.org](https://quarto.org/docs/get-started/) and follow the installation instructions for your operating system.

### 4. Clone the Repository
```bash
git clone https://github.com/sensemakersamsterdam/urbansounds-datascience.git
cd urbansounds-datascience
git lfs install
git lfs pull
```

### 5. Set Up the Environment
```bash
# Create and install the complete environment
make env

# This runs:
# - make update_deps    (solve dependencies with conda-lock)
# - make install_env    (install environment)
# - make register_kernel (register Jupyter kernel)
```

## Quick Start

Once installation is complete, you can start exploring:

```bash
# Activate the environment
micromamba activate urban-sounds

# Start Jupyter Lab for interactive development
make jupyter

# Preview the website locally
make preview

# Build the website
make build

# Deploy to Netlify (requires setup)
make deploy
```

## Project Structure

```
urban-sounds/
├── data/                   # Audio data and datasets
│   ├── samples/           # 800+ WAV files with spectrograms
│   └── processed/         # Processed datasets
├── website/               # Quarto website source
│   ├── explore/          # Analysis notebooks
│   ├── _quarto.yml       # Website configuration
│   └── *.qmd             # Website pages
├── public/               # Built website (generated)
├── notebooks/            # Jupyter notebooks for experimentation
├── config.py             # Central configuration file
├── environment.yml       # Conda environment specification
├── Makefile              # Build automation
└── README.md             # This file
```

## Development Workflow

The typical development workflow involves:

1. **Environment Setup**: Use `make env` to set up dependencies
2. **Exploration**: Work with Jupyter notebooks in the `urban-sounds` environment
3. **Analysis**: Create or modify Quarto documents in `website/explore/`
4. **Website Building**: Use `make build` to render the website
5. **Preview**: Use `make preview` to view changes locally
6. **Deployment**: Use `make deploy` to publish to Netlify

### Working with Notebooks
- Use the "Urban Sounds" kernel in Jupyter Lab
- Import configuration: `from config import SAMPLES_DIR, DATA_DIR, MODELS`
- Store analysis notebooks in `website/explore/` as `.qmd` files

### Building and Previewing
- **Local preview**: `make preview` (with hot reload)
- **Build website**: `make build` (outputs to `public/`)
- **Clean builds**: `make clean` (preserves cache) or `make clean-all` (removes cache)

## Makefile Commands

Run `make help` to see all available commands:

```bash
# Environment management
make env              # Complete environment setup
make update_deps      # Update dependencies with conda-lock
make install_env      # Install conda environment
make register_kernel  # Register Jupyter kernel

# Development
make preview          # Preview website with auto-reload
make jupyter          # Start Jupyter Lab

# Building
make build            # Build website to public/ directory
make clean            # Clean build artifacts (preserve cache)
make clean-all        # Deep clean including caches

# Deployment
make deploy           # Build and deploy to Netlify
```

## Contributing

[Placeholder for detailed contributing guidelines explaining how citizen scientists can participate in the project, including:
- How to contribute audio samples
- Guidelines for analysis and experimentation
- Code contribution standards
- Community guidelines and collaboration practices]

### Getting Started as a Contributor
1. Fork the repository
2. Set up your development environment using the installation guide
3. Explore the existing analyses in `website/explore/`
4. Run `make preview` to see the website locally
5. Make your contributions following the project structure

### Reporting Issues
Please use the GitHub issue tracker to report bugs or suggest enhancements.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

**Made with ❤️ by the urban sound analysis community**
