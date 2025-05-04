#!/bin/bash
# 生成应用分类索引文件
# 此脚本会在charts目录下搜索所有Chart.yaml文件，提取budiu/app-category-zh标签，并生成分类索引

echo "开始生成应用分类索引..."

OUTPUT_FILE="charts/category-index.json"
OUTPUT_DIR=$(dirname "$OUTPUT_FILE")

# 确保输出目录存在
mkdir -p "$OUTPUT_DIR"

# 初始化JSON结构
echo "{" > $OUTPUT_FILE
echo "  \"categories\": [" >> $OUTPUT_FILE

FIRST=true
FOUND_CATEGORIES=false

# 遍历所有Chart.yaml文件
for chart_file in $(find charts -name Chart.yaml); 
do
  echo "处理文件: $chart_file"
  
  # 提取应用名称
  APP_NAME=$(grep "^name:" $chart_file | awk '{print $2}' | tr -d '"')
  
  # 提取应用版本
  APP_VERSION=$(grep "^version:" $chart_file | awk '{print $2}' | tr -d '"')
  
  # 提取图标URL
  ICON=$(grep "^icon:" $chart_file | sed 's/^icon: *//' | tr -d '"')
  
  # 提取描述
  DESCRIPTION=$(grep "^description:" $chart_file | sed 's/^description: *//' | tr -d '"')
  
  # 尝试提取budiu/app-category-zh标签
  CATEGORY=$(grep -A1 "annotations:" $chart_file | grep "budiu/app-category-zh" | sed 's/.*: *"\(.*\)".*/\1/')
  
  # 如果没找到，尝试提取其他可能的格式
  if [ -z "$CATEGORY" ]; then
    CATEGORY=$(grep -A1 "annotations:" $chart_file | grep "app-category-zh" | sed 's/.*: *"\(.*\)".*/\1/')
  fi
  
  # 如果找到了分类
  if [ ! -z "$CATEGORY" ]; then
    FOUND_CATEGORIES=true
    
    # 添加逗号分隔（除了第一个条目）
    if [ "$FIRST" = true ]; then
      FIRST=false
    else
      echo "," >> $OUTPUT_FILE
    fi
    
    # 构建JSON条目
    echo "    {" >> $OUTPUT_FILE
    echo "      \"name\": \"$APP_NAME\"," >> $OUTPUT_FILE
    echo "      \"version\": \"$APP_VERSION\"," >> $OUTPUT_FILE
    echo "      \"icon\": \"$ICON\"," >> $OUTPUT_FILE
    echo "      \"description\": \"$DESCRIPTION\"," >> $OUTPUT_FILE
    echo "      \"category\": \"$CATEGORY\"," >> $OUTPUT_FILE
    echo "      \"path\": \"$(dirname $chart_file)\"" >> $OUTPUT_FILE
    echo -n "    }" >> $OUTPUT_FILE
    
    echo "已添加应用 $APP_NAME，分类: $CATEGORY"
  else
    echo "警告：应用 $APP_NAME 没有找到budiu/app-category-zh标签"
  fi
done

# 完成JSON结构
echo "" >> $OUTPUT_FILE
echo "  ]," >> $OUTPUT_FILE

# 添加生成时间戳
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
echo "  \"generated\": \"$TIMESTAMP\"" >> $OUTPUT_FILE
echo "}" >> $OUTPUT_FILE

# 检查是否找到了分类
if [ "$FOUND_CATEGORIES" = false ]; then
  echo "警告：未找到任何应用的分类信息！请确认Chart.yaml文件中包含budiu/app-category-zh标签"
  # 创建一个基本的空索引以避免JSON解析错误
  echo "{" > $OUTPUT_FILE
  echo "  \"categories\": []," >> $OUTPUT_FILE
  echo "  \"generated\": \"$TIMESTAMP\"," >> $OUTPUT_FILE
  echo "  \"warning\": \"未找到任何应用的分类信息\"" >> $OUTPUT_FILE
  echo "}" >> $OUTPUT_FILE
else
  echo "成功生成分类索引，共找到$([ "$FIRST" = true ] && echo "0" || echo $(($(grep -c name $OUTPUT_FILE))))个应用的分类信息"
fi

echo "分类索引已生成: $OUTPUT_FILE"

# 输出索引内容以供检查
echo "生成的索引内容预览:"
cat $OUTPUT_FILE 