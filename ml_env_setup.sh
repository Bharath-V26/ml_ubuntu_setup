#!/bin/bash

# Set environment variables
export PATH="$HOME/miniconda/bin:$PATH"

# Log file
LOG_FILE="ml_env_setup.log"
echo "Starting setup... (log: $LOG_FILE)"
echo "" > $LOG_FILE

# Function to log messages
log() {
    echo "$1" | tee -a $LOG_FILE
}

log "Step 1: Update system packages"
sudo apt update && sudo apt upgrade -y || { log "System update failed!"; exit 1; }

log "Step 2: Install development tools and libraries"
sudo apt install -y build-essential git curl wget unzip software-properties-common || { log "Development tools installation failed!"; exit 1; }

log "Step 3: Install Python 3.12"
sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt update
sudo apt install -y python3.12 python3-distutils python3.12-venv || { log "Python 3.12 installation failed!"; exit 1; }
sudo ln -sf /usr/bin/python3.12 /usr/bin/python3
log "Python 3.12 installed"

log "Step 4: Install pip for Python 3.12"
wget https://bootstrap.pypa.io/get-pip.py -O get-pip.py || { log "Failed to download get-pip.py!"; exit 1; }
python3.12 get-pip.py || { log "pip installation failed!"; exit 1; }
rm get-pip.py
log "pip installed for Python 3.12"

log "Step 5: Install Miniconda"
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O Miniconda3.sh || { log "Failed to download Miniconda!"; exit 1; }
bash Miniconda3.sh -b -p $HOME/miniconda || { log "Miniconda installation failed!"; exit 1; }
rm Miniconda3.sh
log "Miniconda installed"

log "Step 6: Initialize Conda"
conda init || { log "Failed to initialize Conda!"; exit 1; }
source ~/.bashrc || { log "Failed to source ~/.bashrc"; exit 1; }
log "Conda initialized"

log "Step 7: Create and activate Conda environment"
conda create -n ml-env python=3.12 -y || { log "Conda environment creation failed!"; exit 1; }
conda activate ml-env || { log "Failed to activate Conda environment!"; exit 1; }
log "Conda environment 'ml-env' created and activated"

log "Step 8: Install NVIDIA GPU drivers and CUDA toolkit"
sudo apt install -y nvidia-driver-525 || { log "NVIDIA driver installation failed!"; exit 1; }
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin || { log "Failed to download CUDA pin file!"; exit 1; }
sudo mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/3bf863cc.pub || { log "CUDA repository key download failed!"; exit 1; }
sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/ /"
sudo apt update
sudo apt install -y cuda || { log "CUDA toolkit installation failed!"; exit 1; }
log "NVIDIA GPU drivers and CUDA toolkit installed"

log "Step 9: Install TensorFlow and PyTorch"
pip install tensorflow || { log "TensorFlow installation failed!"; exit 1; }
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118 || { log "PyTorch installation failed!"; exit 1; }
log "TensorFlow and PyTorch installed"

log "Step 10: Install Jupyter Notebook and ML libraries"
pip install jupyter matplotlib pandas numpy scikit-learn || { log "Jupyter Notebook or ML libraries installation failed!"; exit 1; }
log "Jupyter Notebook and additional ML libraries installed"

log "Step 11: Install Docker and Docker Compose"
sudo apt install -y docker.io || { log "Docker installation failed!"; exit 1; }
sudo systemctl enable --now docker
sudo usermod -aG docker $USER || { log "Failed to add user to Docker group!"; exit 1; }
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose || { log "Failed to download Docker Compose!"; exit 1; }
sudo chmod +x /usr/local/bin/docker-compose
log "Docker and Docker Compose installed"

log "Step 12: Verify installations and summarize"

# Version checks
log "Versions:"
python --version >> $LOG_FILE
pip --version >> $LOG_FILE
conda --version >> $LOG_FILE
nvidia-smi >> $LOG_FILE
docker --version >> $LOG_FILE
docker-compose --version >> $LOG_FILE

log "\nSummary:"
python --version
pip --version
conda --version
nvidia-smi
docker --version
docker-compose --version

log "Setup completed successfully. Refer to $LOG_FILE for detailed logs."
