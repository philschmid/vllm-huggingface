# Set TGI like environment variables
NUM_SHARD=${NUM_SHARD:-$(nvidia-smi --list-gpus | wc -l)}
MODEL_PATH=${MODEL_PATH:-"/repository"}
MAX_MODEL_LEN=${MAX_MODEL_LEN:-1}

# Entrypoint for the OpenAI API server
CMD="python3 -m vllm.entrypoints.openai.api_server --host '0.0.0.0' --port 80 --model '$MODEL_PATH' --tensor-parallel-size '$NUM_SHARD'"

# Append --max-model-len if its value is not -1
if [ "$MAX_MODEL_LEN" -ne -1 ]; then
    CMD="$CMD --max-model-len $MAX_MODEL_LEN"
fi

# Execute the command
eval $CMD