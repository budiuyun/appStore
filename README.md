# Helm Charts 多租户仓库

本仓库是一个多租户的 Helm Charts 托管平台，允许多个用户/组织创建和维护自己的 Chart 集合。

# 如何贡献应用
1. Fork本仓库
2. 在charts/stable/目录下创建您的应用目录
3. 遵循模板创建必要文件
4. 提交Pull Request

## 多租户使用方式

### 租户接入流程

1. Fork 或克隆本仓库
2. 创建属于你的分支（例如：`user1`、`org-abc` 等，**不要**使用 `main` 或 `helm-` 开头的分支名）
3. 在你的分支中的 `charts/stable/` 目录下添加你的 Helm Charts
4. 提交并推送你的分支
5. 系统会自动创建一个名为 `helm-{你的分支名}` 的分支，其中包含打包好的 Chart 和 index.yaml
6. 在应用平台中使用 URL: `https://raw.githubusercontent.com/{仓库所有者}/{仓库名}/helm-{你的分支名}/` 添加你的应用仓库

### 更新你的 Chart

1. 切换到你的用户分支
2. 修改你的 Chart 文件
3. 提交并推送更改
4. 系统会自动更新你的 `helm-{你的分支名}` 分支

### 分支命名规范

- 用户分支：任意名称，但不能以 `helm-` 开头，也不能是 `main`
- 系统生成的 Chart 分支：`helm-{用户分支名}`

## Chart 严格格式要求

本仓库对 Chart 的格式有严格要求，**所有用户提交的应用必须严格遵循标准格式**，有任何偏差都会导致提交被拒绝。

### 目录结构要求

每个 Chart 必须完全符合以下结构：

```
app-name-version/                  # 例如：my-app-1.0.0/
└── app-name/                      # 例如：my-app/
    ├── Chart.yaml                 # 必需，包含Chart元数据
    ├── values.yaml                # 必需，包含默认配置
    ├── values.schema.json         # 必需，JSON模式定义
    └── templates/                 # 必需，K8s资源模板目录
        ├── _helpers.tpl           # 必需，辅助函数
        ├── deployment.yaml        # 必需，部署配置
        ├── service.yaml           # 必需，服务配置
        └── pvc.yaml               # 必需，持久卷声明
```

### 文件内容要求

每个文件必须包含特定的字段和部分，详细要求请参考：

- [Chart 模板说明](./charts/stable/TEMPLATE/README.md)
- [参考示例：uptime-kuma](./charts/stable/uptime-kuma-0.1.1/uptime-kuma/)

### 自动检查流程

系统会自动对提交的 Chart 进行以下检查：

1. **路径限制检查** - 用户只能修改 `charts/stable` 目录下的文件
2. **结构完整性检查** - 确保所有必需文件和目录存在
3. **字段验证** - 验证必需的字段和配置存在
4. **Helm lint** - 使用官方 Helm lint 工具验证语法
5. **模板渲染测试** - 尝试渲染模板确保无错误

以上任何一项检查失败都会导致提交被拒绝。

### 创建新 Chart 的最佳实践

1. 复制 `uptime-kuma` 的完整结构作为起点
2. 逐个修改文件内容以适应你的应用
3. 在提交前本地运行 `helm lint` 进行检查
4. 确保所有必需文件和字段都已包含

## 安全规范和限制

为确保仓库的安全性和可靠性，系统会自动执行以下安全检查：

### 分支命名限制

- 分支名只能包含字母、数字、下划线和连字符
- 分支名长度不能超过 30 个字符
- 每个 `helm-xxx` 分支必须有对应的用户分支存在

### 文件类型限制

- 禁止上传可执行文件和脚本（.exe, .dll, .so, .bat, .sh 等）
- 仅允许在根目录保留指定的脚本文件（package-all.sh, create-helm-branch.sh）
- Helm Chart 模板中的文件不受此限制

### 大小限制

- 每个分支的总大小不能超过 500MB
- 单个文件的大小不能超过 50MB

### 安全扫描

- 所有提交会自动进行病毒扫描
- 发现可疑文件会导致提交被拒绝
- 禁止上传包含恶意代码的文件

> **注意**：违反以上安全规范的提交将被自动拒绝，并会触发警告。如有特殊需求，请联系仓库管理员。

## 目录结构规范

