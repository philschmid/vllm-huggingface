# Build custom images

## Inference Endpoints

build container image `Dockerfile.endpoints` and push it to public docker hub

```bash
docker build -t philschmi/vllm-hf-inference-endpoints -f Dockerfile.endpoints .
```

Test the container locally single gpu

single gpu
```bash
docker run -it --gpus 1 -e MODEL_PATH=HuggingFaceH4/zephyr-7b-beta -e MAX_MODEL_LEN=8192  -p 80:80 philschmi/vllm-hf-inference-endpoints
```

multi gpu
```bash
docker run -it --gpus 2 --ipc=host --shm-size 10.24g -e MODEL_PATH=HuggingFaceH4/zephyr-7b-beta -e MAX_MODEL_LEN=8192  -p 80:80 philschmi/vllm-hf-inference-endpoints
```

request the model

```bash
curl localhost/v1/chat/completions \
    -X POST \
    -d '{
  "model": "HuggingFaceH4/zephyr-7b-beta",
  "messages": [
    {
      "role": "system",
      "content": "You are a helpful assistant."
    },
    {
      "role": "user",
      "content": "What is deep learning?"
    }
  ],
  "stream": true,
  "max_tokens": 20
}' \
    -H 'Content-Type: application/json'
```

Push the container to docker hub

```bash
docker push philschmi/vllm-hf-inference-endpoints
```