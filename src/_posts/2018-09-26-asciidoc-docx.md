---
layout: post
title: Asciidoc 转 Word 文档
color: red
tags: ['Dev']
---

在我的电子书制作过程中，[Asciidoc](http://www.methods.co.nz/asciidoc/) 是书写文稿的语言，由此生成三种格式的电子书：PDF，ePub 和 mobi。不过，出版社多数要求提供 .doc(x) 格式的文件，也就是 Word 文档。这时用 Asciidoc 就没那么方便了。

但我还是喜欢用轻量级的纯文本书写语言，为此，之前我一直使用 Markdown，然后经由 [pandoc](https://pandoc.org) 生成 Word 文档。在这个过程中，要对生成的文档做些[定制]({% post_url 2015-06-01-docx-hack-guide %})。

```
           pandoc
Markdown ---------> Word
```

不过，Markdown 句法的语义没有 Asciidoc 丰富，不太适合用于撰写书稿。忍受 Markdown 一段时间之后，我还是回归到 Asciidoc 上了。这就遇到一个问题，怎么把 Asciidoc 文件转换成 Word 文档？

前期，我采用的方法是先生成 PDF 文档，然后利用转换工具，把 PDF 文档转换成 Word 文档。这方面的软件很多，不过结果不太尽如人意，出版社的编辑经常抱怨格式混乱。

```
           Prince        转换工具
Asciidoc ---------> PDF ---------> Word
```

抱怨多了，我却没有习惯，而是一直在寻找趁手的工具。在翻译《CSS: The Definitive Guide, 4th Edition》一书的过程中，偶遇了 [XMLmind](http://www.xmlmind.com/foconverter/) 这个工具。

简单来说，XMLmind 能把 [XSL-FO](https://www.w3.org/TR/2001/REC-xsl-20011015/) 文件转换成一些常见的富文本格式：

- RTF（Word 2000+）
- .doc 文档（Word 2003+）
- .docx 文档（Word 2007+）
- .odt 文档（OpenOffice）

它的主要优点是与 Prince 很像，都把样式表应用到纯文本文件上，生成相应格式的文档。Prince 生成的是 PDF 文档，XMLmind 生成的是 Word 文档；Prince 用的是 CSS 样式表，而 XMLmind 用的是在 FO 基础上定制的一种专用样式表。

放在整个过程中看，使用 Prince 生成 PDF 文档时，介于 Asciidoc 和 PDF 之间的是 (X)HTML，而对 XMLmind 来说，位于中间的是 XSL-FO。虽然中间多了一步，但这也不失为一种可行的方式。

```
                            XMLmind
Asciidoc ---------> XSL-FO ---------> Word
```

当然，XMLmind 最大的问题在于它用的专用样式表：没有 CSS 那么强大。比如，没有继承和层叠。
