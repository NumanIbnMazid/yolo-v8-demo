#!/bin/bash

# Activate Conda environment
conda init bash
source ~/.bashrc
conda activate env

# Run inference
python main.py
# python inference.py
