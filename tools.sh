#!/bin/bash

# 目标目录
TOOLS_DIR="Tools"

# 创建目标目录（如果不存在）
mkdir -p "$TOOLS_DIR"

# 下载文件列表
urls=(
    "https://github.com/projectdiscovery/naabu/releases/download/v2.3.2/naabu_2.3.2_linux_amd64.zip"
    "https://github.com/projectdiscovery/nuclei/releases/download/v3.3.6/nuclei_3.3.6_linux_amd64.zip"
    "https://github.com/projectdiscovery/httpx/releases/download/v1.6.9/httpx_1.6.9_linux_amd64.zip"
    "https://github.com/projectdiscovery/subfinder/releases/download/v2.6.7/subfinder_2.6.7_linux_amd64.zip"
)

# 循环下载并解压每个文件
for url in "${urls[@]}"; do
    # 提取文件名
    filename=$(basename "$url")

    # 完整文件路径
    filepath="$TOOLS_DIR/$filename"

    # 下载文件
    echo "Downloading $filename to $TOOLS_DIR..."
    wget -P "$TOOLS_DIR" "$url"

    # 检查下载是否成功
    if [ $? -eq 0 ]; then
        # 解压文件
        echo "Unzipping $filename in $TOOLS_DIR..."
        unzip "$filepath" -d "$TOOLS_DIR"

        # 删除 .zip 文件
        echo "Removing $filename..."
        rm "$filepath"

        # 删除 .md 文件（假设解压后会生成 .md 文件）
        echo "Removing .md files in $TOOLS_DIR..."
        rm "$TOOLS_DIR"/*.md
    else
        echo "Failed to download $filename"
    fi
done

echo "All tasks completed."
