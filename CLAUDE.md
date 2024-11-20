# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This project focuses on **urban sound classification** using modern audio AI models, specifically CLAP (Contrastive Language-Audio Pretraining) and AST (Audio Spectrum Transformer) models. The work involves zero-shot audio classification of urban sound events across 9 categories: gunshot, moped alarm, moped, claxon, slamming door, screaming, motorcycle, talking, and music.

## Environment Setup

The project uses conda/micromamba for environment management:

```bash
# Install and setup the environment
make env

# Or run individual steps:
make update_deps     # Solve dependencies with conda-lock
make install_env     # Install environment
make register_kernel # Register Jupyter kernel
```

The environment (`urban-sounds`) includes PyTorch with CUDA 12.4, Hugging Face transformers, audio processing libraries (librosa, soundfile), and Jupyter ecosystem tools.

## Key Components

### Jupyter Notebooks
- **CLAP embeddings.ipynb**: Core CLAP model experiments and audio embeddings
- **Urban Sounds CLAP and AST with Huggingface pipelines 3.ipynb**: Comparison of CLAP and AST models using HF pipelines
- **Gigaspeech Dataset.ipynb**: Speech recognition experiments with Whisper
- **wav-inspect.ipynb**: Audio file analysis and inspection

### Quarto Documents
- **wav-inspect.qmd**: Source for wav analysis (renders to .ipynb via `quarto render wav-inspect.qmd -t ipynb`)
- **trying-zero-shot-classification.qmd**: Zero-shot classification experiments

### Website
Located in `website/` directory, built with Quarto:
- Outputs to `../public/`
- Contains datasets overview, exploration results, and project documentation

## Data Configuration

**CRITICAL: Always import and use the central configuration:**
```python
from config import SAMPLES_DIR, DATA_DIR, MODELS, HF_DATASETS, URBAN_SOUNDS_LABELS
```

**Data Structure:**
```
data/
├── samples/     # 800+ WAV audio files with PNG spectrograms (moved from samples/)
├── archives/    # Compressed datasets (wetransfer archives)
├── processed/   # Processed/transformed datasets
└── cache/       # Hugging Face datasets cache
```

**Key Constants (from config.py):**
- `SAMPLES_DIR` - Local audio samples directory
- `HF_DATASETS` - Hugging Face dataset names
- `MODELS` - Model identifiers for CLAP, AST, Whisper
- `URBAN_SOUNDS_LABELS` - Class label mappings
- `DEVICE` - Auto-detected CUDA/CPU device

## Model Architecture

The project primarily uses:
- **CLAP models**: `laion/larger_clap_general` and `laion/larger_clap_music_and_speech` for zero-shot audio classification
- **AST model**: `MIT/ast-finetuned-audioset-10-10-0.4593` for transformer-based audio classification  
- **Whisper**: `openai/whisper-medium.en` for speech recognition tasks

## Development Workflow

1. Use micromamba to activate the `urban-sounds` environment
2. Work with Jupyter notebooks for experimentation
3. Convert Quarto documents to notebooks when needed
4. Use the registered "Urban Sounds" kernel in Jupyter
5. Audio samples are pre-processed and stored as WAV+PNG pairs in `samples/`

## Common Commands

**IMPORTANT: Always use the urban-sounds environment for Python scripts:**

```bash
# Environment management
micromamba activate urban-sounds

# Run Python scripts
micromamba run -n urban-sounds python script.py

# Run Jupyter notebooks
micromamba run -n urban-sounds jupyter lab

# Render Quarto to notebook
micromamba run -n urban-sounds quarto render wav-inspect.qmd -t ipynb

# Build website (from website/ directory)
quarto render

# Test configuration
micromamba run -n urban-sounds python example_data_usage.py
```

**Data Migration Completed:** All notebooks and scripts now use centralized configuration from `config.py`. The data directory structure has been reorganized and all hardcoded paths have been replaced with config constants.