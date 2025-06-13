# baidunetdisk

BaiduNetDisk（百度网盘）Docker版，适用于群晖NAS等环境，支持Web和VNC访问，便于文件下载与管理。该镜像基于 jlesage/docker-baseimage-gui，支持多平台（amd64/arm64），适合家庭和个人自建网盘下载环境。

## 主要特性

- 支持 Web 浏览器访问（5800端口），无需客户端即可操作百度网盘
- 支持 VNC 协议远程桌面访问（5900端口，可选）
- 支持多平台（amd64/arm64）
- 支持自定义下载目录和配置目录持久化
- 支持自定义 VNC 密码、UID/GID、界面语言
- 群晖NAS等Docker环境可直接部署

## 工作负载类型

此 Helm Chart 使用 `Deployment` 工作负载类型，适合无状态应用，方便快速扩展和更新。

## 参数

| 参数                | 描述               | 默认值         |
|---------------------|--------------------|---------------|
| replicaCount        | 副本数量           | `1`           |
| workloadType        | 工作负载类型       | `Deployment`  |
| image.repository    | 镜像名称           | `johngong/baidunetdisk` |
| image.tag           | 镜像标签           | `latest`      |
| image.pullPolicy    | 镜像拉取策略       | `IfNotPresent`|
| service.type        | 服务类型           | `ClusterIP`   |
| service.ports.web   | Web界面端口        | `5800`        |
| service.ports.vnc   | VNC端口            | `5900`        |
| persistence.enabled | 是否启用持久化存储 | `true`        |
| persistence.size    | 存储大小           | `10Gi`        |
| persistence.mounts  | 挂载路径           | `/config`, `/config/baidunetdiskdownload` |
| env                | 环境变量配置       | 见下文        |

## 环境变量

| 环境变量      | 描述                 | 默认值      |
|---------------|----------------------|------------|
| VNC_PASSWORD  | VNC远程访问密码      |            |
| USER_ID       | 容器内运行进程的UID  | `1000`     |
| GROUP_ID      | 容器内运行进程的GID  | `1000`     |
| NOVNC_LANGUAGE| noVNC界面语言        | `zh_Hans`  |

## 数据存储

- `/config`：配置文件目录（包括登录信息、设置等）
- `/config/baidunetdiskdownload`：下载文件存储目录

启用持久化存储后，数据将保存在持久卷中，即使容器重启也不会丢失。请根据实际需求分配合适的存储空间，推荐生产环境至少 10Gi。

## 使用说明

- Web访问：`http://<主机IP>:5800`，首次登录需扫码或输入百度账号
- VNC访问（可选）：`<主机IP>:5900`，需设置VNC密码
- 下载目录和配置目录可通过挂载本地路径实现持久化
- 如遇无法登录或设置异常，可删除 `/config/baidunetdiskdata.db` 或 `userConf.db` 后重启容器

## 参考链接

- 项目主页：[https://github.com/gshang2017/docker](https://github.com/gshang2017/docker)
- 镜像仓库：[https://hub.docker.com/r/johngong/baidunetdisk](https://hub.docker.com/r/johngong/baidunetdisk)
- 基础镜像：[https://github.com/jlesage/docker-baseimage-gui](https://github.com/jlesage/docker-baseimage-gui)