#!/bin/bash
#python *.py


node_rank=1
master_ip=172.21.13.219


cd /223040239/medbase
process_port=29507
experiment_name=jamba-allsft-train
model_dir=/sds_wangby/models/Jamba-v0.1
train_data_file=./data/Jamba/allsft
dev_data_file=./data/Jamba/dev.json
output_dir=./ckpts
log_folder="./logs/${experiment_name}"
mkdir -p $log_folder
log_name=$(date +"%m-%d_%H-%M").log



CUDA_LAUNCH_BLOCKING=1 accelerate launch \
    --config_file ./src/sft/training_config/zero_multi.yaml \
    --num_processes 40 \
    --num_machines 5 \
    --machine_rank ${node_rank} \
    --main_process_ip "${master_ip}" \
    --main_process_port ${process_port} \
    --num_cpu_threads_per_process 8 \
    --deepspeed_multinode_launcher standard /223040239/medbase/src/sft/train_jamba_resume_val.py \
    --model_path ${model_dir} \
    --experiment_name ${experiment_name} \
    --gradient_accumulation_steps 2 \
    --train_data_dir ${train_data_file} \
    --dev_data_dir ${dev_data_file} \
    --output_dir ${output_dir} \
    --log_dir /223040239/medbase/wandb_logs \
    --n_epochs 1 \
    --train_bsz_per_gpu 3 \
    --eval_bsz_per_gpu 3 \
    --learning_rate 1e-5 \
    --eval_step -1 \
    --save_step -1 \
    --warmup_rates 0.03 \
    --max_ckpts 1 \
    --gradient_checkpointing  > ${log_folder}/rank${node_rank}.log 2>&1 &