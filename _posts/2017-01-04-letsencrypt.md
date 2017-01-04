---
layout: post
title: "为 Heroku 应用添加 Let's Encrypt SSL 证书"
tags: ['Dev', 'Rails']
---

按：经过一番折腾，终于为一个运行在 Heroku 中的 Rails 应用添加了 Let's Encrypt SSL 证书。做个记录，备查。

我有一个应用运行在 Heroku 中，为了兑现去年的承诺，元旦假期过后便着手为它添加 SSL 证书。首先想到的是 [Let's Encrypt](https://letsencrypt.org/)，毕竟免费。

在 Google 中搜索之后，找到了 [letsencrypt-rails-heroku](https://github.com/pixielabs/letsencrypt-rails-heroku) gem。看介绍，过程很简单，而且能自动重新签发。所以，我选定了它。

### 使用 letsencrypt-rails-heroku gem

首先，把 letsencrypt-rails-heroku gem 添加到 `Gemfile` 中，然后 `bundle install`。按照说明添加 `Letsencrypt::Middleware` 中间件，再配置几个环境变量。最后，把应用部署到 Heroku 中。

至此，一切顺利。但是执行签发证书的命令时遇到了问题：

```sh
$ heroku run rake letsencrypt:renew
Running rake letsencrypt:renew on ⬢ yourapp... ⣷ connecting, run.1234
Creating account key...Done!
Registering with LetsEncrypt...Done!
Setting config vars on Heroku...Done!
Giving config vars time to change...Done!
Testing filename works (to bring up app)...done!
Problem verifying challenge.
Status: pending, Error:
```

执行这个命令很多遍，得到的结果都是一样，而且并没有详细的错误说明。接下来，我换用官方推荐的 [certbot](https://certbot.eff.org/)，试试行不行。

### 使用 certbot

首先，安装 certbot：

```sh
$ brew install certbot
```

然后手动签发：

```
$ sudo certbot certonly --manual
```

根据提示输入电子邮件地址和域名，然后修改控制器，添加一个响应 GET `/.well-known/acme-challenge/:id` URL 的动作，渲染纯文本。详情参见[这篇文章](http://collectiveidea.com/blog/archives/2016/01/12/lets-encrypt-with-a-rails-app-on-heroku)。

但是验证阶段无法通过，提示 DNS A 记录查询失败。

要知道，Heroku 中的应用绑定的是 CNAME 记录。正是这个错误消息误导了我，让我花了很多时间纠缠 CNAME 记录的问题。

随后我又试了 dns 验证（之前是 http 验证），还是不行，提示 DNS 查询超时。

这个工具不行，那就再换一个。我依稀记得有个工具叫 [acme.sh](https://github.com/Neilpang/acme.sh)。

### 使用 acme.sh

按照说明安装好 acme.sh 之后，我用 dns 验证试了一下：

```sh
$ acme.sh --issue --dns -d example.com
```

按照提示设定一条 TXT 记录，等待一会之后（让 DNS 生效），执行：

```sh
$ acme.sh --renew -d example.com
```

还是无法通过验证，日志中给出的消息是“Dns not added”。不过，在日志中，我看到有一个指向 Let's Encrypt API 的 URL。打开一看，正是我的验证详情。

至此，结合 certbot 给出的错误消息，我觉得可能是 DNS 有问题。经过一番搜索，我发现自己并不孤独，有很多人都遇到类似的问题，而且巧的是，部分人用的是 DNSPod，说换了其他 DNS 服务就好了。

### 更换 DNS

死马当活马医。我把域名的 DNS 从 DNSPod 换到了 he.net。等待一夜之后，新的记录仍未生效，导致网站无法访问。随后，我又从 he.net 换到了 NameCheap。不到半小时，记录就生效了。

### 回到 letsencrypt-rails-heroku gem

certbot 和 acme.sh 都是很方便的工具，但是 letsencrypt-rails-heroku gem 跟 Heroku 集成得更好。所以更换 DNS 之后，我首先尝试的，还是它。

```sh
$ heroku run rake letsencrypt:renew
Running rake letsencrypt:renew on ⬢ yourapp... up, run.8151
Creating account key...Done!
Registering with LetsEncrypt...Done!
Performing verification for cs.about.ac:
Setting config vars on Heroku...Done!
Giving config vars time to change...Done!
Testing filename works (to bring up app)...Done!
Giving LetsEncrypt some time to verify...Done!

Adding new certificate...Done!
```

一次成功！

随后，添加[定时任务](https://elements.heroku.com/addons/scheduler)，每隔一段时间重新签发证书。

### 后续配置

证书签发好之后，要按照 Heroku 的说明，把自定义域名指向新的地址：`example.com.herokudns.com`。

还要配置 Rails 应用，在生产环境强制使用 SSL：

```ruby
# config/environments/production.rb

config.force_ssl = true
```

如果使用邮件程序，还要把协议修改成 `https`：

```ruby
# config/environments/production.rb

config.action_mailer.default_url_options = { host: 'example.com', protocol: 'https' }
```
