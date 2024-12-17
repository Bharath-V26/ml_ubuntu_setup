#!/bin/bash

# Update and upgrade the system packages
echo "Updating and upgrading system packages..."
sudo apt update && sudo apt upgrade -y

# Install Python 3 and essential packages
echo "Installing Python 3 and pip..."
sudo apt install python3 python3-pip python3-venv -y

# Create and activate a Python virtual environment
echo "Creating and activating a Python virtual environment..."
python3 -m venv ml-env
source ml-env/bin/activate

# Upgrade pip to the latest version
echo "Upgrading pip..."
pip install --upgrade pip

# Install machine learning libraries using pip
echo "Installing machine learning libraries..."
pip install numpy pandas scikit-learn matplotlib scipy jupyterlab

# Install TensorFlow and PyTorch
echo "Installing TensorFlow and PyTorch..."
pip install tensorflow torch

# Confirm installations
echo "Verifying installed packages..."
pip list

echo "Machine learning environment setup is complete!"
echo "Activate the environment by running: source ml-env/bin/activate"
echo "To deactivate, use: deactivate"
