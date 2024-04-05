# need change 4 place
# Please set the wandb key in the python file (e.g ./src/process/prepare/data_process_train_gemma.py)

mkdir wandb_logs


# need change 4 place
experiment_name=jamba_allsft_Data
log_folder="./logs/${experiment_name}"
mkdir -p $log_folder
log_name=$(date +"%m-%d_%H-%M").log


python /223040239/medbase/src/process/prepare/data_process_train_allsft_jamba.py \
--data_path ./metadata/train/jamba_allsft.json \
--model_path /sds_wangby/models/Jamba-v0.1 \
--wandb_log ./wandb_logs \
--max_seq_len 40960 \
--experiment_name ${experiment_name} \
--save_path ./data/Jamba/allsft > ${log_folder}/$log_name 2>&1 &

