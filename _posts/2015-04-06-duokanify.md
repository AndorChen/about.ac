---
layout: post
title: "O'Reilly 电子书在多看中没有目录的修正方法"
tags: ['eBook']
---

我平时看电子书，尤其是 ePub 格式的电子书，喜欢使用多看，包括我的 Kindle，也刷成了多看的系统。我看的电子书中相当一部分是 O'Reilly 出版社的。但在多看的系统中，O'Reilly 出版社的电子书都没有目录。如果只有一两本是这种情况，有可能是 O'Reilly 的问题。可是，我接触到的所有O'Reilly 出版社的电子书都是如此，所以我猜想可能是多看系统的问题。

鉴于此，我在其他几个 ePub 阅读器中做了测试，包括 iBooks（Mac 和 iPhone）和 Adobe Digital Editions。在这些阅读器中，O'Reilly 出版社的电子书都能正确显示目录。我还使用 [epubcheck](https://github.com/idpf/epubcheck) 对 O'Reilly 的电子书做了验证，结果是，完全没问题。

今天，我仔细研究了一下，发现在 O'Reilly 的电子书中，[`toc.ncx` 文件](http://www.idpf.org/epub/20/spec/OPF_2.0.1_draft.htm#Section2.4.1)中“缺少”一个 `meta` 元素：[`dtb:depth`](http://www.niso.org/workrooms/daisy/Z39-86-2005.html#li_406)。我把”缺少“放在了引号中，因为没有这个元素，epubcheck 并没有报错，说明 ePub 规范并不强制要求必须有这个元素。而且，虽然没有这个元素，很多其他 ePub 阅读器都能正确解析目录。所以，多看没有显示目录的原因，我想应该是兼容性不够强。

我在 `toc.ncx` 文件中加上了这个 `meta` 元素：`<meta name="dtb:depth" content="1"/>`，然后重新打包，在多个 ePub 阅读器中做了测试，包括多看系统，都能正确显示目录。而且，我也使用 epubcheck 做了验证，没有错误。

如果你也在使用多看系统，阅读O'Reilly 出版社的电子书觉得没有目录不方便，可以按照下述方法修正：

1. 使用解压缩软件解压 ePub 文件（可能要先把 ePub 文件的扩展名改为 `.zip`）;
2. 打开解压得到的文件夹，在文本编辑器中打开 `OEBPS` 子文件夹中的 `toc.ncx` 文件；
3. 在 `head` 元素中加上这个 `meta` 元素：`<meta name="dtb:depth" content="1"/>`；
4. 最后，重新打包整个文件夹。

重新打包时要注意两个问题：

- 一定要先打包 `mimetype` 这个文件；
- 而且，这个文件的压缩率必须为 0%。

如果你觉得每次都手动修正很麻烦，可以使用我写的 Rake 任务，如下所示。

```ruby
require 'fileutils'

# Usage: rake duokanify file=path/to/sample.epub
desc 'Adds dtb:depth to ncx file in an ePub'
task :duokanify do
  unless ENV['file']
    abort("ERROR: Please provide the ePub file path!\nexit")
  end

  unless ENV['file'].end_with?('.epub')
    abort("ERROR: The file you provided is not an ePub!\nexit")
  end

  path = File.expand_path(ENV['file'])

  unless File.exist?(path)
    abort("ERROR: The file you provided is not exists!\nexit")
  end

  puts 'Unzipping....'
  dest_dir = File.basename(path, '.epub')
  system "unzip #{ENV['file']} -d #{dest_dir}"

  puts
  puts 'Normalize....'
  ncx_file = File.join(dest_dir, 'OEBPS', 'toc.ncx')
  unless File.exist?(ncx_file)
    abort("Info: The ePub has no ncx file, needless to normalize.\nexit")
  end
  ncx = File.open(ncx_file, 'r+') do |f|
    content = f.read
    # puts content.inspect
    if content =~ /meta="dtb:depth"/i
      abort("Info: The ePub already set dtb:depth, needless to normalize.\nexit")
    else
      parts = content.split('</head>')
      parts.first << '<meta name="dtb:depth" content="1"/>'
      f.rewind
      f.write parts.join('</head>')
    end
  end

  puts
  puts 'Rezipping....'
  normalized_file = "#{File.basename(dest_dir)}-normalized.epub"
  FileUtils.cd(dest_dir) do
    system "zip -0 -X #{normalized_file} mimetype"
    system "zip -9 -r #{normalized_file} META-INF OEBPS"
  end
  FileUtils.cp File.join(dest_dir, normalized_file), Dir.pwd

  puts
  puts 'Cleanning....'
  FileUtils.rm_rf(dest_dir, :secure => true)

  puts
  puts 'Done'
  puts "Normalized ePub path: ./#{normalized_file}"
end
```

这个 Rake 任务的使用方法是：在命令行中执行 `rake duokanify file=path/to/sample.epub`。执行这个命令后会得到一个名为 `sample-normalized.epub` 的文件，然后再把这个文件上传到多看中即可。

水平有限，我的这个 Rake 任务写得比较蹩脚，如果你觉得有可以改进的地方（有很多），请访问[这个 Gist](https://gist.github.com/AndorChen/8ebfc5821ceac8884416)，给我留言。这个 Rake 任务的最新版会在这个 Gist 中更新。
