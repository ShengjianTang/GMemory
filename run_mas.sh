#!/bin/bash

if [ -f "./.env" ]; then
    export $(grep -v '^#' "./.env" | xargs)
fi

# Options:
# --mas_memory:    empty, chatdev, metagpt, voyager, generative, memorybank, g-memory
# --mas_type:      autogen, dylan, macnet
# --task:          alfworld, fever, pddl, sciworld

python3 tasks/run.py \
    --task alfworld \
    --reasoning io \
    --mas_memory g-memory \
    --max_trials 30 \
    --mas_type macnet \
    --model Qwen/Qwen2.5-14B-Instruct \


"""
对源码修改后第一次运行成功
"""

# 确保模型变量存在
export GMEMORY_MODEL="$(
  python -c 'from dotenv import dotenv_values; print(dotenv_values(".env")["GMEMORY_MODEL"])'
)"

# 执行命令
CUDA_VISIBLE_DEVICES=0 python tasks/run.py \
  --task pddl \
  --reasoning io \
  --mas_memory g-memory \
  --mas_type autogen \
  --model "$GMEMORY_MODEL" \
  --max_trials 2 \
  --limit_tasks 1