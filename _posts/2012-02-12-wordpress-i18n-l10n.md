---
layout: post
title: WordPress 的 i18n 和 l10n 流程
tags: ['WordPress']
---
{% include JB/setup %}

WordPress 对 i18n 和 l10n 有着很完善的支持。最近在做 V2Press 的时候把 i18n 和 l10n 的流程走了一遍，在此做个记录，备查。

我的开发环境架设在 Mac OS X 上，所以以下操作均在此系统中完成。Windows 系统请酌情参考。

## 1 安装组件

WordPress 的 i18n 和 l10n 是通过 [GNU gettext](http://www.gnu.org/software/gettext/) 实现的，因此在进行实际工作之前，首先需要安装相关的组件。

### 1.1 XCode

XCode 是 Mac OS 中的常用 IDE 之一，其中也包含了编译相关的库，比如 gcc，在后面会用到 gcc 库，所以首先要安装 XCode。XCode 在购买苹果电脑产品的附带安装盘中有。安装过程中一定要选择安装编译组件。

### 1.2 homebrew

[homebrew](http://mxcl.github.com/homebrew/) – The missing package manager for OS X，用来安装 \*nix 系统中常用的库包。homebrew 的安装方法请参照 [homebrew wiki Installation](https://github.com/mxcl/homebrew/wiki/installation)。

### 1.3 gettext

如果以上所需组件已经安装完毕，那么可以继续以下步骤。打开 Terminal，运行以下命令：

    brew install gettext

等待片刻，自动编译完成后即可。gettext 被安装在 `/usr/local/Cellar` 目录中。

为了能够使用 gettext 中相关的命令，还需要修改 `$PATH`，打开 `~/.profile` 将 `/usr/local/Cellar/gettext/0.18.1.1/bin` 加入其中：

    export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/Cellar/gettext/0.18.1.1/bin:/Developer/usr/bin:$PATH"

关闭该文件，在 Terminal 中执行以下命令加载新的 `$PATH`：

    source ~/.profile

### 1.4 WordPress i18n 工具

WordPress 的 i18n 和 l10n 相关工具放在 svn 中。这些工具可以方便的为我们添加 textdomain，生成 POT 文件。

在 Terminal 中执行以下命令安装：

    svn co http://svn.automattic.com/wordpress-i18n/tools/trunk/ ./

以上命令将这些工具安装到当前目录中。

## 2 工作流程

WordPress 的 i18n 和 l10n 的工作流程大概是这样的：

1.  在主题或插件中为 l10n 留下接口，也就是合理的使用 `__()`、`_e()`、`_x()`、`_n()` 等函数；
1.  在上述的接口函数中指定 textdomain；
1.  生成 POT 文件；
1.  生成 PO 文件；
1.  本地化，即翻译相应的词条；
1.  生成 MO 文件。

### 2.1 l10n 接口

WordPress 定义了很多 l10n 接口函数，详细用法可以参照 `wp-includes/l10n.php`。在主题制作或插件开发的过程中，最好同时加入相应的 textdomain。如果没加入，后期可以通过 WordPress 的 i18n 工具来加入，在 Terminal 执行以下命令：

    php add-textdomain.php -i domain phpfile phpfile ...

### 2.2 生成 POT 文件

主题制作完成或插件开发完成后，便可以通过前期预留的接口将需要本地化的词条摘出来，放到一个特殊的文件中，这个文件就是 POT 模板文件。执行以下命令来生成主题的 POT 文件：

    php makepot.php wp-theme /path/to/theme /path/to/potfile.pot

如果需要生成插件的 POT 文件，将上述命令中的 `wp-theme` 换成 `wp-plugin` 即可。更多用法可以执行 `php makepot.php` 命令查看。

一个好的习惯是，将生产的 POT 及下面生成的 PO、MO 文件放在主题文件夹或插件文件夹下的 `languages` 目录中。

### 2.3 生成 PO 文件

上一步中生成的 POT 只是一个模板，是为各语言本地化提供的一个样板，也就是指明哪些词条需要翻译。真正的翻译过程是在 PO 文件中进行的。

复制上一步生成的 POT 文件，修改文件后缀为 `po`，并重命名为相应语言代码。比如简体中文，其文件名为 `zh_CN.po`。注意，插件的 PO 文件命名规则是：`plugin-slug-zh_CN.po`。

使用文本编辑器打开 PO 文件，然后进行词条的翻译。

### 2.4 生成 MO 文件

PO 文件是给人类用的，机器则需要 MO 文件。执行以下代码生产 MO 文件：

    msgfmt -o zh_CN.mo zh_CN.mo

作为一个开发者，只需提供 POT 文件即可。而在生产环境中，只需上传相应的 MO 文件即可。

## 3 参考文章

*   [I18n for WordPress Developers](http://codex.wordpress.org/I18n_for_WordPress_Developers)
*   [Translating WordPress](http://codex.wordpress.org/Translating_WordPress)
*   [Translating WordPress Plugins & Themes](http://urbangiraffe.com/articles/translating-wordpress-themes-and-plugins/)
