cd /MedJamba

echo "node_rank is $1"
node_rank=$1
master_ip=172.23.129.73
process_port=29507

experiment_name=Jambav01_Test_bf16nake
log_folder="./logs/${experiment_name}"
result_folder="./results/${experiment_name}"
mkdir -p $log_folder
mkdir -p $result_folder
log_name=$(date +"%m-%d_%H-%M").log


# ## int 8

# CUDA_LAUNCH_BLOCKING=1 accelerate launch --main_process_port ${process_port} ./src/evaluate/eval_jamba_int8.py \
#     --model_path=/model/path/ \
#     --batch_size=8 \
#     --num_return=1 \
#     --input_path=./data/Jamba/test.json \
#     --output_path=${result_folder}/model_ans.jsonl \
#     --score_path=${result_folder}/score.json \
#     --wrong_item_path=${result_folder}/wrong_item.json > ${log_folder}/${log_name} 2>&1 &


# Pipeline

python ./src/evaluate/eval_jamba_nake.py \
    --model_path=/model/path/ \
    --batch_size=64 \
    --num_return=1 \
    --input_path=./data/Jamba01/test.json \
    --output_path=${result_folder}/model_ans.jsonl \
    --score_path=${result_folder}/score.json \
    --wrong_item_path=${result_folder}/wrong_item.json > ${log_folder}/${log_name} 2>&1 &
