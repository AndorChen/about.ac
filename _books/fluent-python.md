---
layout: book
book_category: python
---

注：本书是我与另一位译者合译的，第 4 章之后的内容由我翻译。

## 关于本书

本书致力于帮助 Python 开发人员挖掘这门语言及相关程序库的优秀特性，避免重复劳动，同时写出简洁、流畅、易读、易维护的代码。特别是深入探讨了针对数据库处理时生成器的具体应用、特性描述符（ORM 的关键），以及 Python 式的对象：协议与接口、抽象基类及多重继承。

## 作者简介

Luciano Ramalho 是 Python 软件基金会成员，拥有 15 年的 Pyhton 编程经验。他从 1995 开始进入软件行业，先后使用过 Perl、Java 和 Python。他使用 Python 为很多大型新闻门户网站编写程序，并在巴西举办 Python 开发培训，学员遍及媒体、银行和政府部门。他经常在 Python 大会上演讲，比如，PyCon US (2013)、OSCON (2002, 2013)。他拥有自己的培训公司 Oficinas Turing。

## 内容目录

-   [前言](http://www.ituring.com.cn/book/tupubarticle/13727)  
-   第一部分　序幕
    - [第 1 章　Python 数据模型](http://www.ituring.com.cn/book/tupubarticle/13729)
-   第二部分　数据结构   
    - [第 2 章　序列构成的数组](http://www.ituring.com.cn/book/tupubarticle/13731)
    - 第 3 章　字典和集合
    - 第 4 章　文本和字节序列   
-   第三部分　把函数视作对象    
    - 第 5 章　一等函数  
    - 第 6 章　使用一等函数实现设计模式  
    - 第 7 章　函数装饰器和闭包  
-   第四部分　面向对象惯用法    
    - 第 8 章　对象引用、可变性和垃圾回收 
    - 第 9 章　符合 Python 风格的对象   
    - 第 10 章　序列的修改、散列和切片  
    - 第 11 章　接口：从协议到抽象基类  
    - 第 12 章　继承的优缺点   
    - 第 13 章　正确重载运算符 
-   第五部分　控制流程   
    - 第 14 章　可迭代的对象、迭代器和生成器   
    - 第 15 章　上下文管理器和 else 块   
    - 第 16 章　协程   
    - 第 17 章　使用期物处理并发 
    - 第 18 章　使用 asyncio 包处理并发 
-   第六部分　元编程    
    - 第 19 章　动态属性和特性  
    - 第 20 章　属性描述符    
    - 第 21 章　类元编程 
- 结语  
- 附录 A　辅助脚本   
- Python 术语表  


## 勘误

如果您在阅读本书过程中发现了错误，[欢迎指正](http://www.ituring.com.cn/book/1564 "提交勘误")。

## 大事记

- 2015.12.03 开始翻译
- 2016.09.02 初译完毕
- 2017.04.28 电子书发布

## 词汇表

书中有大量术语，翻译过程中主要参照“[全国科学技术名词审定委员会](http://www.term.gov.cn/)”审定的词汇表，也参阅了已出版的相关书籍。

| 英文 | 中文 | 备注 |
|------|-----|-----|
| accessor | 存取方法 | |
| alternate constructor | 备选构造方法 | |
| arithmetic progression | 等差数列 | |
| augmented assignment operator | 增量赋值运算符 | |
| BOM | = Byte Order Mark，字节序标记 | |
| bound method | 绑定方法 | |
| bug tracker | 缺陷追踪系统 | |
| Byte Order Mark | 字节序标记，简称 BOM | |
| call by sharing | 共享传参 | |
| call by value | 按值传参 | |
| canonical equivalent | 标准等价物 | |
| case folding | 大小写折叠 | |
| codec | 编码解码器 | |
| combinatoric generator | 组合学生成器 | |
| context manager | 上下文管理器 | |
| cooperative multitasking | 协作式多任务 | |
| coroutine | 协程 | |
| CPU-bound | CPU 密集（型） | |
| decorator | 装饰器 | |
| deep copy | 深拷贝 | |
| deleter | 删值方法 | |
| descriptor class | 描述符类 | |
| destruction | 析构 | |
| destructuring assignment | 解构赋值 | |
| dict comprehension | 字典推导 | |
| Discrete Event Simulation | 离散事件仿真 | |
| dot product | 点积 | |
| eager evaluation | 及早求值 | |
| elementwise multiplication | 元素级乘法 | |
| embarrassingly parallel | 高度并行 | |
| enforced descriptor | 强制描述符 | |
| explode | 展开（数组） | |
| fail-fast | 尽早失败 | |
| flat sequence | 平坦序列 | |
| flyweights | 享元 | |
| free variable | 自由变量 | |
| futue | 期物 | 自造 |
| generator | 生成器 | |
| generic function | 泛型函数 | |
| getter | 读值方法 | |
| Global Interpreter Lock | 全局解释器锁，简称 GIL | |
| goose typing | 白鹅类型 | |
| green thread | 绿色线程 | |
| hackerspace | 众创空间 | |
| hardware interrupt | 硬件中断 | |
| hashable | 可哈希的（对象） | |
| I/O-bound | I/O 密集（型） | |
| infix operator | 中缀运算符 | |
| interning | （字符串）驻留 | |
| iterable unpacking | 可迭代对象的拆包 | |
| iterable | 可迭代的对象 | |
| iterator | 迭代器 | |
| Jargon file | 新黑客字典 | |
| lazy evaluation | 惰性求值 | |
| list comprehension | 列表推导 | |
| loop over | 遍历 | |
| managed attribute | 托管属性 | |
| managed class | 托管类 | |
| managed instance | 托管实例 | |
| Memory View | 内存视图 | | 
| multi-agent system | 多智能体系统 | |
| multimethod | 多分派方法 | |
| mutator | 变值方法 | |
| name mangling | 名称改写 | |
| ordered pair | 有序对 | |
| overriding descriptor | 覆盖型描述符 | |
| parallel assignment | 并行赋值 | |
| preemptive multitasking | 抢占式多任务 | |
| prime | 预激（协程） | |
| property | 特性 | |
| Read-Eval-Print Loop | 读取-求值-输出循环，简称 REPL | |
| reference variable | 引用式变量 | |
| referent | 所指对象 | |
| scalar product | 标量积 | |
| sentinel | 哨符 | |
| set comprehension | 集合推导 | |
| setter | 设值方法 | |
| shadowable descriptor | 遮盖型描述符 | |
| simulation clock | 仿真钟 | |
| storage attribute | 储存属性 | |
| strong reference | 强引用 | |
| subroutine | 子程序 | |
| syntactic macro | 句法宏 | |
| syntactic sugar | 语法糖 | |
| tail-call | 尾调用 | |
| tail-recursion elimination | 尾递归消除 | |
| tuple unpacking | 元组拆包 | |
| Uniform access principle | 统一访问原则 | |
| virtual subclass | 虚拟子类 | |
| weak reference | 弱引用 | |
| word size | 字长 | |
| yield | 产出 | |
{:class="table table-bordered"}
