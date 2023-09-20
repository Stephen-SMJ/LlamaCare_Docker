# 基于一个包含Conda的基础镜像（例如miniconda或anaconda）开始构建
FROM continuumio/miniconda3

# 复制本地的conda环境文件（例如environment.yml）到镜像中
COPY /mnt/workspace/llama2/FineTune/LLaMA-Efficient-Tuning/llama_etuning.yml /env/llama_etuning.yml

# 创建并激活一个新的Conda环境
RUN conda env create -f /env/llama_etuning.yml

# 设置容器的工作目录
WORKDIR /app

# 激活Conda环境
RUN echo "source activate llama_etuning" > ~/.bashrc
# ENV PATH /home/pai/envs/llama_etuning/bin:$PATH

# 复制应用程序代码到容器中
ADD . /app

# 第三阶段:执行脚本(容器启动时的命令)
CMD ["python", "./mnt/workspace/llama2/FineTune/LLaMA-Efficient-Tuning/src/web_demo.py --model_name_or_path ./mnt/data/model/llama2-chinese-13b-chat/ --template llama2 --quantization_bit 8 --finetuning_type lora --checkpoint_dir ./mnt/workspace/llama2/FineTune/LLaMA-Efficient-Tuning/saves/Custom/lora/llama2-CH-test-2023-09-13-03-52-59"]  
