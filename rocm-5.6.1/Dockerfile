FROM rocm/dev-ubuntu-22.04:5.6.1-complete

 SHELL ["/bin/bash", "-c"]
 RUN apt-get update \
  && apt-get install wget nano sudo git gcc build-essential -y && useradd -rm -d /home/ai -s /bin/bash -g root -G sudo -u 1001 ai -p "$(openssl passwd -1 ai)" && usermod -aG render ai
 WORKDIR /home/ai
 ADD requirements.txt install_bitsandbytes.sh ./
 RUN chmod +x install_bitsandbytes.sh
 USER ai
 ENV PATH="/home/ai/miniconda3/bin:$PATH"
 RUN mkdir -p ~/miniconda3 && wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh \
  && chmod +x ~/miniconda3/miniconda.sh \
  && ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3 \
  && rm -rf ~/miniconda3/miniconda.sh \
  && conda install python=3.10 \
  && conda init bash \
  && conda create --name h2oenv \
  && echo "conda activate h2oenv" >> ~/.bashrc \
  && echo "PATH=\"/home/ai/miniconda3/bin:$PATH\"" >> ~/.bashrc 
  
  SHELL ["conda", "run", "-n", "h2oenv", "/bin/bash", "-c"]
  RUN pip install https://download.pytorch.org/whl/nightly/pytorch_triton_rocm-2.1.0%2B34f8189eae-cp310-cp310-linux_x86_64.whl \
  && pip install https://download.pytorch.org/whl/nightly/rocm5.6/torch-2.2.0.dev20230921%2Brocm5.6-cp310-cp310-linux_x86_64.whl \
  && pip install https://download.pytorch.org/whl/nightly/rocm5.6/torchvision-0.17.0.dev20230921%2Brocm5.6-cp310-cp310-linux_x86_64.whl \
  && git clone https://github.com/devloic/AutoGPTQ && cd AutoGPTQ && git checkout fadb2bafce5a63226312cef7d5c807c907b86822 \
  && ROCM_VERSION=5.6.1 pip install -e . && cd ..  \
  && git clone https://github.com/jllllll/exllama && cd exllama && git checkout 86cd5c00123b4761003aac8224114ba35755c54b \
  && ROCM_VERSION=5.6.1 python3 setup.py install && cd .. \
  && git clone https://github.com/arlo-phoenix/bitsandbytes-rocm-5.6 && cd bitsandbytes-rocm-5.6  && git checkout e38b9e91b718e8b84f4678c423f72dd4decce4e5 \
  && ROCM_HOME="/opt/rocm"  make hip ROCM_TARGET=gfx1030 && pip install . && cd .. \
  && pip install -r requirements.txt  --no-deps \
  && git clone https://github.com/h2oai/h2ogpt && cd h2ogpt && git checkout cdfe9316ba9f8f7676050d0cb90d9a0238da4c85 \
  && pip cache purge
  WORKDIR /home/ai/h2ogpt
