# Andor Chen

## 用法

如果已经上传到 FTP，后来才使用 git-ftp，要把 `.git-ftp.log` 上传到 FTP：

```
$ cd _site
_site $ git add -A
_site $ git commit -m 'msg'
_site $ git ftp catchup -u <user> -p <passwd> <ftp_url>
```

### 全新部署

1. 安装 git-ftp

```
$ brew install git-ftp
```

2. 安装 gems

```
$ bundle
```

3. 安装 Node 依赖：

```
$ npm install
```

4. 初始化 `_site` 仓库

```
$ bundle exec jekyll build
$ cd _site
_site $ git init
_site $ git add -A
_site $ git commit -m 'init'
```

5. 第一次部署

```
_site $ git ftp init -u <user> -p <passwd> ftp://host.example.com/public_html
```

### 后续部署

上传到 FTP

```
$ rake deploy
```
