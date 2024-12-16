#!/bin/bash

# Exit script on any error
set -e

echo "Starting Machine Learning Environment Setup on Ubuntu 22.04..."

# 1. Update System Packages
echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

# 2. Install Development Tools and Libraries
echo "Installing development tools and libraries..."
sudo apt install -y build-essential git curl wget unzip software-properties-common

# 3. Install Python 3.12
echo "Installing Python 3.12..."
sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt update
sudo apt install -y python3.12 python3.12-distutils python3.12-venv
sudo ln -sf /usr/bin/python3.12 /usr/bin/python3

echo "Installing pip for Python 3.12..."
wget https://bootstrap.pypa.io/get-pip.py
python3.12 get-pip.py
rm get-pip.py

# 4. Install Miniconda
echo "Installing Miniconda..."
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O Miniconda3.sh
bash Miniconda3.sh -b -p $HOME/miniconda
export PATH="$HOME/miniconda/bin:$PATH"
conda init bash
source ~/.bashrc

# Create Conda Environment
echo "Creating Conda environment..."
conda create -n ml-env python=3.12 -y
conda activate ml-env

# 5. Install NVIDIA GPU Drivers and CUDA Toolkit
echo "Installing NVIDIA GPU drivers and CUDA Toolkit..."
sudo apt install -y nvidia-driver-525
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin
sudo mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/3bf863cc.pub
sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/ /"
sudo apt update
sudo apt install -y cuda

# 6. Install TensorFlow and PyTorch
echo "Installing TensorFlow and PyTorch with GPU support..."
pip install tensorflow
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118

# 7. Install Jupyter Notebook and Additional ML Tools
echo "Installing Jupyter Notebook and additional Python libraries..."
pip install jupyter matplotlib pandas numpy scikit-learn

# 8. Install Docker and Docker Compose
echo "Installing Docker and Docker Compose..."
sudo apt install -y docker.io
sudo systemctl enable --now docker
sudo usermod -aG docker $USER

sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Verification
echo "Verifying installation..."
python --version
pip --version
conda --version
nvidia-smi
docker --version
docker-compose --version

echo "Machine Learning Environment Setup Complete!"

