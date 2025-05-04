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

# 生成应用目录函数
generate_app_catalog() {
  echo "正在生成应用目录..."
  
  # 获取当前分支
  CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
  HELM_BRANCH="helm-$CURRENT_BRANCH"
  
  echo "当前分支: $CURRENT_BRANCH"
  echo "目标helm分支: $HELM_BRANCH"
  
  # 保存当前修改（如果有）
  git stash
  
  # 创建或切换到helm分支
  if git show-ref --verify --quiet refs/heads/$HELM_BRANCH; then
    # 本地分支存在，切换
    echo "切换到已存在的分支: $HELM_BRANCH"
    git checkout $HELM_BRANCH
    # 拉取最新更改（如果远程分支存在）
    if git ls-remote --heads origin $HELM_BRANCH | grep -q $HELM_BRANCH; then
      git pull origin $HELM_BRANCH
    fi
  else
    # 检查远程是否存在
    if git ls-remote --heads origin $HELM_BRANCH | grep -q $HELM_BRANCH; then
      echo "创建本地分支跟踪远程分支: $HELM_BRANCH"
      git checkout -b $HELM_BRANCH origin/$HELM_BRANCH
    else
      echo "创建新的helm分支: $HELM_BRANCH"
      git checkout -b $HELM_BRANCH
    fi
  fi
  
  # 设置输出文件
  OUTPUT_FILE="./category.json"
  CHARTS_DIR="./charts/stable"
  
  # 创建JSON结构
  echo "{" > $OUTPUT_FILE
  echo "  \"categories\": {" >> $OUTPUT_FILE
  
  # 临时目录用于分类处理
  TEMP_DIR=$(mktemp -d)
  CATEGORIES_FILE="$TEMP_DIR/categories.txt"
  touch $CATEGORIES_FILE
  
  # 查找所有Chart.yaml文件并提取分类信息
  for chart_file in $(find $CHARTS_DIR -name Chart.yaml); do
    # 获取应用名(目录名)
    app_dir=$(dirname "$chart_file")
    app_name=$(basename "$app_dir")
    
    # 提取应用描述
    app_desc=$(grep "^description:" $chart_file | sed 's/description: *"\(.*\)"/\1/')
    if [ -z "$app_desc" ]; then
      app_desc=$(grep "^description:" $chart_file | sed 's/description: *\(.*\)/\1/')
    fi
    
    # 提取版本
    app_version=$(grep "^version:" $chart_file | sed 's/version: *\(.*\)/\1/')
    
    # 提取图标
    app_icon=$(grep "^icon:" $chart_file | sed 's/icon: *\(.*\)/\1/')
    
    # 提取分类
    category=$(grep -A1 "annotations:" $chart_file | grep "budiu/app-category-zh" | sed 's/.*budiu\/app-category-zh: *"\(.*\)".*/\1/')
    
    # 如果没有分类，设为"其他"
    if [ -z "$category" ]; then
      category="其他"
    fi
    
    # 记录分类
    if ! grep -q "^$category$" $CATEGORIES_FILE; then
      echo "$category" >> $CATEGORIES_FILE
      mkdir -p "$TEMP_DIR/$category"
    fi
    
    # 将应用信息写入临时文件
    echo "{" > "$TEMP_DIR/$category/$app_name.json"
    echo "  \"name\": \"$app_name\"," >> "$TEMP_DIR/$category/$app_name.json"
    echo "  \"description\": \"$app_desc\"," >> "$TEMP_DIR/$category/$app_name.json" 
    echo "  \"version\": \"$app_version\"," >> "$TEMP_DIR/$category/$app_name.json"
    echo "  \"icon\": \"$app_icon\"," >> "$TEMP_DIR/$category/$app_name.json"
    echo "  \"path\": \"./stable/$app_name\"" >> "$TEMP_DIR/$category/$app_name.json"
    echo "}" >> "$TEMP_DIR/$category/$app_name.json"
  done
  
  # 处理所有分类添加到JSON
  first_category=true
  sort $CATEGORIES_FILE | while read category; do
    if [ "$first_category" = true ]; then
      first_category=false
    else
      echo "," >> $OUTPUT_FILE
    fi
    
    # 添加分类名
    echo "    \"$category\": [" >> $OUTPUT_FILE
    
    # 添加应用列表
    first_app=true
    for app_file in "$TEMP_DIR/$category"/*.json; do
      if [ "$first_app" = true ]; then
        first_app=false
      else
        echo "," >> $OUTPUT_FILE
      fi
      
      cat "$app_file" >> $OUTPUT_FILE
    done
    
    echo "" >> $OUTPUT_FILE
    echo "    ]" >> $OUTPUT_FILE
  done
  
  # 关闭JSON结构
  echo "  }" >> $OUTPUT_FILE
  echo "}" >> $OUTPUT_FILE
  
  # 格式化JSON（如果jq可用）
  if command -v jq &> /dev/null; then
    jq . $OUTPUT_FILE > $OUTPUT_FILE.tmp && mv $OUTPUT_FILE.tmp $OUTPUT_FILE
  fi
  
  # 清理临时文件
  rm -rf $TEMP_DIR
  
  # 提交更改
  git add $OUTPUT_FILE
  git commit -m "自动更新应用分类 [skip ci]" || echo "没有更改需要提交"
  
  # 推送到远程
  echo "正在推送更改到远程分支: $HELM_BRANCH"
  git push origin $HELM_BRANCH
  
  # 切回原分支
  git checkout $CURRENT_BRANCH
  
  # 恢复暂存的更改（如果有）
  git stash pop 2>/dev/null || true
  
  echo "JSON分类文件已生成并推送到 $HELM_BRANCH 分支"
}

# 如果直接以参数方式调用此功能
if [ "$1" == "generate-catalog" ]; then
  generate_app_catalog
fi 