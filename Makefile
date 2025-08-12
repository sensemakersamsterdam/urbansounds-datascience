ENV_NAME = urban-sounds
KERNEL_NAME = "Urban Sounds"

# ANSI color codes
BLUE := \033[1;34m
GREEN := \033[1;32m
YELLOW := \033[1;33m
CYAN := \033[1;36m
PURPLE := \033[1;35m
RESET := \033[0m
BOLD := \033[1m

# Load local settings if available
-include .quarto-preview.env

# Build Quarto preview command with optional parameters
QUARTO_CMD = quarto preview
ifdef QUARTO_NO_BROWSER
    ifeq ($(QUARTO_NO_BROWSER),yes)
        QUARTO_CMD += --no-browser
    endif
endif
ifdef QUARTO_HOST
    ifneq ($(QUARTO_HOST),)
        QUARTO_CMD += --host $(QUARTO_HOST)
    endif
endif
ifdef QUARTO_PORT
    ifneq ($(QUARTO_PORT),)
        QUARTO_CMD += --port $(QUARTO_PORT)
    endif
endif
ifdef QUARTO_PREVIEW_ARGS
    ifneq ($(QUARTO_PREVIEW_ARGS),)
        QUARTO_CMD += $(QUARTO_PREVIEW_ARGS)
    endif
endif

.PHONY: help env update_deps install_env register_kernel jupyter preview preview-website build-website build clean clean-all deploy

# Default target
help:
	@echo -e "$(BOLD)$(CYAN)Urban Sounds Data Science - Available Make Targets$(RESET)"
	@echo -e "$(CYAN)══════════════════════════════════════════════════$(RESET)"
	@echo ""
	@printf "$(YELLOW)🔧 ENVIRONMENT MANAGEMENT$(RESET)\n"
	@echo -e "  $(GREEN)make env$(RESET)              Complete environment setup (deps + install + kernel)"
	@echo -e "  $(GREEN)make update_deps$(RESET)      Update dependencies with conda-lock"
	@echo -e "  $(GREEN)make install_env$(RESET)      Install conda environment from lockfile"
	@echo -e "  $(GREEN)make register_kernel$(RESET)  Register Jupyter kernel for the environment"
	@echo ""
	@printf "$(YELLOW)🧪 DEVELOPMENT$(RESET)\n"
	@echo -e "  $(GREEN)make jupyter$(RESET)          Start Jupyter Lab in urban-sounds environment"
	@echo -e "  $(GREEN)make preview$(RESET)          Preview website with auto-reload"
	@echo ""
	@printf "$(YELLOW)🏗️  BUILDING$(RESET)\n"
	@echo -e "  $(GREEN)make build$(RESET)            Build website to public/ directory"
	@echo -e "  $(GREEN)make clean$(RESET)            Remove build artifacts (preserves cache)"
	@echo -e "  $(GREEN)make clean-all$(RESET)        Deep clean including all caches"
	@echo ""
	@printf "$(YELLOW)🚀 DEPLOYMENT$(RESET)\n"
	@echo -e "  $(GREEN)make deploy$(RESET)           Build and deploy to Netlify"
	@echo ""
	@echo -e "$(PURPLE)💡 TIPS$(RESET)"
	@echo -e "  $(BLUE)•$(RESET) Run '$(GREEN)make env$(RESET)' first to set up your environment"
	@echo -e "  $(BLUE)•$(RESET) Use '$(GREEN)make preview$(RESET)' for development with hot reload"
	@echo -e "  $(BLUE)•$(RESET) Use '$(GREEN)make clean$(RESET)' between builds if you encounter issues"
	@echo -e "  $(BLUE)•$(RESET) All Python commands run in the '$(CYAN)urban-sounds$(RESET)' environment"
	@echo ""

# ============================================================================
# ENVIRONMENT MANAGEMENT
# ============================================================================

update_deps:
	@echo "🔄 Solving package dependencies with conda-lock..."
	conda-lock -f environment.yml  --micromamba -p linux-64 

install_env:
	@echo "📦 Installing conda environment from lockfile..."
	conda-lock install --micromamba --name $(ENV_NAME) conda-lock.yml

register_kernel:
	@echo "🔌 Registering Jupyter kernel..."
	micromamba run -n $(ENV_NAME) python -m ipykernel install --user --name $(ENV_NAME) --display-name=$(KERNEL_NAME)

env: update_deps install_env register_kernel
	@echo "✅ Environment setup complete! Run 'micromamba activate $(ENV_NAME)' to get started."

# ============================================================================
# DEVELOPMENT
# ============================================================================

jupyter:
	@echo "🚀 Starting Jupyter Lab in $(ENV_NAME) environment..."
	micromamba run -n $(ENV_NAME) jupyter lab

wav-inspect.ipynb:
	micromamba run -n $(ENV_NAME) quarto render wav-inspect.qmd -t ipynb

preview: preview-website
	@echo "💡 Tip: Press Ctrl+C to stop the preview server"

preview-website:
	@echo "🌐 Starting Quarto preview with auto-reload..."
	@echo "Preview will be available at: http://localhost:4200 (or shown port)"
	cd website && micromamba run -n $(ENV_NAME) $(QUARTO_CMD)

# ============================================================================
# BUILDING
# ============================================================================

build-website:
	@echo "🏗️ Building website to public/ directory..."
	cd website && micromamba run -n $(ENV_NAME) quarto render
	@echo "✅ Website built successfully in public/"

# Alias for build-website
build: build-website

clean:
	@echo "🧹 Cleaning build artifacts..."
	rm -rf public/
	@echo "✅ Clean complete (preserving .quarto cache and _freeze)"

clean-all:
	@echo "🧹 Deep cleaning all build artifacts and caches..."
	rm -rf public/
	rm -rf website/.quarto/
	rm -rf website/_freeze/
	rm -rf website/explore/.jupyter_cache/
	@echo "✅ Deep clean complete"

# ============================================================================
# DEPLOYMENT
# ============================================================================

deploy:
	@echo "🚀 Deploying to Netlify..."
	@./deploy.sh
