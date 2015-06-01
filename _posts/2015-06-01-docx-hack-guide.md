---
layout: post
title: docx 文件定制指南
tags: ['开发']
---

我在“[翻译时使用的应用]({{site.baseurl}}{% post_url 2015-05-10-apps-for-translator%})”一文中提到，因为最近翻译的一本书要求提供 `docx` 文件，所以我第一次使用了 [pandoc](http://pandoc.org/)。

Pandoc 是个很强大的工具，能在多种文件格式之间相互转换。不过，我使用 Pandoc 只是为了把 Markdown 文件转换成 `docx` 文件，以便提供给出版社。Pandoc 能很好地完成这项工作，不过转换得到的 `docx` 文件格式不符合我的要求，所以最近几天稍微研究了定制样式的问题。

## `docx` 格式简介

`docx` 是微软为 Word 软件开发的文件格式，其背后是一个国际标准——[Office Open XML](http://officeopenxml.com/)（简称 OOXML）。`docx` 其实是打包文件，把扩展名从 `docx` 改为 `zip` 就能使用解压软件打开，看到其中的内容。解压后的文件结构如下所示：

```
.
├── [Content_Types].xml
├── _rels
├── docProps
│   ├── app.xml
│   └── core.xml
└── word
    ├── _rels
    │   ├── document.xml.rels
    │   └── footnotes.xml.rels
    ├── document.xml
    ├── fontTable.xml
    ├── footnotes.xml
    ├── media
    ├── numbering.xml
    ├── settings.xml
    ├── styles.xml
    ├── theme
    │   └── theme1.xml
    └── webSettings.xml
```

可以看出，大多数都是 XML 文件。我们主要关注其中三个文件：`word/document.xml`，`word/styles.xml` 和 `word/fontTable.xml`。

- `document.xml`：`docx` 文件的内容
- `styles.xml`：`docx` 文件的样式
- `fontTable.xml`：`docx` 文件用到的的字体

`docx` 文件基本上做到了表现和内容分离。`document.xml` 和 `styles.xml` 可以比作 Web 中的 HTML 和 CSS。定制样式时，我们基本上不用修改内容，也就是 `document.xml` 文件。下面着重介绍 `styles.xml` 文件。

`styles.xml` 文件的作用相当于 Web 中的 CSS，只不过这是 XML 文件，而且也不使用 CSS 规则定义样式。下面是一个样式示例：

```
<w:style w:styleId="BodyText" w:type="paragraph">
    <w:name w:val="Body Text"/>
    <w:basedOn w:val="Normal"/>
    <w:link w:val="BodyTextChar"/>
    <w:pPr>
        <w:spacing w:after="180" w:before="180"/>
    </w:pPr>
    <w:rPr>
        <w:rFonts w:ascii="Arial" w:cstheme="majorBidi" w:eastAsia="黑体" w:hAnsiTheme="majorHAnsi"/>
        <w:sz w:val="36"/>
    </w:rPr>
</w:style>
```

`w:styleId` 属性的值是内部 ID，`document.xml` 文件中的结构需要什么样式，就引用这个 ID 的值，就像是 CSS 中的选择符一样。`w:type` 属性是样式的类型，一般只会用到 `paragraph`、`character` 和 `table`。`w:name` 元素中 `w:val` 属性的值是这个样式在 GUI 应用（Word，Pages 或 OpenOffice 等）中显示的名称。`w:basedOn` 元素中 `w:val` 的值是这个样式继承的其他样式 ID；这个元素很重要，用于实现块级元素的样式继承。`w:link` 元素中 `w:val` 的值也是这个样式继承的其他样式 ID，不过这个元素继承的是行内元素的样式。`w:pPr` 元素设定的是段落样式，其中 `w:spacing` 元素用于设置段前和段后距离，单位是二十分之一英寸。`w:rPr` 元素用于设置段落中行内元素的样式，其中 `w:rFonts` 元素用于设置字体（可以分别设置中西文字体），`w:sz` 元素用于设置字号，单位是二分之一点（pt）。

`docx` 文件的样式规则乍看起来很复杂，其实也比较易于理解。我想真正让人觉得难懂的，是 XML 结构。虽然如此，我还是不建议直接手写样式。你可以先在 Word 中通过 GUI 创建样式，然后解压 `docx` 文件，修改样式，或者把样式复制出来，方便以后重用。

另一个可能需要修改的文件是 `fontTable.xml`。这个文件定义 `docx` 文件中用到的所有字体。下面是一个字体定义示例：

```
<w:font w:name="宋体">
    <w:altName w:val="SimSun"/>
    <w:panose1 w:val="02010600030101010101"/>
    <w:charset w:val="86"/>
    <w:family w:val="auto"/>
    <w:pitch w:val="variable"/>
    <w:sig w:csb0="00040001" w:csb1="00000000" w:usb0="00000003" w:usb1="080E0000" w:usb2="00000010" w:usb3="00000000"/>
</w:font>
```

字体的定义看起来比样式简单，其实有很多属性的值是使用某种机制生成的，例如 `w:panose1` 元素的 `w:val` 属性，因此不要自己动手编写。同样，也是先在 Word 中定义好，然后将其复制出来。

## 定制方式

如果只需要定制 `docx` 文件的样式，可以准备好 `styles.xml` 和 `fontTable.xml` 文件，然后替换掉 Pandoc 生成的 `docx` 文件中的这两个文件。例如，在命令行中可以执行下述命令替换：

```
zip -r sample.docx word/styles.xml word/fontTable.xml
```

下面举个定义样式的例子。在一本书中，每一章一般都新起一页，而不是和前一章的内容连在一起。也就是说，新的一章要换页。在 OOXML 中，换页主要由两种方式，这里我们要使用 `w:pageBreakBefore` 元素。后面再介绍另一种方式。按照 Pandoc 的生成方式，一章的标题一般是一级标题，所以我们可以在一级标题的样式中加入 `w:pageBreakBefore` 元素，在一级标题之前换页，如下所示：

```
<w:style w:styleId="Heading1" w:type="paragraph">
    <w:name w:val="Heading 1"/>
    <w:pPr>
      <w:pageBreakBefore/>
    </w:pPr>
</w:style>
```

加入这个样式后，在 `docx` 文件的每个一级标题之前都会换页。

## 过滤器

有时我们需要手动强制换页，这时该怎么做呢？答案是使用[过滤器](http://pandoc.org/scripting.html)。Pandoc 提供了强大的过滤器机制，方便使用者定制。Pandoc 转换文件的过程如下所示：

```
        pandoc         filter         pandoc
source --------> JSON --------> JSON --------> target
```

因此，我们可以使用过滤器修改 Pandoc 生成的 JSON 中间格式。Pandoc 的过滤器有 [Python API](http://github.com/jgm/pandocfilters)、[PHP API](https://github.com/vinai/pandocfilters-php) 和 [Node/JavaScript API](https://github.com/mvhenderson/pandoc-filter-node)。不过我对这些语言都不熟悉，所以自己写了一个“简陋”的 [Ruby API](https://gist.github.com/AndorChen/a07c591fed685fb7a80c)。

下面说明怎么使用过滤器实现手动换页。假设我们在 Markdown 文件中输入 `<!--PAGEBREAK-->` 时是想换页。

```
#!/usr/bin/env ruby

require 'pandocfilter'

filter = lambda do |key, value, format, meta|
  if key == 'RawBlock' && value[1] == '<!--PAGEBREAK-->'
    xml = %(<w:p><w:r><w:br w:type="page"/></w:r></w:p>)

    return PandocFilter::Node.raw_block('openxml', xml)
  end
end

PandocFilter.process &filter
```

在这个过滤器中，我们把 `<!--PAGEBREAK-->` 替换成 OOXML 格式的元素（`raw_block` 方法创建的是 [`RawBlock` 元素](http://hackage.haskell.org/package/pandoc-types-1.12.4.3/docs/Text-Pandoc-Definition.html#v:RawBlock)）。这个元素表示一个段落，但没有内容。换页的关键是 `w:br` 元素，当 `w:type` 属性的值为 `page` 时表示换页。

除了前面举的几个例子之外，我还做了其他定制，这里就不再一一介绍了。

## 总结

虽然我现在基本上实现了所需的 `docx` 文件样式，但使用 Markdown + Pandoc 的方式还是让我觉得别扭。Pandoc 虽然很强大，相对也易于定制，但是 Markdown 有其局限性。Markdown 是为了在 Web 中快速书写而创造的，不是为了写书稿。写书稿首选当然是 [AsciiDoc](http://www.methods.co.nz/asciidoc/)。

如果有时间的话，我会开发一个 AsciiDoc 到 `docx` 的转换程序。当然，这是一个愿景，要知道，[OOXML 规范](http://www.ecma-international.org/publications/standards/Ecma-376.htm)（ECMA-376）可是超过五千页啊。
