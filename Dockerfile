FROM ubuntu:22.04

# Set environment variables
ENV CONDA_INSTALLER_URL=https://repo.anaconda.com/miniconda/Miniconda3-py38_23.5.1-0-Linux-x86_64.sh \
    MINICONDA_DIR=/opt/miniconda \
    CONDA=/opt/miniconda/bin/conda \
    PYTHON=/opt/miniconda/envs/env/bin/python

# Update and install dependencies
RUN apt-get update -y && \
    apt-get install -y build-essential wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download and install Miniconda
RUN wget $CONDA_INSTALLER_URL -O miniconda.sh && \
    /bin/bash miniconda.sh -b -p $MINICONDA_DIR && \
    rm miniconda.sh

# Create conda environment
RUN $CONDA create -y -n env python=3.8.10 && \
    $CONDA clean -afy

ENV PATH="/opt/miniconda/bin:$PATH"

# Activate conda environment
SHELL ["conda", "run", "-n", "env", "/bin/bash", "-c"]

# Install all packages together using conda
RUN $CONDA install -c pytorch -c nvidia -c conda-forge pytorch torchvision pytorch-cuda=11.8 ultralytics

COPY . /project

ENV PYTHONPATH="${PYTHONPATH}:/project"

# Enable GPU support
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

# Make the entrypoint script executable
RUN chmod +x entrypoint.sh

CMD ["./entrypoint.sh"]
