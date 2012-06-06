---
layout: post
title: 使用 rbenv 安装管理 Ruby
tags: ['Ruby']
---
{% include JB/setup %}

Ruby 有不同的版本会同时存在，现在最新版本是 1.9.3-9125，但是有些开发者仍然使用 1.8.x 系列。而且很多程序只针对特定的 Ruby 版本。所以对 Ruby 做版本管理是即为重要的，这其中也就涉及到安装的问题。

常用的几个 Ruby 版本管理工具有：[rvm](https://github.com/wayneeseguin/rvm)，[rbenv](https://github.com/sstephenson/rbenv)，[ry](https://github.com/jayferd/ry)，[rbfu](https://github.com/hmans/rbfu)。rvm 应该是最早出现、使用最多的，因为过于强大以至于违背了某个 Linux 软件开发原则，所以出现了很多轻便的替代者，其中来自 37signals 的 rbenv 就很受欢迎。ry 和 rbfu 看上去更轻便，不过使用不广泛。所以我最终选择使用 rbenv。

我电脑的环境是：Mac OS X 10.6.8，XCode 3.2.3，终端是 bash。

## 1. 安装 rbenv

在终端中，从 github 上将 rbenv 源码 clone 到本地，然后设置 `$PATH` 等。

    git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
    echo 'eval "$(rbenv init -)"' >> ~/.bash_profile

## 2. 安装 ruby-build

[ruby-build](https://github.com/sstephenson/ruby-build) 这个工具用来安装编译 Ruby 源码，如果选择手动编译，可不使用这个工具。

    mkdir -p ~/.rbenv/plugins
    cd ~/.rbenv/plugins
    git clone git://github.com/sstephenson/ruby-build.git

## 3. 安装 Ruby

使用 ruby-build 可以自动下载编译安装 Ruby 相应的版本，只需指定版本号。

    rbenv install 1.9.3-p125

等待一大会儿，安装完毕后可以查看已经安装的 Ruby 版本：

    rbenv versions

以上命令列出了安装在 rbenv 中的各 Ruby 版本，前面带有 * 号的表示是当前使用的版本。

## 4. 选择一个 Ruby 版本

rbenv 中的 Ruby 版本有三个不同的作用域：全局，本地，当前终端。

### 4.1 设置全局版本
全局版本是在没有找到“当前终端”或“本地”作用域的设置时执行。通过以下命令设置：

    rbenv global 1.9.3-p125

如果要使用系统原有的 Ruby，则通过 `system` 指定：

    rbenv global system

### 4.2 设置本地版本

“本地”作用域是针对各个项目的，因为不同的项目可以基于不同的 Ruby 版本开发。“本地”作用域通过项目文件夹中的 `.rbenv-version` 这个文件进行管理，需要将相应的 Ruby 版本号写入这个文件。这个过程可以通过以下命令执行：

    rbenv local 1.9.2-p290

### 4.3 设置当前终端版本

“当前终端”作用域的优先级最高。通过以下命令设置：

    rbenv shell 1.9.2-p290

设置完毕后可以通过以下命令进行验证：

    which ruby
    rbenv version

## 5. 安装 gem

使用 rbenv 后，gem 还是按照原有的方式进行安装、升级，只是 gem 的安装路径是在 rbenv 文件夹中当前 Ruby 版本文件夹下。而且，安装带有可执行文件的 gem 后，需要执行一个特别的命令，告诉 rbenv 更新相应的映射关系，这个命令在安装新版本的 Ruby 后也需要执行：

    rbenv rehash
