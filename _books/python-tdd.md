---
layout: book
title: Python Web 开发：测试驱动方法
signed_version: yes
---

<aside class="purchase">
    <p><img class="border" src="{{ site.baseurl }}/assets/images/covers/python-tdd.jpg" title="{{ page.title }}" /></p>
    <h5>购买：</h5>
    <ul>
        {% if page.signed_version %}<li><a href="{{ site.baseurl }}/buy/" title="购买译者签名版">译者签名版</a></li>{% endif %}
        <li><a href="http://www.amazon.cn/gp/product/B016I9T8SQ/ref=as_li_ss_tl?ie=UTF8&camp=536&creative=3132&creativeASIN=B016I9T8SQ&linkCode=as2&tag=aboutac-23" title="到亚马逊购买" target="_blank">亚马逊</a></li>
        <li><a href="http://item.jd.com/11783873.html" title="到京东购买" target="_blank">京东</a></li>
        <li><a href="http://product.china-pub.com/3804291" title="到 China Pub 购买" target="_blank">China Pub</a></li>
    </ul>
</aside>

## 简介

本书通过从头开发一个真实的 Web 应用，介绍了 Python 测试驱动开发的优势。读者将学会如何在构建应用的每个部分之前编写和运行测试，然后用最少的代码通过这些测试。在此过程中，读者将学到 Django、Selenium、Git、jQuery 和 Mock 的基础知识，以及当前 Web 开发的技巧。

英文原书网站：<http://www.obeythetestinggoat.com/>。

## 作者

Harry J.W. Percival 的童年很美好，他在 Thomson T-07（当时在法国很流行，按键后会发出“啵噗”声）这种 8 位电脑上摆弄 BASIC，长大后做了几年经管顾问，但完全不快乐。而后他发现了自己真正的极客潜质，又很幸运地遇到了一些极限编程狂热者，参与开发了电子制表软件的先驱 Resolver One，不过很可惜，这个软件现在已经退出历史舞台。他现在在 PythonAnywhere LLP 公司工作，而且在各种演讲、研讨会和开发者大会上积极向世人传播 TDD。

## 目录

- 前言
- 准备工作和应具备的知识
- 致谢
- 第一部分 TDD 和 Django 基础
    - 第 1 章 使用功能测试协助安装 Django
    - 第 2 章 使用 `unittest` 模块扩展功能测试
    - 第 3 章 使用单元测试测试简单的首页
    - 第 4 章 编写这些测试有什么用
    - 第 5 章 保存用户输入
    - 第 6 章 完成最简可用的网站
- 第二部分 Web 开发要素
    - 第 7 章 美化网站：布局、样式及其测试方法
    - 第 8 章 使用过渡网站测试部署
    - 第 9 章 使用 Fabric 自动部署
    - 第 10 章 输入验证和测试的组织方式
    - 第 11 章 简单的表单
    - 第 12 章 高级表单
    - 第 13 章 试探 JavaScript
    - 第 14 章 部署新代码
- 第三部分 高级话题
    - 第 15 章 用户认证、集成第三方插件以及 JavaScript 模拟技术的使用
    - 第 16 章 服务器端认证，在 Python 中使用模拟技术
    - 第 17 章 测试固件、日志和服务器端调试
    - 第 18 章 完成“My Lists”页面：由外而内的 TDD
    - 第 19 章 测试隔离和“倾听测试的心声”
    - 第 20 章 持续集成
    - 第 21 章 简单的社会化功能、页面模式，以及练习
    - 第 22 章 测试运行速度的快慢和炽热的岩浆
- 遵从测试山羊的教诲
- 附录 A PythonAnywhere
- 附录 B 基于类的 Django 视图
- 附录 C 使用 Ansible 配置服务器
- 附录 D 测试数据库迁移
- 附录 E 接下来做什么
- 附录 F 速查表
- 附录 G 参考书目
- 作者简介
- 封面介绍

## 源码

随书源码托管在 GitHub 中，地址：<https://github.com/hjwp/book-example/>。

## 勘误

如果您在阅读本书过程中发现了错误，[欢迎指正](http://www.ituring.com.cn/book/1486 "提交勘误")。

## 大事记

- 2014.07.24 试译；
- 2014.08.04 开始翻译；
- 2014.09.28 初译完成；
- 2014.10.07 校对；
- 2014.10.16 校对完成，提交审核；
- 2015.10 出版；
- 2015.10.24 收到样书；

## 词汇表

书中有大量术语，翻译过程中主要参照“[全国科学技术名词审定委员会](http://www.term.gov.cn/)”审定的词汇表，也参阅了已出版的相关书籍。

| 英文 | 中文 | 备注 |
|-----|------|-----|
| acceptance test | 验收测试 | |
| aside | 旁注 | |
| assertion | 判定数据 | |
| Big Design Up Front | 预先做大量设计 | |
| black box test | 黑箱测试 | |
| capture group | 捕获组 | |
| code listing | 代码清单 | |
| code smell | 代码异味 | |
| crash | 死机，（程序或进程）崩溃 | |
| duck typing | 鸭子类型 | |
| end-to-end test | 端到端测试 | |
| expected failure | 预期失败 | |
| Federated Authentication System | 联合认证系统 | |
| functional test | 功能测试 | |
| further reading | 延伸阅读 | |
| good practice | 习惯做法 | |
| grid system | 栅格系统 | |
| headless browser | 无界面浏览器 | |
| integrated test | 整合测试 | |
| inventory file | 清单文件 | |
| invoice | 发票 | |
| isolated test | 隔离测试 | |
| keypair | 密钥对 | |
| minimum viable | 最简可用的 | |
| modifier key | 修改键 | |
| Object-Relational Mapping | 对象关系映射，简称 ORM | |
| offby-one error | 差一错误 | |
| pair programming | 结对编程 | |
| playbook | 脚本 | |
| positional argument | 位置参数 | |
| private key | 私钥 | |
| public key | 公钥 | |
| queryset | 查询集合 | |
| replay attack | 重放攻击 | |
| root logger | 根日志记录器 | |
| rounding error | 舍入误差 | |
| secret key | 密钥 | |
| security exploit | 安全漏洞 | |
| spiking | 探究（极限编程术语） | |
| stack trace | 堆栈跟踪 | |
| string representation | 字符串表示形式 | |
| symlink | 符号链接 | |
| test runner | 测试运行程序 | |
| tick-box | 勾选框 | |
| ticket | （issue 系统的）工单 | |
| to-do list | 待办事项清单 | |
| traceback | 调用跟踪 | |
| virtual display | 虚拟显示器 | |
| workshop | 研讨会 | |
{:class="table table-bordered"}
