---
layout: book
book_category: other
---

## 简介

Docker 正在迅速改变团队大规模部署软件的方式。可是，要想理解如何在现有的工作流程中使用 Linux 容器，以及如何正确集成 Docker可不是件容易的事。这本实用的指南会教你如何使用 Docker 打包应用及其所有依赖，如何测试、分发和弹性伸缩容器，以及如何让生产环境支持容器。

本书作者是 New Relic 公司的两名首席网站可靠性工程师，他们在 Docker 发布不久之后就开始使用了。本书内容是根据他们在生产环境中使用 Docker 的经验写就的，目的是让你了解这项技术的优势，避免他们曾犯过的错误。

- 学习如何使用 Docker 简化依赖管理和应用的部署流程
- 着手使用 Docker 映像，容器和命令行工具
- 使用实用的技术在生产环境中部署和测试基于 Docker 的 Linux 容器
- 理解容器的组成和内部机理，便于调试
- 在数据中心或云环境中大规模部署容器
- 探讨一些 Docker 的高级话题，包括部署工具，网络，编排，安全和配置

## 作者

**Sean Kane** 现在是 New Relic 公司的首席网站可靠性工程师。他进入生产运维这一行很久了，在很多行业中工作过，有很多不同的头衔。他在各种聚会和技术会议（例如 Velocity）上做过演讲，涉及疲劳预警和硬件自动化等话题。Sean 的青年时期基本在国外度过，探索生活的真谛。他毕业于琳琳兄弟-巴纳姆-贝利小丑学院，在美国中央情报局做过两次暑期实习生，在阿拉斯加州开发了自己的第一个网站。他与妻子和孩子们一起住在美国太平洋西北地区，过着幸福的生活。他喜欢旅行和天体摄影。

**Karl Matthias** 在初创公司和财富 500 强公司做过开发者、系统管理员和网络工程师。他在德国和英国为初创公司工作过几年，最近与家人一起回到俄勒冈州波特兰市，在 New Relic 公司任职首席网站可靠性工程师。工作之余，他喜欢和两个女儿一起玩，使用复古相机拍电影，或者骑自行车。

## 目录

加工中。

## 勘误

加工中。

## 大事记

- 2015.07.20 开始翻译；
- 2015.08.17 校对草稿；
- 2015.08.18 校对完成，提交审核；

## 词汇表

书中有大量术语，翻译过程中主要参照“[全国科学技术名词审定委员会](http://www.term.gov.cn/)”审定的词汇表，也参阅了已出版的相关书籍。

| 英文 | 中文 | 备注 |
|------|-----|-----|
| architect | 架构师 | |
| artifact | 构建产物 | |
| at scale | 大规模 | |
| atomic host | 基元主机 | |
| base image | 基础映像 | |
| bind mount | 绑定挂载 | |
| blkio | 块设备的 IO | |
| block storage | 块存储器 | |
| bridge interface | 网桥接口 | |
| bundle | 构建包 | |
| container | 容器 | |
| CPU pinning | CPU 关联 | |
| DBus | 数据总线 | |
| delivery | 交付 | |
| distributable | 便于分发的 | |
| dive into | 探讨 | |
| Domain Name Service | 域名服务 | 简称 DNS |
| early build | 早期版本 | |
| enabling technology | 使能技术 | |
| enabling | 给力 | |
| ephemeral | 临时的 | |
| execution driver | 执行驱动 | |
| externalized-state | 状态外存 | |
| feature set | 功能集合 | |
| free memory | 闲置内存 | |
| freezer | 冻结程序 | |
| full hash | 完整哈希值 | |
| golden image | 黄金映像 | |
| hand-off point | 中转站 | |
| horizontal scale | 横向扩展 | |
| hypervisors | （虚拟机的）监控程序 | |
| image | 映像 | |
| inbound request | 入站请求 | |
| kill | 清除 | |
| killer | 清除程序 | |
| load balancer | 负载均衡程序 | |
| log rotation | 日志回旋 | |
| log router | 日志选路器 | |
| man page | 手册页 | |
| Media Access Control | 媒体访问控制 | 简称 MAC |
| mount point | 挂载点 | |
| mount | 挂载 | |
| network address translation | 网络地址转换 | 简称 NAT |
| network block | 网段 | |
| network fabric | 网络布局 | |
| operations team | 运维团队 | |
| orchestration | 编排 | |
| outbound request | 出站请求 | |
| pluggable | 可更换的 | |
| private subnet block | 专用子网网段 | |
| process manager | 进程管理器 | |
| release cycle | 发布周期 | |
| runlevel | 运行级别 | |
| scalable | 可弹性伸缩的 | |
| scale out | 横向扩展 | |
| scale out | 纵向扩展 | |
| search domain | 搜索域 | |
| ship | 推出（产品等），上传 | |
| short hash | 简短哈希值 | |
| swap | 交换空间 | |
| system tray | 系统托盘 | |
| ulimits | 用户权限 | = user limits |
| unit file | 单元文件 | |
| Unix Timesharing System | Unix 分时系统 | 简称 UTS |
| user limits | 简称 ulimits，用户权限 | |
| vertical scale | 纵向扩展 | |
| virtual bridging | 虚拟桥接 | |
| wildcard cert | 泛域证书 | |
| zero-down-time deployment | 不下线部署 | |
{:class="table table-bordered"}
