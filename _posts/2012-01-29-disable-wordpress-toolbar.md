---
layout: post
title: 禁用 WordPress 的 Toolbar
tags: ['WordPress']
---

WordPress 3.3 之后，用户可以在个人资料页面设置访问前台时是否显式 Toolbar。如果不想把决定权给用户，可以通过一些代码设置前台不显式 Toolbar，具体方法可以参照“[Disable Admin Bar in WordPress 3.3](http://wp.tutsplus.com/tutorials/how-to-disable-the-admin-bar-in-wordpress-3-3/)”一文。但是该文提供的方法有个弊端：虽然 Toolbar “不显式”了，但是它所用到的文件（样式表文件和Javascript 脚本文件）一个都没少，而且还多加了一个样式表。

其实，有个更简单、更有效的方法可以完全去除 Toolbar：使用 `show_admin_bar()` 函数。将以下代码片段加入主题的 `functions.php` 文件：


    // 全局禁用 Toolbar
    show_admin_bar( false );

    // 只在前台禁用 Toolbar
    if ( !is_admin() )
        show_admin_bar( false );

可以根据需要选择禁用全局还是只在前台禁用。

这个方法的好处是，1）代码量少；2）禁用的更彻底，Toolbar 所需的样式表文件和 Javascript 脚本文件均不会加载。
