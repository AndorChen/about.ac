---
layout: page
title: '购买译者签名版'
class: 'buy-page'
permalink: '/buy/'
---

<div class="alert alert-info">
以下是我翻译的书，特提供译者签名版供您购买。<strong>注</strong>：没有原作者签名。
</div>

<section class="book-list">
  <ul>
  {% for meta in site.data.meta.books %}
    {% for book in site.data.books[meta['slug']] %}
      {% if book.signed_version %}
        {% assign book_url =  book.slug | append: '/' | prepend: '/books/' | prepend: site.baseurl %}
        <li><a href="{{ book_url }}" title="{{ book.title }}"><img src="{{ site.baseurl }}/assets/images/covers/{{ book.image }}" height="164" alt="{{ book.title }}" title="{{ book.title }}" /></a><span class="price">{{ book.price | prepend: '￥' | append: '.00' }}</span></li>
      {% endif %}
    {% endfor %}
  {% endfor %}
  </ul>
</section>

## 签名版定价

签名版的价格与原书的定价一样，不打折。具体价格在每本书的封面下边。所标价格包含快递费用（即**包邮**）。

## 购买方式

把以下信息通过电子邮件发给我。我的 Email：[andor.chen.27@gmail.com](mailto:andor.chen.27@gmail.com?subject=购买签名版 "发邮件购买签名版")。

```
购买的书名：
购买的数量：
支付宝账户：
收件人：
邮寄地址：
联系电话：
```

收到您的邮件之后，我会向您的支付宝账户发起收款请求。收到您的付款后，我会在 24 小时内寄出图书，并把快递单号回复给您。

## 邮寄方式

包邮，默认使用 XX 快递。如果需要指定其他快递，请在您发给我的邮件中注明（可能需要额外支付部分快递费用）。

## 关于签名版

签名版使用的书由出版社提供，绝对正版，绝对原版。而且一般会早于该书 1-2 周到您手上。有些书可能会在扉页上多出一个“样书”印章。

