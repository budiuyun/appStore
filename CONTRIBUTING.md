# 如何贡献应用到 AppStore

本指南将帮助您向应用商店贡献您自己的Helm应用。

## 分支命名规则

作为贡献者，您必须遵循以下分支命名规则：

```
您的用户名/应用名
```

例如，如果您的GitHub用户名是`user1`，您想贡献一个名为`myapp`的应用，您的分支应该命名为`user1/myapp`。

**重要**: 您只能在以自己用户名为前缀的分支上工作。系统会自动验证分支名称与您的GitHub用户名是否匹配。

## 应用提交流程

1. **加入组织**
   - 如果您尚未加入组织，请联系管理员请求邀请

2. **克隆仓库**
   ```bash
   git clone https://github.com/组织名称/AppStore.git
   cd AppStore
   ```

3. **创建您的分支**
   ```bash
   git checkout -b 您的用户名/应用名称
   ```

4. **添加您的应用**
   - 在`charts/stable/`目录下创建您的应用目录
   - 应用目录必须包含以下文件:
     - `Chart.yaml` - 应用元数据
     - `values.yaml` - 默认配置值
     - `values.schema.json` - 配置验证架构
     - `README.md` - 应用说明文档
     - `templates/` 目录，包含:
       - `deployment.yaml`
       - `service.yaml`
       - `pvc.yaml`
       - `_helpers.tpl`

5. **提交并推送您的更改**
   ```bash
   git add .
   git commit -m "添加我的应用"
   git push -u origin 您的用户名/应用名称
   ```

## 验证流程

提交后，系统会自动验证您的应用是否符合标准，包括：

1. 分支所有权检查 - 确认您只在自己用户名前缀的分支上工作
2. 文件路径检查 - 确认您只修改了`charts/stable/`目录下的文件
3. Chart结构验证 - 确认您的应用包含所有必需文件
4. Helm lint检查 - 验证Helm模板语法
5. 模板渲染检查 - 确认您的模板可以正确渲染

## 应用发布

验证通过后，系统会自动:

1. 打包您的Helm Charts
2. 创建您的专属Helm仓库分支(`helm-您的用户名/应用名称`)
3. 生成索引文件

您可以通过以下URL使用您的Helm仓库:
```
https://raw.githubusercontent.com/组织名称/AppStore/helm-您的用户名/应用名称/
```

## 应用更新

若要更新应用，只需在您的分支上提交新的更改，系统会自动更新您的Helm仓库。

## 设计规范

1. Service类型必须为ClusterIP
2. 必须配置资源限制和请求
3. 必须支持持久化存储
4. 必须配置网络带宽限制
5. 模板必须引用values.yaml中定义的值
6. README.md必须包含应用描述和使用说明

## 联系支持

如有任何问题，请联系应用商店管理员或提交Issue。 