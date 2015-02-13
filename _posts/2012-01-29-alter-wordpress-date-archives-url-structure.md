---
layout: post
title: 修改基于日期的归档页面的 URL 结构
tags: ['WordPress']
---

WordPress 的链接格式是很灵活的，几乎可以任意的定制 URL 的格式。如果你所用的服务器支持 mod_rewrite 的话就可以设置“精美”的 URL 格式。WordPress 默认提供了 5 种 URL 格式供选择，而且还可以自由定制。WordPress 还提供了针对“分类”和“标签”的 rewrite base 设置选项。

默认的，WordPress 的分类 URL 格式是 `host/category/xxx/`，其中 `category` 就是 rewrite base，这是可定制的部分，例如本站分类 URL 的 rewrite base 就设置为“go”了。同理，可以设置标签 URL 的 rewrite base。

在设置 WordPress 链接格式的时候我遇到一个问题。我设置的 URL 格式是 `/t/%postname%`，rewrite base 是固定的，不再是占位符，这时文章页面的 URL 是没问题的，页面的 URL 是没问题的，分类、标签的页面 URL 也是没问题的，但是，基于时间的页面就出现问题了，其 URL 结构变成 `/t/2012/01` 的格式，这个“t”是我不需要的。

查看 `wp-includes/rewrite.php` 第 862 行 `get_date_permastruct()` 函数的定义可以发现，最终返回的结果加入了 `$front`，这就是“t”为什么会出现的原因。

    ....
    $this->date_structure = $front . $date_endian;
    ....

那么只需要覆盖类 `WP_Rewrite` 的 `$date_structure` 变量即可。将以下代码片段写入主题的 `functions.php`：

    function ac_re_rewrite() {
        global $wp_rewrite;

        // Not need the $wp_rewrite->front
        $wp_rewrite->date_structure = '%year%/%monthnum%/%day%';

        $wp_rewrite->flush_rules();
    }
    add_action( 'init', 'ac_re_rewrite' );

如此一来，基于日期的存档 URL 格式就定制好了，利用同样的方法还可以定制作者归档等页面的 URL 格式。