每个用户分支需遵循以下目录结构：

```
charts/
└── stable/                   # 稳定版应用目录
    ├── app-name-version/     # 应用名称和版本号
    │   └── app-name/         # 实际的Chart目录
    │       ├── Chart.yaml    # Chart元数据
    │       ├── values.yaml   # 默认配置
    │       └── templates/    # K8s资源模板
    │           ├── deployment.yaml
    │           └── ...
    └── another-app-version/  # 另一个应用
        └── another-app/
            └── ...
```

## 在容器平台中使用租户 Helm 仓库

1. 登录应用管理平台控制台
2. 进入**应用商店**或**应用目录**
3. 添加**应用仓库**或**Helm 仓库**
4. 填写以下信息：
   - 名称：自定义一个名称
   - URL：`https://raw.githubusercontent.com/{仓库所有者}/{仓库名}/helm-{你的分支名}/`
   - 描述：可选
5. 完成添加

## 故障排除

### 如果 helm 分支没有自动创建

有时由于 GitHub Actions 权限或配置问题，自动创建过程可能会失败。可以使用以下方法解决：

#### 方法 1：手动触发 GitHub Actions

1. 在仓库页面，点击 "Actions" 标签
2. 选择 "Release Charts" 工作流
3. 点击 "Run workflow" 按钮
4. 输入你的分支名称（不包含 refs/heads/ 前缀）
5. 点击 "Run workflow" 按钮运行

#### 方法 2：使用本地脚本（所有用户都可使用）

仓库中提供了 `create-helm-branch.sh` 脚本，**任何有仓库写入权限的用户**都可以使用它来创建自己的 helm 分支：

```bash
# 确保你在你的用户分支上
git checkout your-branch-name

# 给脚本添加执行权限
chmod +x create-helm-branch.sh

# 运行脚本创建并推送 helm 分支
./create-helm-branch.sh
```

此脚本会：

- 打包当前分支中的所有 Chart
- 创建或更新 `helm-{当前分支名}` 分支
- 将打包好的内容推送到该分支
- 显示可用于添加到容器平台的 URL

> **注意**：每个用户只能创建和更新与自己的用户分支对应的 helm 分支。脚本会检查并阻止在 main 或已有的 helm 分支上运行。

### 常见问题

1. **权限错误 (403)**：确保在仓库设置中启用了 "Read and write permissions" 给 GitHub Actions
2. **找不到 Chart**：确保你的 Chart 按照正确的目录结构组织
3. **分支名错误**：确保你没有在 `main` 或 `helm-` 开头的分支上工作
4. **安全检查失败**：检查是否违反了上述安全规范
5. **格式检查失败**：确保 Chart 严格遵循[格式要求](./charts/stable/TEMPLATE/README.md)

## 例子

假设：

- 仓库所有者: `organization`
- 仓库名称: `helm-charts-repo`
- 你的用户分支: `company-xyz`

你需要：

1. 创建 `company-xyz` 分支
2. 在该分支的 `charts/stable/` 下添加你的 Charts
3. 确保 Chart 格式严格遵循标准格式
4. 提交并推送
5. 系统会创建 `helm-company-xyz` 分支，包含所有打包好的 Chart
6. 在容器平台中添加应用仓库，URL 为：`https://raw.githubusercontent.com/organization/helm-charts-repo/helm-company-xyz/`

## 本地测试

用户也可以在本地测试他们的 Chart：

```bash
# 切换到你的用户分支
git checkout your-branch-name

# 执行打包脚本
./package-all.sh

# 使用本地仓库测试
helm repo add my-local-repo file://$(pwd)/chart-releases
helm repo update
helm search repo my-local-repo
```

## 仓库设置（仅管理员）

如果你是本仓库的管理员，确保：

1. 在仓库设置 -> Actions -> General 中：

   - 将 "Workflow permissions" 设置为 "Read and write permissions"
   - 勾选 "Allow GitHub Actions to create and approve pull requests"

2. 为用户提供指导，说明如何创建分支并添加 Charts

3. 定期审核仓库分支，清理长时间未使用的分支

## 内置应用示例

本仓库内置了一些示例应用，可以作为参考：

- [Uptime Kuma](./charts/stable/uptime-kuma-0.1.1/uptime-kuma/README.md) - 一个开源的网站监控工具1
