ENV_NAME = urban-sounds
KERNEL_NAME = "Urban Sounds"

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

.PHONY: update_deps install_env register_kernel preview preview-website

update_deps:
	# Solve package dependencies
	conda-lock -f environment.yml  --micromamba -p linux-64 
install_env:
	# Update envrionment
	conda-lock install --micromamba --name $(ENV_NAME) conda-lock.yml
register_kernel:
	# Register jupyter lab kernel
	micromamba run -n $(ENV_NAME) python -m ipykernel install --user --name $(ENV_NAME) --display-name=$(KERNEL_NAME)
env: update_deps install_env register_kernel

wav-inspect.ipynb:
	micromamba run -n $(ENV_NAME) quarto render wav-inspect.qmd -t ipynb

# Preview the website
preview: preview-website

preview-website:
	@echo "Starting Quarto preview with command: $(QUARTO_CMD)"
	cd website && micromamba run -n $(ENV_NAME) $(QUARTO_CMD)

# Build the website
build-website:
	cd website && micromamba run -n $(ENV_NAME) quarto render
