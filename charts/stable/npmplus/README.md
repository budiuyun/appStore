# npmplus

NPMplus 是 nginx-proxy-manager 的改进分支，提供更易用的反向代理和 TLS 证书管理，支持 HTTP/3、CrowdSec、ModSecurity、GoAccess、负载均衡等高级功能，适合家庭和企业用户轻松实现网站转发与安全防护。

## 工作负载类型

此 Helm Chart 使用 `Deployment` 工作负载类型，适合无状态应用，方便快速扩展和更新。

## 参数

| 参数                | 描述               | 默认值         |
|---------------------|--------------------|---------------|
| replicaCount        | 副本数量           | `1`           |
| workloadType        | 工作负载类型       | `Deployment`  |
| image.repository    | 镜像名称           | `zoeyvid/npmplus` |
| image.tag           | 镜像标签           | `latest`      |
| image.pullPolicy    | 镜像拉取策略       | `IfNotPresent`|
| service.type        | 服务类型           | `ClusterIP`   |
| service.ports.admin | 管理界面端口       | `81`          |
| service.ports.http  | HTTP代理端口       | `80`          |
| service.ports.https | HTTPS代理端口      | `443`         |
| service.ports.goaccess | GoAccess统计端口 | `91`         |
| persistence.enabled | 是否启用持久化存储 | `true`        |
| persistence.size    | 存储大小           | `2Gi`         |
| persistence.mounts  | 挂载路径           | 见下文        |
| env                | 环境变量配置       | 见下文        |

## 持久化存储

NPMplus 的数据默认挂载在以下路径：
- `/data` - 应用数据
- `/opt/npmplus` - 应用配置

启用持久化存储后，数据将保存在持久卷中，即使容器重启也不会丢失。请根据实际需求分配合适的存储空间。

## 环境变量

应用程序支持以下环境变量配置：

| 环境变量           | 描述                       | 默认值           |
|--------------------|----------------------------|------------------|
| TZ                 | 时区设置                   | `Asia/Shanghai`  |
| ACME_EMAIL         | Let's Encrypt 证书申请邮箱 | `admin@example.org` |
| CLEAN              | 自动清理无效 certbot 证书  | `true`          |

## 应用介绍

NPMplus 是 nginx-proxy-manager 的增强版本，提供了更加易用和功能丰富的反向代理和 TLS 证书管理解决方案。它通过直观的 Web 界面，让用户可以轻松管理 Nginx 配置，无需手动编辑复杂的配置文件。

主要功能包括：
- 反向代理：轻松创建和管理反向代理配置
- SSL证书：自动申请、续期和管理 Let's Encrypt 免费证书
- HTTP/3 支持：支持最新的 HTTP/3 协议
- 安全增强：集成 CrowdSec 和 ModSecurity 提供 WAF 功能
- 流量分析：内置 GoAccess 提供实时访问统计和分析
- 负载均衡：支持多目标服务器负载均衡
- 访问控制：支持 IP 限制、基本认证等访问控制功能

通过管理界面（81端口）可以轻松配置和管理所有功能，适合个人和企业用户在内网或公网环境中使用，大幅简化网站和应用的反向代理配置工作。

项目主页：[https://hub.docker.com/r/zoeyvid/npmplus](https://hub.docker.com/r/zoeyvid/npmplus)

## 安装方法

```bash
helm install my-release ./npmplus
```