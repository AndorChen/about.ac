---
layout: post
title: 'ePub 电子书排版最佳实践'
tags: ['eBook']
---

在制作《[Ruby on Rails 教程](http://railstutorial-china.org)》和《[Jekyll 小书](http://jekyll-china.com/book/)》电子书的过程中，积累了一些经验，班门弄斧，姑且称之为“最佳实践”吧。

## 没有“页”这个概念

这是大前提，制作 ePub 电子书时一定要谨记这一点。ePub 电子书是“流式”的，不像实体书和 PDF 电子书那样有“页”这个概念。因此，很多效果或功能在 ePub 电子书中实现不了，比如说页眉和页码等（ePub 阅读器通常会在屏幕上部实现“页眉”，显示当前查看的书名和章节名；而且也会“分页”，但对阅读器来说，这个页与实体书的页并不一样）。

因为没有页码，书中的交叉引用不能简单地使用“参见 XX 页”，而要链接到章节名或章节序号。

## ePub 文件是小型的静态网站

这也是一个核心概念。你可以把 ePub 电子书的扩展名改为 `.zip`，然后解压。你会看到解压得到的基本上就是个简单的静态网站：有 XHTML 文件，有图像，有样式表。如下所示：

```sh
├── META-INF/
├── OEBPS
│   ├── chapter1.xhtml
│   ├── chapter2.xhtml
│   ├── chapter3.xhtml
│   ├── cover.jpg
│   ├── epub.css
│   ├── images/
│   ├── package.opf
│   └── toc.ncx
└── mimetype
```

当然，这个网站与我们平常所说的网站有所不同，这是由 Web 浏览器与 ePub 阅读器之间的功能差异造成的。例如，在 ePub 电子书中基本不能使用 JavaScript，对 SVG 的支持有限，只能使用部分 CSS 属性。不过，ePub 电子书可以嵌入字体。

## 交叉引用

交叉引用是指引用书内的某个部分，比如“参见 1.2.3 节”，“如图 2.7”，等等。交叉引用最好加上链接，因为电子书不像实体书那样可以来回翻阅，加入链接便于读者定位所引用的内容。

## 提供目录

ePub 阅读器一般都会使用特殊的交互方式显示目录，但不会自己去解析内容，再生成目录。所以我们要在 ePub 文件中加入目录，让阅读器读取。如果内容较多，想显示次级目录，比如“3.2 节”，一定要设定目录的层级，不要把所有目录都放在相同的层级。指定目录层级的方式是，在 `navPoint` 元素中嵌套 `navPoint` 元素，如下所示：

```xml
<navMap>
    <navPoint id="ch1">
        <navLabel>
            <text>第 1 章</text>
        </navLabel>
        <content src="ch1.html#ch_1"/>
        <navPoint class="h2" id="ch_1_1">
            <navLabel>
                <text>1.1 节</text>
            </navLabel>
            <content src="ch1.html#ch_1_1"/>
        </navPoint>
    </navPoint>
    <navPoint id="ch2">
        <navLabel>
            <text>第 2 章</text>
        </navLabel>
        <content src="ch2.html#ch_2"/>
    </navPoint>
</navMap>
```

## 不要把整本书都放在一个 XHTML 文件里

一本书的内容有长有短，但是，不管多长，建议一章放在一个 XHTML 文件里，不要把整本书都放在一个 XHTML 文件里。如果都放在一个文件里，ePub 阅读器解析的速度会变慢。

## 重置默认样式

ePub 阅读器就像 Web 浏览器一样，会内置默认的样式。为了更好的掌控，实现较为统一的视觉效果，建议在样式表开头重置样式。比如说：

```css
html, body, div, span, applet, object, iframe,
h1, h2, h3, h4, h5, h6, p, blockquote, pre, a,
abbr, acronym, address, big, cite, code, del,
dfn, em, font, img, ins, kbd, q, s, samp, small,
strike, strong, sub, sup, tt, var, b, u, i, center,
dl, dt, dd, ol, ul, li, fieldset, form, label, legend,
table, caption, tbody, tfoot, thead, tr, th, td {
  margin: 0;
  padding: 0;
  border: 0;
  outline: 0;
  font-size: 100%;
  vertical-align: baseline;
  background: transparent;
}
```

## 按章“换页”

ePub 电子书虽然没有“页”这个概念，却可以换页（严格来说应该是“换屏”）。从视觉上来看，换页就是新起一屏显示内容，让相对独立的内容（例如两章）不连在一起。一般来说，建议每章结束后换页，使用下述 CSS 代码实现：

```css
div.chapter {
    page-break-after: always;
}
```

## 字体

ePub 阅读器底层的操作系统（例如 iOS，Android 和各种定制的 ROM）往往会提供不同的字体，因此不能期望读者的系统中一定有某个字体。设置字体时要指定通用字体族（`serif`，`sans-serif` 或 `monospace`），让阅读器或底层系统判断要使用哪个字体。当然，我们也可以指定各种系统中常用的字体，提供更好的阅读体验。

如果十分想保持一致的阅读体验，还可以使用 `@font-face` 嵌入字体。但是要考虑嵌入的字体会不会让电子书的体积变得特别大，影响传输速度。

如果指定了字体，而不是让阅读器自行判断该使用哪个字体，在 iBooks 中会遇到一个问题：没使用指定的字体。这个问题的解决方法是，在 `.opf` 文件中加入下述元素：

```xml
<meta property="ibooks:specified-fonts">true</meta>
```

添加这个属性后，你会发现，在 iBooks 的外观设置中，字体项目下多了一个“Original”。这个选项的意思是，使用电子书中指定的字体。

![让 iBooks 使用指定的字体]({% figure_url ibooks-fonts.png %})

## 字号

我想你一定有这样的经历——调整电子书的文字大小。这种情况经常出现，因此，不要使用固定字号，例如 `12px`，而要使用便于缩放的字号单位。ePub 电子书的字号一般建议使用百分比为单位，比如 `80%`。

## 为标题加序号

书中的各级标题往往使用不同于正文的字体和字号显示，但是在手持设备中，字号之间的差异并不明显。为了让读者对一本书的纲要有全局的认识，建议在标题前加上序号，例如：“1.2 二级标题”，“1.2.3 三级标题”。

## 考虑兼容性

是的，与浏览器一样，我们也要考虑 ePub 阅读器的兼容性。就我目前的观察，iBooks 对标准的支持是最好的。但我们不能期望所有读者都使用 iOS/OS X 系统。下面举个例子。

我平常看书喜欢用多看（手机和平板），但是[多看对 XHTML 实体的支持并不好]({{ site.baseurl }}{% post_url 2014-06-22-duokan-xhtml-entities %})，有些特殊的符号显示不出来。这时就要专门针对多看编写样式：

```css
.symbol {
    font-family: 'DK-SYMBOL';
}
```

`DK-SYMBOL` 是多看自带的字体，用于显示一些特殊的字体。

## 其他

除了上面列出的几点之外，还有一些推荐的做法，在此不一一展开详述。

- 不要定义大块背景色；
- 脚注加上返回链接；
- 尽量不使用某个阅读器专属的功能；
