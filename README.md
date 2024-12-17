**Machine Learning Environment Setup on Ubuntu 22.04**

This guide outlines the steps to set up a machine learning environment on Ubuntu 22.04 using pip for package management. It includes installing essential tools, libraries, and GPU-specific configurations for PyTorch and TensorFlow.

**Prerequisites**
> Ubuntu 22.04 system with sudo privileges.
> NVIDIA GPU (for GPU-specific configurations).
> Stable internet connection.

**Overview**
This repository contains a bash script to automate the setup of a machine learning environment on Ubuntu 22.04. It includes tools, libraries, and GPU-specific configurations optimized for machine learning workflows using TensorFlow and PyTorch.

Features
> Automated Environment Setup: Install Python, TensorFlow, PyTorch, and other ML tools effortlessly.
> GPU Support: Configure NVIDIA GPU drivers and CUDA for accelerated computations.
> Additional Tools: Docker, Jupyter Notebook, and essential Python libraries.

Quick Start
1. Clone the Repository:
   git clone https://github.com/Bharath-V26/ml_ubuntu_setup.git
   cd ml_ubuntu_setup
   
3. Make the Script Executable:
   chmod +x ml_env_setup.sh

3. Run the Script:
   ./ml_env_setup.sh
   
What the Script Does
The ml_env_setup.sh script performs the following tasks:

1. System Update: Updates system packages to the latest versions.
2. Development Tools: Installs essential tools like git, build-essential, and curl.
3. Python 3.12: Installs Python 3.12 and pip.
4. Virtual Environment: Creates and activates a Python virtual environment ml-env.
5. NVIDIA Drivers: Installs NVIDIA GPU drivers and CUDA Toolkit.
6. TensorFlow & PyTorch: Installs TensorFlow and PyTorch with GPU support.
6. Jupyter Notebook: Installs Jupyter and additional Python libraries (matplotlib, pandas, etc.).
7. Docker: Installs Docker and Docker Compose for containerized workflows.
8. Verification: Ensures all installations are successful.

Verification Steps
    After running the script, verify your setup with the following commands:

1. Python Version:
    python3 --version

2. Pip Version:
    pip --version

3. GPU Driver:
    nvidia-smi

4. Docker:
    docker --version

5. Docker Compose:
    docker-compose --version

Notes:
Activate the environment: Before starting your projects, activate the Python virtual environment by running:
    source ml-env/bin/activate

Deactivating the environment: To deactivate the virtual environment, run:
    deactivate

If you encounter any issues, check the logs or documentation for individual tools.

Setup Steps:

1. Update System Packages
Ensure all system packages are up to date:
    sudo apt update && sudo apt upgrade -y

2. Install Development Tools and Libraries
Install necessary tools and libraries for building and compiling packages:
    sudo apt install -y build-essential git curl wget unzip software-properties-common

3. Install Python 3.12
Add the deadsnakes PPA and install Python 3.12:
    sudo add-apt-repository -y ppa:deadsnakes/ppa
    sudo apt update
    sudo apt install -y python3.12 python3.12-distutils python3.12-venv
    sudo ln -s /usr/bin/python3.12 /usr/bin/python3

Install pip for Python 3.12
    wget https://bootstrap.pypa.io/get-pip.py
    python3.12 get-pip.py
    rm get-pip.py

4. Create and Activate a Python Virtual Environment
   python3 -m venv ml-env
   source ml-env/bin/activate

5. Install NVIDIA GPU Drivers and CUDA Toolkit
Install drivers and CUDA for GPU support:

    sudo apt install -y nvidia-driver-525
    wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin
    sudo mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600
    sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/3bf863cc.pub
    sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64

    sudo apt update
    sudo apt install -y cuda

6. Install TensorFlow and PyTorch
    Install TensorFlow and PyTorch with GPU support:
    pip install tensorflow
    pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118

7. Install Jupyter Notebook and Additional ML Tools
   pip install jupyter matplotlib pandas numpy scikit-learn

9. Install Docker and Docker Compose
    Install Docker:
    sudo apt install -y docker.io
    sudo systemctl enable --now docker
    sudo usermod -aG docker $USER

10. Install Docker Compose:
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose

**Verification** 
Run the following commands to verify the setup:

Python version:
   python --version

Pip version:
    pip --version
    
Virtual Environment:
    source ml-env/bin/activate

GPU driver:
    nvidia-smi

Docker:
    docker --version
    Docker Compose:
    docker-compose --version

Notes
Activate the Python Environment: Always activate the virtual environment before working:
    source ml-env/bin/activate

Deactivate the Environment: To exit the virtual environment:
    deactivate
    
Permissions for Docker: If Docker requires permissions, log out and log back in after running:
    sudo usermod -aG docker $USER

Error Handling:
Check logs for specific tools in case of errors.
Refer to the official documentation for TensorFlow, PyTorch, or CUDA Toolkit for additional troubleshooting.


   





