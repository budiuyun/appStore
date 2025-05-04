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
  
  # 设置输出目录
  OUTPUT_FILE="./charts/app-catalog.md"
  CHARTS_DIR="./charts/stable"
  
  # 清空或创建输出文件
  echo "# 应用目录" > $OUTPUT_FILE
  echo "" >> $OUTPUT_FILE
  echo "按照类别组织的Helm应用列表，自动生成于 $(date '+%Y-%m-%d %H:%M:%S')" >> $OUTPUT_FILE
  echo "" >> $OUTPUT_FILE
  
  # 创建临时文件存储分类和应用信息
  TEMP_DIR=$(mktemp -d)
  CATEGORIES_FILE="$TEMP_DIR/categories.txt"
  touch $CATEGORIES_FILE
  
  # 查找所有Chart.yaml文件并提取分类信息
  for chart_file in $(find $CHARTS_DIR -name Chart.yaml); do
    # 获取应用名(目录名)
    app_name=$(basename $(dirname $chart_file))
    
    # 提取应用描述
    app_desc=$(grep "^description:" $chart_file | sed 's/description: *"\(.*\)"/\1/')
    if [ -z "$app_desc" ]; then
      app_desc=$(grep "^description:" $chart_file | sed 's/description: *\(.*\)/\1/')
    fi
    
    # 提取分类
    category=$(grep -A1 "annotations:" $chart_file | grep "budiu/app-category-zh" | sed 's/.*budiu\/app-category-zh: *"\(.*\)".*/\1/')
    
    # 如果没有分类，设为"其他"
    if [ -z "$category" ]; then
      category="其他"
    fi
    
    # 创建分类目录（如果不存在）
    mkdir -p "$TEMP_DIR/$category"
    
    # 将应用信息写入分类文件
    echo "- **[$app_name](./stable/$app_name)** - $app_desc" > "$TEMP_DIR/$category/$app_name"
    
    # 记录分类名称
    if ! grep -q "^$category$" $CATEGORIES_FILE; then
      echo "$category" >> $CATEGORIES_FILE
    fi
  done
  
  # 生成分类导航
  echo "## 分类目录" >> $OUTPUT_FILE
  echo "" >> $OUTPUT_FILE
  
  sort $CATEGORIES_FILE | while read category; do
    clean_category=$(echo "$category" | sed 's/ /-/g')
    echo "- [$category](#$clean_category)" >> $OUTPUT_FILE
  done
  
  echo "" >> $OUTPUT_FILE
  
  # 生成各分类下的应用列表
  sort $CATEGORIES_FILE | while read category; do
    echo "## $category" >> $OUTPUT_FILE
    echo "" >> $OUTPUT_FILE
    
    if [ -d "$TEMP_DIR/$category" ]; then
      cat "$TEMP_DIR/$category"/* >> $OUTPUT_FILE
    fi
    
    echo "" >> $OUTPUT_FILE
  done
  
  # 统计信息
  cat_count=$(cat $CATEGORIES_FILE | wc -l)
  app_count=$(find $TEMP_DIR -type f -not -path "*categories.txt" | wc -l)
  
  echo "应用目录生成完毕，共包含 $cat_count 个分类，$app_count 个应用"
  
  # 清理临时文件
  rm -rf $TEMP_DIR
  
  # 提交更改
  git add $OUTPUT_FILE
  git commit -m "自动更新应用目录 [skip ci]" || echo "没有更改需要提交"
  
  # 推送到远程
  echo "正在推送更改到远程分支: $HELM_BRANCH"
  git push origin $HELM_BRANCH
  
  # 切回原分支
  git checkout $CURRENT_BRANCH
  
  # 恢复暂存的更改（如果有）
  git stash pop 2>/dev/null || true
  
  echo "目录已生成并推送到 $HELM_BRANCH 分支"
}

# 如果直接以参数方式调用此功能
if [ "$1" == "generate-catalog" ]; then
  generate_app_catalog
fi 