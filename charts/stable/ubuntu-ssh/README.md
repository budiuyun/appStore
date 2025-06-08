# ubuntu-ssh

带有SSH服务的Ubuntu镜像，支持远程管理

## 工作负载类型

此Helm Chart使用 `Deployment` 工作负载类型。

- Deployment适合无状态应用，方便快速扩展和更新

## 参数

| 参数 | 描述 | 默认值 |
|------|------|--------|
| replicaCount | 副本数量 | `1` |
| workloadType | 工作负载类型 | `Deployment` |
| image.repository | 镜像名称 | `niehaoran/ubuntu-ssh` |
| image.tag | 镜像标签 | `22.04` |
| image.pullPolicy | 镜像拉取策略 | `IfNotPresent` |
| service.type | 服务类型 | `ClusterIP` |
| securityContext.enabled | 是否启用安全上下文配置 | `true` |
| securityContext.pod.runAsNonRoot | 是否以非root用户运行Pod | `false` |
| securityContext.pod.runAsUser | Pod运行的用户ID | `0` |
| securityContext.container.privileged | 容器是否运行在特权模式 | `false` |
| securityContext.container.allowPrivilegeEscalation | 是否允许特权升级 | `false` |
| securityContext.container.runAsUser | 容器运行的用户ID | `0` |
| persistence.enabled | 是否启用持久化存储 | `true` |
| persistence.size | 存储大小 | `1Gi` |
| env | 环境变量配置 | 见下文 |


## 环境变量

应用程序支持以下环境变量配置：

| 环境变量 | 描述 | 默认值 |
|---------|------|--------|
| ROOT_PASSWORD | SSH登录的root用户密码 | `budiu123` |
| TZ | 容器的时区设置 | `Asia/Shanghai` |


## 安装方法

```bash
helm install my-release ./ubuntu-ssh
```

## 注意事项

- 如果在某些环境中出现AppArmor相关的问题（如错误: failed to create containerd task），这是因为某些Kubernetes环境默认启用了AppArmor但主机没有正确配置。解决方案：
  1. 启用特权模式：设置 `securityContext.container.privileged=true`
  2. 禁用AppArmor：确保 `securityContext.disableAppArmor=true`
  3. 如果问题仍然存在，可能需要检查主机节点的AppArmor配置或完全禁用它（需要管理员权限）
- 确保ROOT_PASSWORD不使用特殊字符，以免SSH登录时出现问题。