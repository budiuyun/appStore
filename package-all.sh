#!/bin/bash

# 脚本：通用Helm Chart打包工具
# 功能：打包charts/stable下的所有Helm Chart

# 设置颜色
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# 设置输出目录
OUTPUT_DIR="./chart-releases"
mkdir -p $OUTPUT_DIR

echo -e "${GREEN}===== 开始打包charts/stable下的所有Helm Chart =====${NC}"

# 检查charts/stable目录是否存在
if [ ! -d "charts/stable" ]; then
    echo -e "${RED}错误: charts/stable目录不存在${NC}"
    exit 1
fi

# 查找所有包含Chart.yaml的目录
find charts/stable -name Chart.yaml -type f | while read chart_file; do
    chart_dir=$(dirname "$chart_file")
    chart_name=$(basename "$chart_dir")
    parent_dir=$(basename "$(dirname "$chart_dir")")
    
    echo -e "${YELLOW}处理Chart: $chart_dir${NC}"
    
    # 进入Chart目录
    cd "$chart_dir"
    
    # 打包Chart
    echo "打包 $chart_name..."
    helm package . -d "$OLDPWD/$OUTPUT_DIR"
    
    # 返回原目录
    cd "$OLDPWD"
    
    echo -e "${GREEN}完成打包: $chart_name${NC}"
    echo "------------------------"
done

# 创建或更新index.yaml
cd $OUTPUT_DIR
if [ ! -f index.yaml ]; then
    echo "创建新的index.yaml..."
    helm repo index .
else
    echo "更新现有的index.yaml..."
    helm repo index . --merge index.yaml
fi
cd ..

# 显示结果
echo -e "${GREEN}===== 打包完成 =====${NC}"
echo "打包的Charts列表:"
ls -la $OUTPUT_DIR/*.tgz
echo
echo -e "${GREEN}所有Chart已打包到 $OUTPUT_DIR 目录${NC}"
echo -e "${YELLOW}可以使用以下命令添加本地仓库进行测试:${NC}"
echo "helm repo add local-repo file://$PWD/$OUTPUT_DIR" 