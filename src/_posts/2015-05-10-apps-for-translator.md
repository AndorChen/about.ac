---
layout: post
title: "翻译时使用的应用"
tags: ['Translation']
---

我的工作电脑是台 MacBook Pro。因此，本文提到的都是 OS X 系统中的应用。本文介绍我在翻译时使用的应用。我选择应用时会使用以下标准：

- 首选系统内置的应用
- 优先选择免费开源的工具
- 使用收费软件的精简免费版
- 迫不得已，再使用收费软件

## Terminal.app (bash)

我的翻译流程基本上是都在命令行中完成，包括创建项目、推送 Git 仓库和提取 PDF 文件中的图像等。我习惯使用系统自带的终端，而且使用的 shell 是 bash。对日常操作来说，bash 足够了，因此我没有使用功能更强的 [zsh](http://www.zsh.org "zsh 的网站") 或 [tmux](http://tmux.sourceforge.net/ "tmux 项目的网站") 等。

## Git

我在命令行中最常执行的是 Git 相关的操作，因为我会为每个翻译项目创建 Git 仓库，并在远程仓库（BitBucket）中备份。我的 Git 使用 [homebrew](http://brew.sh "homebrew 的网站") 管理和更新。

## Sublime Text

翻译时，我都使用纯文本格式撰写译稿，最常使用 [Markdown](http://daringfireball.net/projects/markdown/ "Markdown 的网站")，但是如果可能，我会尽量使用 [AsciiDoc](http://www.methods.co.nz/asciidoc/ "AsciiDoc 的网站")（转换时使用 [Asciidoctor](http://asciidoctor.org "Asciidoctor 的网站")）。

既然是纯文本，一个简单易用的文本编辑器就足够了。我最常使用的文本编辑器是 [Sublime Text](www.sublimetext.com)。我从不使用专门的 Markdown 编辑器，例如 [Mou](http://25.io/mou/ "Mou 的网站") 或 [Marked](http://marked2app.com "Marked 的网站") 等。因为专门的 Markdown 编辑器不支持某些出版社特有的句法，而且我觉得自己并不需要这些应用提供的功能（比如实时预览），所以能不多安装一个应用就不安装。

## Preview.app

很多时候，出版社只会提供原书的 PDF 文档，所以需要一个查看 PDF 的应用。一般情况下我会使用系统内置的 Preview.app，如果需要同时打开多个 PDF 文件（需要标签页功能），我会使用 [PDF Reader X](https://itunes.apple.com/us/app/pdf-reader-x/id684812309 "购买 PDF Reader X")。

## xpdf (pdfimages)

[xpdf](http://www.foolabs.com/xpdf/ "xpdf 的网站") 包含多个用于处理 PDF 文件的命令行工具：

- `pdfinfo`：查看 PDF 的元信息
- `pdffonts`：查看 PDF 文件中使用的字体
- `pdfdetach`：提取 PDF 文件的附件
- `pdftoppm`：把 PDF 文件转换成 `ppm` 格式的图像
- `pdfimages`：提取 PDF 文件中的图像

我最常使用 `pdfimages`，把 PDF 文件中的图像提取出来（因为多数时候，出版社只会提供原书的 PDF 文档，不会提供原始文稿和图像）。Adobe Acrobat 也可以提取图像，不过这是收费应用。注意，`pdfimages` 提取出来的图像是 `ppm` 格式，需要转换成常见的图像格式（例如 `jpg` 或 `png`）。

## ToyViewer.app

[ToyViewer](https://itunes.apple.com/en/app/toyviewer/id414298354 "购买 ToyViewer") 是免费的图像查看应用，支持的格式很多。我主要使用这个应用把 `pdfimages` 从 PDF 文件中提取出来的 `ppm` 格式图像转换成 `jpg` 格式。

如果选择命令行工具，可以使用 [ImageMagick](http://www.imagemagick.org/ "ImageMagick 的网站")。不过我在使用 ImageMagick 时一直遇到问题，所以暂且使用 GUI 应用代替。有时间再解决这个问题。

## pandoc

我一直没用到 [pandoc](http://pandoc.org/ "pandoc 的网站")，直到最近，一个出版社要求提供 `doc` 文档，我才第一次使用 pandoc。我之所以不使用这个工具，其中一个原因是，这个工具是使用 [Haskell 语言](https://www.haskell.org/ "Haskell 语言的网站")开发的。

pandoc 是个命令行工具，作用是在 Markdown 和多种格式之间转换，其中就包含把 Markdown 转换成 `doc` 格式。因为 pandoc 是使用 Haskell 语言开发的，虽然提供了很多其他语言的 API，但扩展起来依然很难。目前，我只使用 pandoc 内置的格式创建 `doc` 文档。

## persie

[persie](https://github.com/AndorChen/persie "persie 在 GitHub 中的仓库") 是我自己开发的一个命令行工具，用于把 AsciiDoc 格式编写的文稿转换成电子书。persie 使用以下三个工具生成电子书：

- [PrinceXML](http://www.princexml.com/ "PrinceXML 的网站")：生成 PDF 格式电子书。PrinceXML 最大的优势是，使用 CSS 定义 PDF 文件的格式。这是个收费软件，不过有免费试用版，而且可以终生使用（不过会在 PDF 文件的第一页加一个 LOGO，但很容易去掉）。
- [gepub](https://rubygems.org/gems/gepub "gepub")：生成 ePub 格式电子书。这是个 Ruby gem。
- [KindleGen](http://www.amazon.com/gp/feature.html?docId=1000765211 "KindleGen 的网站")：生成 mobi 格式电子书。这是 Amazon 提供的工具，部分国家或地区无法下载（需要科学上网）。

我翻译的《[Ruby on Rails 教程](http://railstutorial-china.org "Ruby on Rails 教程的网站")》和自己写的《[Jekyll 小书](https://selfstore.io/products/184/ "购买 Jekyll 小书")》都是使用 persie 制作的电子书。

## Dictionary.app / Youdao.app

翻译时免不了要查字典，我使用的字典类应用有两个：Dictionary.app 和 Youdao.app。Dictionary 主要用于管理术语，我会把每本书中用到的术语制成词典，这样方便以后查找。除此之外，我还把[微软的术语词库](http://www.microsoft.com/Language/zh-cn/Terminology.aspx "下载微软的术语库")制成了词典。

制作词典的方法有两种：

- 使用 Auxiliary Tools。这是 Apple 提供的命令行工具，旧版 OS X 中内置，新版系统要到开发者网站中下载。
- 使用 [DictUnifier.app](https://code.google.com/p/mac-dictionary-kit/ "Mac Dictionary Kit")。这是 GUI 应用，用于转换 stardict 的词典，以便在 Dictionary.app 中使用。

## Sparrow.app

Sparrow 被 Google 收购后虽然销声匿迹了，但我觉得它仍然是 OS X 中最好用的邮件客户端。

翻译时经常需要与出版社或原作者联系，因此有必要使用一个顺手的邮件客户端。

