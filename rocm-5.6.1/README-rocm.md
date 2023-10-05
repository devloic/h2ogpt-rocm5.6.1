To run h2ogpt on docker you can 
    A. build the image from scratch using Dockerfile
    or
    B. use the prebuilt image provided on Docker Hub

A. Image build instructions:

        1. Build and run docker container with rocm 5.6.1 support with:
        docker-compose -f ./docker-compose-build.yml up -d
        (You may change the path "./huggingface_cache"  in docker-compose-build.yml so you can 
        reuse your host huggingface cache and models. Huggingface cache is usually located under
        ~/.cache/huggingface)

        2. Run h2ogpt

            a. The Dockerfile was designed for a AMD GPUs that use the gfx1030 architecture
        or with a GPU  compatible with gfx1030 (like my 6600 XT/gfx1032 setting HSA_OVERRIDE_GFX_VERSION=10.3.0). 
        For those GPUs you may just attach to the running container and run h2ogpt with:
        docker exec -it h2ogpt-rocm5.6.1 python generate.py 
        or
        docker exec -it -e HSA_OVERRIDE_GFX_VERSION=10.3.0 h2ogpt-rocm5.6.1  python generate.py  (with a gfx1032 GPU) 

        otherwise

            b. (Not tested) For other GPUs you need to recompile/install bitsandbytes-rocm-5.6 before launching h2ogpt
        Attach to the container with:
        docker exec -it h2ogpt-rocm5.6.1 bash
        Compile and install bitsandbytes for your GPU with:
        cd /home/ai && ROCM_TARGET=gfx1100 ./install_bitsandbytes.sh (change ROCM_TARGET according to your amd GPU architecture )
        Run h2ogpt with:
        cd /home/ai/h2ogpt && python generate.py

OR

B. Run the image provided on Docker hub with:

docker-compose up -d  


docker exec -it h2ogpt-rocm5.6.1 python generate.py 

or

docker exec -it -e HSA_OVERRIDE_GFX_VERSION=10.3.0 h2ogpt-rocm5.6.1 python generate.py  (with a gfx1032 GPU) 

(You may change the path "./huggingface_cache"  in docker-compose.yml so you can 
 reuse your host huggingface cache and models. Huggingface cache is usually located under
        ~/.cache/huggingface)


user: ai

password: ai

webui : http://0.0.0.0:7860


specific rocm python packages:

https://github.com/arlo-phoenix/bitsandbytes-rocm-5.6

https://github.com/jllllll/exllama

https://github.com/devloic/AutoGPTQ

https://github.com/jllllll/llama-cpp-python-cuBLAS-wheels/releases/tag/rocm