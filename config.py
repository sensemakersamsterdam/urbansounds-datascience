"""
Urban Sounds Project Configuration

Central configuration for data paths, models, and constants.
Import this in all notebooks and scripts to ensure consistency.
"""
from pathlib import Path
import os

# Project root directory (where this config.py file is located)
PROJECT_ROOT = Path(__file__).parent

# Data directories
DATA_DIR = PROJECT_ROOT / "data"
SAMPLES_DIR = DATA_DIR / "samples"
ARCHIVES_DIR = DATA_DIR / "archives"
PROCESSED_DIR = DATA_DIR / "processed"
CACHE_DIR = DATA_DIR / "cache"

# Ensure directories exist
for dir_path in [DATA_DIR, SAMPLES_DIR, ARCHIVES_DIR, PROCESSED_DIR, CACHE_DIR]:
    dir_path.mkdir(parents=True, exist_ok=True)

# Hugging Face datasets
HF_DATASETS = {
    "urban_sounds_ii": "MichielBontenbal/UrbanSoundsII",
    "esc50": "ashraq/esc50", 
    "gigaspeech": "speechcolab/gigaspeech",
    "urban_sounds_small": "UrbanSounds/urban_sounds_small"
}

# Model configurations
MODELS = {
    "clap_music_speech": "laion/larger_clap_music_and_speech",
    "clap_general": "laion/larger_clap_general", 
    "ast": "MIT/ast-finetuned-audioset-10-10-0.4593",
    "whisper": "openai/whisper-medium.en"
}

# Device configuration (try CUDA, fallback to CPU)
import torch
DEVICE = "cuda:0" if torch.cuda.is_available() else "cpu"

# Label mappings for urban sounds classification
URBAN_SOUNDS_LABELS = {
    0: 'Gunshot',
    1: 'Moped alarm', 
    2: 'Moped',
    3: 'Claxon',
    4: 'Slamming door',
    5: 'Screaming', 
    6: 'Motorcycle',
    7: 'Talking',
    8: 'Music'
}

URBAN_SOUNDS_LABELS_LIST = list(URBAN_SOUNDS_LABELS.values())

# Extended labels for some experiments
EXTENDED_LABELS = URBAN_SOUNDS_LABELS_LIST + ['Silence', 'Background noise']

# Cache directory for Hugging Face datasets
os.environ["HF_DATASETS_CACHE"] = str(CACHE_DIR)