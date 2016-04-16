---
layout: post
title: "在 GitHub 中设置 GPG 签名"
tags: ['Git']
---

GitHub 前几天支持 GPG 签名验证提交了（[via](https://github.com/blog/2144-gpg-signature-verification "GPG signature verification")），今天对我的 GitHub 账户做了相应的设置，本文记录过程备考。

### 第 1 步：安装 GPG 命令行工具

使用 Homebrew 安装 GPG 命令行工具 gnupg：

```sh
$ brew install gpg
```

### 第 2 步：生成 GPG 密钥

执行下述命令生成 GPG 密钥：

```sh
$ gpg --gen-key
```

在生成的过程中：

- 询问密钥种类时按回车键，选择默认类型（RSA and RSA）；
- 询问密钥大小时，输入“4096”；
- 询问密钥有效期时按回车键，使用默认值，即永不过期；
- 输入“y”确认上述设置；
- 输入真实姓名和电子邮件地址，“Comment”可留空；
- 输入“O”确认；
- 输入保护私钥的密码；

以上信息设置完毕后，等待程序生成密钥。

### 第 3 步：添加 GPG 公钥

执行下述命令，查看可用的 GPG 密钥：

```sh
$ gpg --list-keys
/Users/userA/.gnupg/pubring.gpg
-------------------------------
pub   4096R/4A667092 2016-04-16
uid                  Your Name <your-name@gmail.com>
sub   4096R/48E027A6 2016-04-16
```

其中，`4A667092` 是 GPG 密钥的 ID。

执行下属命令，输出指定的 GPG 公钥：

```sh
$ gpg --armor --export <GPG-ID>
```

把 `<GPG-ID>` 替换成具体的 ID。在输出的内容中，从“-----BEGIN PGP PUBLIC KEY BLOCK-----”复制到“-----END PGP PUBLIC KEY BLOCK-----”。打开 [GitHub 设置密钥的网页](https://github.com/settings/keys)，粘贴 GPG 密钥。

### 第 4 步：设置 Git

最后要设置 Git，让 Git 使用指定的 GPG 密钥，并让 Git 在提交时使用 GPG 密钥签名。

在 `~/.gitconfig` 文件中添加下述设置（如果集中管理 dotfiles，则在相应的文件中添加）：

```
[user]
  ...
  signingkey = <GPG-ID>
...
[commit]
  gpgsign = true
```

### 第 5 步：签名提交

按照常规的方式提交，Git 会询问私钥的密码，输入即可。

```sh
git commit -m '<commit message>'

You need a passphrase to unlock the secret key for
user: "Your Name <your-name@gmail.com>"
4096-bit RSA key, ID 4A667092, created 2016-04-16

...
```
