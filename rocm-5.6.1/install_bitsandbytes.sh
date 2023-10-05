cd bitsandbytes-rocm-5.6
ROCM_HOME="/opt/rocm" make hip && pip uninstall bitsandbytes -y && pip install .
cd ..
