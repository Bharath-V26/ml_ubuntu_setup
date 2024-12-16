#!/bin/bash

# Exit on error
set -e

# Step 1: Update system packages
echo "Updating system packages..."
sudo apt update
sudo apt upgrade -y

# Step 2: Install development tools and libraries
echo "Installing development tools and libraries..."
sudo apt install -y build-essential curl git software-properties-common unzip wget

# Step 3: Install Python 3.12
echo "Installing Python 3.12..."
sudo apt install -y python3.12 python3.12-venv python3.12-dev python3-pip python3-apt

# Step 4: Set Python 3.12 as the default
echo "Setting Python 3.12 as the default..."
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.12 1

# Step 5: Install virtualenv
echo "Installing virtualenv..."
python3 -m pip install --upgrade pip
python3 -m pip install virtualenv

# Step 6: Create a virtual environment for machine learning
echo "Creating virtual environment 'ml_env'..."
python3 -m venv ml_env

# Step 7: Activate virtual environment
echo "Activating virtual environment..."
source ml_env/bin/activate

# Step 8: Install ML libraries
echo "Installing machine learning libraries..."
pip install numpy scipy scikit-learn tensorflow keras

echo "Machine Learning environment setup is complete!"
