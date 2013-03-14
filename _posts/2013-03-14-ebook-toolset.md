---
layout: post
title: 制作电子书的工具集
tags: ['Book']
---

在制作[《Ruby on Rails Tutorial》中文版](http://about.ac/rails-tutorial-2nd-cn)电子书的过程中积累了一些经验，记录如下。

这本书我用了 5 个多月的时间才翻译完，其中大概三分之一的时间都用在编写生成电子书所需的工具上了。期间上了两个月晚班，有很多空闲时间，所以我在网上到处搜索可用的工具，用来生成电子书。我的要求很简单：

- 使用 Markdown 撰写文本；
- 能够生成 PDF，Epub 和 Mobi 格式的电子书；
- 可以自动生成目录；

就这三个简单的要求，我还是没能找到称心的工具。首先被我否定的是 [Sphinx](http://sphinx.pocoo.org/) 和 [Pandoc](http://johnmacfarlane.net/pandoc/)。这两个工具用的人比较多，功能也比较完善，但 Sphinx 只支持 reStructuredText 格式，而且是用 Python 开发的，我不太熟悉这种编程语言，而且我觉得这个工具太复杂。而 Pandoc 很强大，似乎用起来也不复杂，但是还是被否了，原因很简单，Haskell？这是哪个星球的语言？

否了这两个之后，我又接着寻找，这一次集中经历寻找使用 Ruby 开发的工具，结果找到两个，似乎用的人比较多：[kitabu](https://github.com/fnando/kitabu) 和 [bookshop](https://github.com/blueheadpublishing/bookshop)。kitabu 还不错，基本的要求都能满足我的要求，但是看了代码后我才发现自动生成目录大代码对中文完全无用，而且这个 gem 功能又太简单了。bookshop 完全就不支持 Markdown。

又是一阵搜索，最后找到了 [easybook](http://easybook-project.org/)，完全能满足我的要求，只有一点，是用 PHP 开发的。本来我想 PHP 就 PHP，反正代码也能看懂，想定制的话也可以，但是当我使用了十几分钟后就决定放弃了，PHP 毕竟还不能胜任 CLI。

找了很多工具，相互比较，也觉得累了，干脆就直接把生成电子书的任务交给 [Leanpub](http://leanpub.com/) 吧。动了这个念头之后，我花了点时间熟悉了 Leanpub 的工作流程，也看了生成的文件，但觉得可定制的内容太少了，我是个外观控，如果不能自己定制生成的文件格式，我宁愿不用。所以最后我还是放弃使用 Leanpub。但是，Leanpub 对电子书做的一些处理被我借鉴了，具体内容参见下面的说明。

我决定不在继续找了，所以就总结了一下这几个工具各自的优缺点。最终我决定以 easybook 为蓝本，参照其他几个工具可取的部分，自己编写一个程序，名字嘛就叫做 bookstrap。

其实 bookstrap 只是个 wrapper，使用 Ruby 编写，是个命令行工具，先把 Markdown 转换成 HTML，然后生成 PDF、Epub 和 Mobi 格式电子书。详情如下。

## 文本

文本肯定要用 Markdown，这是我最熟悉的文本书写语言。决定使用 Markdown 之后就要考虑使用那个工具将其生成 HTML 了，可选的工具太多了，我第一个想到的是 [redcarpet](https://github.com/vmg/redcarpet)，我之前使用 Jekyll 开发的网站用的就是这个 gem，而且它还对基本的 Markdown 语法做了一些扩展。不过用起来还是觉得句法太少了，而且这个 gem 是用 C 语言编写的，很难扩展，所以我放弃了。

接下来又找到了 [multimarkdown](http://fletcherpenney.net/multimarkdown/)，这是 Markdown 基本语法的一个扩展集，增加了很多实用的句法。但是似乎还是无法满足我的要求，而且相应的转换程序 [peg-multimarkdown](https://github.com/fletcher/peg-multimarkdown) 也是用 C 语言开发的，不易扩展。

最后，我想到了 Leanpub。Leanpub 使用的是 [kramdown](https://github.com/gettalong/kramdown)，所以我决定试一下。kramdown 是使用 Ruby 开发的，而且很容易扩展语法，试用了一段时间之后，我决定就使用它了。我还开发了 [Leanpub 对 kramdown 语法的扩展](https://leanpub.com/help/manual)，这样 Markdown 转换工具就有了。

## 生成 PDF

....待续
