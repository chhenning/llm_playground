# Environment

I have a macbook running M3 Max CPU and 128GB of RAM. This repo will be used to test
how far I can take this Laptop to do run LLM workflows.

## docling

To install `docling` I need to adjust my pyproject.toml to allow `pillow>=10.1.0`. It appears that docling doesn't like
the latest pillow version of 12.x .


## llama.cpp

This command line will setup `llama.cpp` using 

```
CMAKE_ARGS="-DGGML_METAL=on -DCMAKE_OSX_ARCHITECTURES=arm64" uv pip install llama-cpp-python --no-binary llama-cpp-python
```

### Upgrade

[docs](https://llama-cpp-python.readthedocs.io/en/latest/)

To upgrade and rebuild llama-cpp-python add `--upgrade --force-reinstall --no-cache-dir` flags to the pip install command to ensure the package is rebuilt from source.


### Uninstall

```
uv pip uninstall llama-cpp-python
```

### Downloading models

All models are downloaded to `~/.cache/llama.cpp/`

```
./scripts/download.sh \
    "https://huggingface.co/ggml-org/granite-docling-258M-GGUF/resolve/main/granite-docling-258M-f16.gguf" \
    ~/.cache/llama.cpp/granite-docling-258M-f16.gguf \
    "282f2192e9baa25e9219f47e68367777ba46adaec8f97d04db58dc584b500976"
```

### llama.cpp cli

```
llama-server \
  --model ~/.cache/llama.cpp/granite-docling-258M-f16.gguf \
  --mmproj ~/.cache/llama.cpp/mmproj-granite-docling-258M-f16.gguf \
  --n-gpu-layers 999 \
  --ctx-size 8192 \
  --port 36912
```