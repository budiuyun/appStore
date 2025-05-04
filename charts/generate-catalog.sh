#!/bin/bash

# 设置输出目录
OUTPUT_FILE="./app-catalog.md"
CHARTS_DIR="./stable"

# 清空或创建输出文件
echo "# 应用目录" > $OUTPUT_FILE
echo "" >> $OUTPUT_FILE
echo "按照类别组织的Helm应用列表，自动生成于 $(date '+%Y-%m-%d %H:%M:%S')" >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

# 临时保存所有分类和应用的关系
declare -A categories

# 查找所有Chart.yaml文件并提取分类信息
for chart_file in $(find $CHARTS_DIR -name Chart.yaml); do
    # 获取应用名(目录名)
    app_name=$(basename $(dirname $chart_file))
    
    # 提取应用描述
    app_desc=$(grep "^description:" $chart_file | sed 's/description: *"\(.*\)"/\1/')
    if [ -z "$app_desc" ]; then
        app_desc=$(grep "^description:" $chart_file | sed 's/description: *\(.*\)/\1/')
    fi
    
    # 提取分类 - 使用更精确的方法
    category=""
    in_annotations=false
    while IFS= read -r line; do
        # 检查是否进入annotations部分
        if [[ $line =~ ^annotations: ]]; then
            in_annotations=true
            continue
        fi
        
        # 如果不再有缩进，表示离开了annotations部分
        if $in_annotations && [[ ! $line =~ ^[[:space:]] ]]; then
            in_annotations=false
            continue
        fi
        
        # 在annotations部分中查找category
        if $in_annotations && [[ $line =~ budiu/app-category-zh ]]; then
            category=$(echo "$line" | sed 's/.*budiu\/app-category-zh: *"\(.*\)".*/\1/')
            break
        fi
    done < "$chart_file"
    
    # 如果没有分类，设为"其他"
    if [ -z "$category" ]; then
        category="其他"
    fi
    
    # 构建应用信息
    app_info="- **[$app_name](./stable/$app_name)** - $app_desc"
    
    # 将应用添加到对应分类
    if [ -z "${categories[$category]}" ]; then
        categories[$category]="$app_info"
    else
        categories[$category]="${categories[$category]}
$app_info"
    fi
done

# 按分类生成目录
echo "## 分类目录" >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE
for category in $(echo "${!categories[@]}" | tr ' ' '\n' | sort); do
    echo "- [$category](#${category})" | sed 's/ /-/g' >> $OUTPUT_FILE
done
echo "" >> $OUTPUT_FILE

# 生成各分类下的应用列表
for category in $(echo "${!categories[@]}" | tr ' ' '\n' | sort); do
    echo "## $category" >> $OUTPUT_FILE
    echo "" >> $OUTPUT_FILE
    echo "${categories[$category]}" >> $OUTPUT_FILE
    echo "" >> $OUTPUT_FILE
done

echo "应用目录生成完毕，共包含 ${#categories[@]} 个分类" 