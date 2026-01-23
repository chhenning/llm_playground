# Environment

I have a macbook running M3 Max CPU and 128GB of RAM. This repo will be used to test
how far I can take this Laptop to do run LLM workflows.

# models

- `https://huggingface.co/unsloth/Qwen3-30B-A3B-Instruct-2507-GGUF`


# OCR

`Grounded Text` refers to text directly linked or anchored to specific visual regions in an image (like a bounding box), crucial for vision-language models (VLM) to understand where text is, while `DocTags` (Document Tags) are high-level semantic labels/metadata applied to entire documents or sections, offering what the content is about, with Grounding focusing on spatial, visual-textual alignment (e.g., a price tag on a product image) and DocTags on semantic classification (e.g., "invoice," "receipt," "contract") for better organization and retrieval in document understanding tasks. 


## docling

To install `docling` I need to adjust my pyproject.toml to allow `pillow>=10.1.0`. It appears that docling doesn't like
the latest pillow version of 12.x .



# llama.cpp

This command line will setup `llama.cpp` using 

```
CMAKE_ARGS="-DGGML_METAL=on -DCMAKE_OSX_ARCHITECTURES=arm64" uv pip install llama-cpp-python --no-binary llama-cpp-python
```

## Upgrade

[docs](https://llama-cpp-python.readthedocs.io/en/latest/)

To upgrade and rebuild llama-cpp-python add `--upgrade --force-reinstall --no-cache-dir` flags to the pip install command to ensure the package is rebuilt from source.


## Uninstall

```
uv pip uninstall llama-cpp-python
```

## Downloading models

All models are downloaded to `~/.cache/llama.cpp/`

```
./scripts/download.sh \
    "https://huggingface.co/ggml-org/granite-docling-258M-GGUF/resolve/main/granite-docling-258M-f16.gguf" \
    ~/.cache/llama.cpp/granite-docling-258M-f16.gguf \
    "282f2192e9baa25e9219f47e68367777ba46adaec8f97d04db58dc584b500976"
```

## llama.cpp

### cli

[docs](https://github.com/ggml-org/llama.cpp/tree/master/tools/cli)

```sh
llama-cli \
  --model ~/.cache/llama.cpp/Qwen3-30B-A3B-Instruct-2507-Q8_0.gguf \
  --n-gpu-layers 999 \
  --ctx-size 0 \
  --conversation
```

### server

[docs](https://github.com/ggml-org/llama.cpp/tree/master/tools/server)

```sh
llama-server \
  --model ~/.cache/llama.cpp/Qwen3-30B-A3B-Instruct-2507-Q8_0.gguf \
  --n-gpu-layers 999 \
  --port 36912
```

```sh
llama-server \
  --model ~/.cache/llama.cpp/Qwen3-Embedding-8B-Q8_0.gguf \
  --n-gpu-layers 999 \
  --ubatch-size 1024 \
  --host 0.0.0.0 \
  --port 36912 \
  --embedding \
  --pooling last
```


```sh
llama-server \
  --model ~/.cache/llama.cpp/granite-docling-258M-f16.gguf \
  --mmproj ~/.cache/llama.cpp/mmproj-granite-docling-258M-f16.gguf \
  --n-gpu-layers 999 \
  --ctx-size 8192 \
  --port 36912
```

```sh
llama-server \
  --model ~/.cache/llama.cpp/Qwen3-30B-A3B-Instruct-2507-Q8_0.gguf \
  --port 8033 \
  --n-gpu-layers 999 \
  --ctx-size 16384 \
  --host 0.0.0.0 \
  --jinja
```

### embedding


```sh
llama-embedding \
  --model ~/.cache/llama.cpp/Qwen3-Embedding-8B-Q8_0.gguf \
  --n-gpu-layers 999 \
  --pooling last \
  --ubatch-size 1024 \
  --prompt "You like embeddings?"
```

### bench

[docs](https://github.com/ggml-org/llama.cpp/tree/master/tools/llama-bench)

```sh
llama-bench \
  --model ~/.cache/llama.cpp/Qwen3-30B-A3B-Instruct-2507-Q8_0.gguf \
  --n-gen 128 \
  --n-prompt 0 \
  --n-gpu-layers 18-24+1

llama-bench \
  --model ~/.cache/llama.cpp/Qwen3-30B-A3B-Instruct-2507-Q8_0.gguf \
  --n-gen 128 \
  --n-prompt 0 \
  --n-gpu-layers 999 \
  --n-depth 0,4096,8192,16384
```