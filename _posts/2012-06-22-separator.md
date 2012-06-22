---
layout: post
title: Ruby 的路径分隔符
tags: ['Ruby']
---
当我看到 Ruby 的 File 有 `SEPARATOR` 这个常量时，我的第一反应，这个常量是设置文件路径的分隔符的，而且这个分隔符在不同的系统实现上是不同的，比如 Unix 和 Windows 就应该是不同的。

但事实并非如此。在《The Ruby Programming Language》一书 &sect;9.6.1 第一段有这样一句话：“The constant `File::SEPARATOR` should be '/' in all implementations.”（[为什么要这样做](http://rubyforge.org/tracker/index.php?func=detail&aid=13026&group_id=426&atid=1698)）也就是说这个常量在所有的系统中的值是不变的，是 `/`。

为了提供对不同系统的支持，在生成路径时，通常会使用 `File.join` 将路径的各部分连接起来。文档中说该方法会“Returns a new string formed by joining the strings using File::SEPARATOR”。但是通过实验就可以证明这句话是错误的（[via](http://objectmix.com/ruby/185491-wrong-file-separator.html#post655633)）：

    >> File::SEPARATOR = "\\"
    (irb):3: warning: already initialized constant SEPARATOR
    => "\\"
    >> File.join("c:", "My Documents")
    => "c:/My Documents"
    >> File::SEPARATOR
    => "\\"

也就是说不管 `SEPARATOR` 的值是什么，`join()` 是直接使用 `/` 进行连接操作的。基于 `join()` 的这种操作方式，很多人就倾向于 hard code 路径，其实还是使用 `join()` 方法好一些，因为这个方法会做一些额外的工作，比如去除额外的 '/'：

    File.join('/foo/', 'bar') # => /foo/bar 而非 /foo//bar

现在的问题是：`SEPARATOR` 有没有用？答案是，基本没什么用，而且现在看来也没有什么其他的特殊用途（[via](http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-talk/58085)）。

这个常量是没用的，那么还有一个问题需要解决：Windows 或其他平台能够识别 '/' 作为分隔符的路径吗？答案是肯定的，Windows 本身可以识别 '/' 作为路径分隔符，只是在某些特殊的环境中无法识别，比如 DOS 命令行（[via](http://objectmix.com/ruby/185491-wrong-file-separator.html#post655635)）。

Ruby 还提供了另外一个常量 `ALT_SEPARATOR`，这个常量更符合我们的期待，它在 Windows 中的值是 `\`，在其他平台中则是 `nil`。如果确实需要 Windows 风格的路径字符串，可以通过下面的代码实现：

    File.join('path', 'to', 'file').gsub(/\//, '\\')
