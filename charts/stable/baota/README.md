# baota

宝塔Linux面板是一款提升运维效率的服务器管理软件，支持一键LAMP/LNMP/集群/监控/网站/FTP/数据库/JAVA等100多项服务器管理功能，界面友好，安全可靠，适合个人和企业服务器运维。

## 工作负载类型

此 Helm Chart 使用 `Deployment` 工作负载类型，适合无状态应用，方便快速扩展和更新。

## 参数

| 参数                | 描述               | 默认值         |
|---------------------|--------------------|---------------|
| replicaCount        | 副本数量           | `1`           |
| workloadType        | 工作负载类型       | `Deployment`  |
| image.repository    | 镜像名称           | `btpanel/baota` |
| image.tag           | 镜像标签           | `latest`      |
| image.pullPolicy    | 镜像拉取策略       | `IfNotPresent`|
| service.type        | 服务类型           | `ClusterIP`   |
| service.ports.panel | 面板服务端口       | `8888`        |
| service.ports.ssh   | SSH端口            | `22`          |
| service.ports.http  | HTTP端口           | `80`          |
| service.ports.https | HTTPS端口          | `443`         |
| service.ports.phpmyadmin | phpMyAdmin端口 | `888`         |
| service.ports.ftp   | FTP端口            | `21`          |
| service.ports.mysql | MySQL端口          | `3306`        |
| persistence.enabled | 是否启用持久化存储 | `true`        |
| persistence.size    | 存储大小           | `10Gi`        |
| persistence.mounts  | 挂载路径           | 见下文        |
| env                | 环境变量配置       | 见下文        |

## 持久化存储

宝塔面板的数据默认挂载在以下路径：
- `/www/wwwroot` - 网站根目录
- `/www/server/data` - 服务器数据
- `/www/server/panel/vhost` - 虚拟主机配置

启用持久化存储后，数据将保存在持久卷中，即使容器重启也不会丢失。请根据实际需求分配合适的存储空间，推荐生产环境至少 10Gi。

## 环境变量

应用程序支持以下环境变量配置：

| 环境变量           | 描述                       | 默认值           |
|--------------------|----------------------------|------------------|
| TZ                 | 时区设置                   | `Asia/Shanghai`  |

## 应用介绍

宝塔Linux面板是一款简单好用的服务器运维管理软件，支持一键安装LAMP/LNMP/集群/监控/网站/FTP/数据库/JAVA等100多项服务器管理功能。通过可视化界面，大幅降低了服务器运维的技术门槛，提高运维效率。

主要功能包括：
- 网站管理：一键创建、配置和管理网站
- 数据库管理：MySQL/MariaDB管理和备份
- FTP管理：快速创建和管理FTP账户
- 文件管理：在线文件管理器
- 软件管理：一键安装常用服务器软件
- 安全管理：防火墙、SSH安全设置
- 系统监控：CPU、内存、磁盘等资源监控

通过面板（8888端口）可以轻松管理服务器，无需命令行操作，适合各类用户使用。

项目主页：[https://www.bt.cn/](https://www.bt.cn/)