---
layout: post
title: docx 文件脚注的编号
tags: ['Dev']
---

最近，使用 [pandoc](http://pandoc.org/) 生成 docx 文件遇到一个问题。默认情况下，一个文档中的所有脚注是按顺序标号的。这其实没什么问题，因为“语义”上讲，这就是正确的编号方法。但是，我想实现的是“按章”编号。

我之前已经从样式上区别了各章（方法参见《[docx 文件定制指南]({{ site.baseurl }}{% post_url 2015-06-01-docx-hack-guide %})》），即在一级标题之前换页。这只是“表面功夫”，Word 看到的仍是一个没有结构划分的文档。为了实现脚注按章编号，首先要想办法让 Word 知道每一章在哪里开始，在哪里结束，也就是从“语义”上实现分章。

其实 Word 提供了这种功能——分节。不过在代码层级，实现起来有点复杂。根据 WordProcessingML 的定义，文档最后一节的相关属性在 `w:body` 元素中最后一个 `w:sectPr` 元素中定义，而之前每一节的相关属性都在各节最后一个段落（`w:p`）的属性中定义，如下述代码所示：

```xml
<w:body>
    <!--第一节-->
    <w:p>...</w:p>
    <w:p>...</w:p>
    <w:p>
        <w:pPr>
            <w:sectPr>...</w:sectPr>
        </w:pPr>
        ...
    </w:p>

    <!--第二节-->
    <w:p>...</w:p>
    <w:p>...</w:p>
    <w:p>
        <w:pPr>
            <w:sectPr>...</w:sectPr>
        </w:pPr>
        ...
    </w:p>

    <!--最后一节-->
    <w:p>...</w:p>
    <w:p>...</w:p>
    <w:p>...</w:p>
    <w:sectPr>
        ...
    </w:sectPr>
</w:body>
```

pandoc 所用的模板没有为最后一节指定任何属性，即只有 `<w:sectPr/>`。所以，要想办法设置最后一节的属性，还要在每个一级标题之前的段落属性里插入 `<w:sectPr>` 元素。这个好办，使用相关的 XML 处理库就行。如果使用 Ruby，可以用 [nokogiri](https://rubygems.org/gems/nokogiri)。XML 的具体处理方法本文不再赘述。

不过，要如何设置每一节的属性才能让脚注按章编号呢？按照 WordProcessingML 的定义，脚注的属性放在 `w:footnotePr` 元素中，控制编号方式的是 `w:numRestart` 元素。这个元素的值可以设为下述三个值中的一个：

- `continuous`（默认值）
- `eachSect`
- `eachPage`

从上可以看出，我们需要把这个元素的值设为 `eachSect`，即开始新的一节时重新从头开始为脚注编号。最终设置的 `w:sectPr` 如下：

```xml
<w:sectPr>
    <w:footnotePr>
        <w:numRestart w:val="eachSect"/>
    </w:footnotePr>
</w:sectPr>
```

如果想每页单独编号，可以把 `w:numRestart` 的值设为 `eachPage`。
