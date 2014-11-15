---
layout: post
title: "升级到 Mavericks"
tags: ['OS X']
---

最近把系统升级到了 Mavericks 10.9.5。观察了好久，最终评估我的电脑应该无法顺畅运行 Yosemite，所以决定安装前一代 OS X。

安装的过程尚算顺利，用时一个半小时左右。这一次我选择的是直接升级，不是全新安装。升级后应用都兼容（我安装的应用实在少的可怜），不过也遇到一些问题。

## 内存

不升级 10.10，最大的担忧就是内存不够。看样子，10.9 也很吃内存，开机后就用掉了 3GB。所以终决定升级内存，把 2x2GB 换成 2x8GB。事后证明这个决策是明智的，因为开 XCode 后内存用量超过了 9GB。

我用的是英睿达的内存条，按照英睿达的系统推荐，最终选定的型号是 CT102464BF160B。因为这个型号的频率是 1600MHz，而电脑原装的是 1333MHz，所以买之前有些犹豫。随后咨询了一些推友，大家的说法不一，不过我决定买回来试试。

装上之后系统能正确识别，目前来看没有什么问题。

## Git

不知什么原因，升级后识别不了 brew 安装的 git，直接使用系统自带的版本。所以，重新使用 brew 安装了 git。

另外，bash prompt 中的 git 设置也失效了，所以[升级了 dotfiles](https://github.com/AndorChen/dotfiles/commit/179b51897ff8eaa454778e4191cd4821de17f9ca)。顺便也把 git 的推送规则设为了 `matching`（[ref](https://github.com/AndorChen/dotfiles/commit/d1af6aad079ccd953ef100eb4324cc7a0508d728)）。

## Ruby

### OpenSSL

在使用 Ruby 的过程中遇到“Library not loaded: /usr/local/opt/openssl/lib/libcrypto.1.0.0.dylib (LoadError)”错误，使用如下方法解决（[via](http://mithun.co/hacks/library-not-loaded-libcrypto-1-0-0-dylib-issue-in-mac/)）：

```sh
# install openssl via brew
$ brew install openssl

# copy files
$ cd /usr/local/Cellar/openssl/1.0.1i/lib
[../1.0.1i/lib] $ sudo cp libssl.1.0.0.dylib libcrypto.1.0.0.dylib /usr/lib/

# re-create symbolic links
[../1.0.1i/lib] $ sudo rm libssl.dylib libcrypto.dylib
[../1.0.1i/lib] $ sudo ln -s libssl.1.0.0.dylib libssl.dylib
[../1.0.1i/lib] $ sudo ln -s libcrypto.1.0.0.dylib libcrypto.dylib
```

### readline

使用 Rails 的过程中遇到“Library not loaded: /usr/local/opt/readline/lib/libreadline.6.2.dylib”错误，使用如下方法解决（[via](http://qiita.com/hoisjp/items/61b5e016f51bc1ac8ed8)）：

```sh
# uninstall old readline
$ brew uninstall readline

# re-install readline
$ brew install readline

# link dylibs
$ brew link --force readline
```

