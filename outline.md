# Haskell与函数式编程

函数式编程是一种历史悠久，并在近几年又重新焕发生机的编程范式。

而Haskell则是一门纯函数式编程语言，它强迫你用函数式的方式思考，来写你的程序，这虽然在平常工作中并非良策[^1]，但在学习过程中，这样“逼”一下，你会学得更快。

## 什么是函数式编程范式，它和其他的编程范式有什么不同

> **函数式编程**（英语：**functional programming**）或称**函数程序设计**，又称**泛函编程**，是一种[编程典范](https://zh.wikipedia.org/wiki/%E7%B7%A8%E7%A8%8B%E5%85%B8%E7%AF%84)，它将计算机运算视为[数学](https://zh.wikipedia.org/wiki/%E6%95%B8%E5%AD%B8)上的[函数](https://zh.wikipedia.org/wiki/%E5%87%BD%E6%95%B0_(%E6%95%B0%E5%AD%A6))计算，并且避免使用[程序状态](https://zh.wikipedia.org/w/index.php?title=%E7%A8%8B%E5%BA%8F%E7%8A%B6%E6%80%81&action=edit&redlink=1)以及[易变对象](https://zh.wikipedia.org/wiki/%E4%B8%8D%E5%8F%AF%E8%AE%8A%E7%89%A9%E4%BB%B6)。函数编程语言最重要的基础是[λ演算](https://zh.wikipedia.org/wiki/%CE%9B%E6%BC%94%E7%AE%97)（lambda calculus）。而且λ演算的函数可以接受函数当作输入（引数）和输出（传出值）。
>
> ——Wikipedia

维基上的定义里有一堆神仙玩意，我们换一种方式来看这个问题。

平常我们用的编程范式主要有面向过程编程和面向对象编程等等。

面向过程的编程思想是这样的：

![PP](outline/PP.svg)

面向对象的编程思想是这样的：

![OOP](outline/OOP.svg)

而函数式编程是这样的：

![FP](outline/FP.svg)

函数式编程将程序看作是一系列函数的组合，只要向函数参数中填入数据，最终函数的返回值就是程序的输出。

函数式编程和面向对象编程的差异很容易看出来，他们一个关注的点是“对象”，即(数据,对数据进行的操作)这样的一个包，而函数式编程关注的点是如何将输入的数据通过一些函数运算转变为输出。

那么，同样都有函数的函数式编程和面向过程编程到底有什么不同呢？

主要的不同在于（纯粹的）函数式编程：

1. 没有变量，一切量都是不变的
   - 因此也没有循环了
   - 也没有传统意义上的逻辑判断
   - 因此函数都是“纯函数”，因为没有变量，所以也几乎不可能有副作用[^2]
2. 函数是”一等公民”，每个函数都是一个变量，有其类型，能作为其他函数的参数[^3]

没错，没变量，没循环，似乎这样写不了程序了，然而，接下来对Haskell语言的学习将会告诉你，这只是一种错觉。

## Haskell基本语法

### Why Haskell?

Haskell除了是一门纯函数式编程语言外，还有如下特点

1. 惰性求值，所有的值不被用到就不会被计算
2. 静态强类型，并有着我所见过最好的类型系统

### Why not lisp?[^4]

1. Lisp不纯，至少现在它的大部分方言不纯
2. 方言太多，宏语法太过灵活
3. 括号太多

### 环境配置

从[官网](https://www.haskell.org/downloads#minimal)上下载安装即可。

我们只会用到Haskell的核心部分。故下载minimal即可。

怎么判断安装好了呢？自然是Hello world程序了。

打开ghci，输入`"hello world"`，同样返回`"hello world"`即可。

我们所有的代码实验都会在ghci环境中进行。

### 基本数据类型

Haskell中的数据类型和C中的大致相同，整数字符浮点数应有尽有。

此外，Haskell中比较厉害的一个类型是列表类型，下面会说。

### 调用函数

Haskell调用函数的方式和C语言不太一样：

```haskell
-- 假设有函数f
f x -- 这就是计算f(x)了
g x y -- g(x,y)
```

Haskell省去了括号和逗号，这虽然让人不太适应，但也部分避免了像Lisp那样一屏幕的括号的尴尬。

### 运算符

`+`、`-`、`*`、`/`、`&&`、`||`、`==`都和C语言一样。

特别的，取非要用`not`（实际上这是个函数，在Haskell中这些运算符本质都是函数），C中的不等于符号`!=`，在这里是`/=`。

求余要用`mod`函数：

```
mod 3 2
```

如果你想要像C语言中的`%`那样中缀调用`mod`的话，你可以使用`` `将函数包裹：

```
3 `mod` 2
```

#### 列表

Haskell的列表是一个非常强大的玩意，我们可以用和Python等语言中制作列表相似的方法做一个Haskell列表：

```haskell
[1,2,3,4,5,6]
```

Haskell列表可以被拼接：

```haskell
[1,2]++[3,4]++[5,6]
-- [1,2,3,4,5,6]
```

也可以拼一个元素上去：

```haskell
1:[1,2,3]
-- [1,1,2,3]
-- 注意只能拼在前面
-- [1,2,3]:1 会报错的
-- 因为这真的是个list，单向链表
```

可以各种取元素：

```haskell
take 3 [1,2,3,4,5,6,7]
-- 取前三个，[1,2,3]
drop 3 [1,2,3,4,5,6,7]
-- 取前三个之外的元素，[4,5,6,7]
head [1,2,3,4,5,6,7]
-- 取第一个，1
tail [1,2,3,4,5,6,7]
-- 取除第一个之外的元素，[2,3,4,5,6,7]
init [1,2,3,4,5,6,7]
-- 取最后一个之外的元素，[1,2,3,4,5,6]
last [1,2,3,4,5,6,7]
-- 最后一个，7
1 `elem` [1,2,3]
elem 1 [1,2,3]
-- 判断元素是否在列表中，两句等价，都为True
[1,2,3,4] !! 2
-- 取列表的第二个元素，3
-- 用!!有点奇怪不是吗😓
```

另外构造列表还有很多特别的姿势：

```haskell
-- 使用区间
[1..5]
-- [1,2,3,4,5]
-- 一般的等差数列都能推出来
[1,3..42]
-- [1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,39,41]
-- 使用列表推导式
[x*2 | x <- [1..10], x*2 >= 12]
-- 意为：对于在[1..10]之中的x，若有x*2 >= 12，则将x*2放入列表
```

由于Haskell的惰性求值特性，你可以构造一个无穷的列表：

```haskell
[1..]
-- 从1开始，到无穷大为止
```

运用这个特点我们能做一些很酷的事情，比如求前10个7的倍数或末尾含7的数：

```haskell
take 10 [x | x <- [1..], x `mod` 7 == 0 || x `mod` 10 == 7]
```

就只有一行代码，简单方便，可读性好。

你拿命令式语言写，估计得絮絮叨叨写一大坨了吧。

例如用C语言，最简洁的写法：

```C
for(unsigned x=1, count=0; count < 10; ++x) {
	if(x % 7 == 0 || x % 10 == 7) {
		printf("%u\n",x);
		++count;
	}
}
```

显然代码比较多，而且可读性也一般（有两个变量，你得分析它们分别是做什么的）。

顺便提一句，Haskell中所谓的字符串还是字符列表的一个语法糖，很像C语言中的字符串是字符数组的语法糖那样。

讲完了能放进函数里面的数据，我们再来看看函数。

### 自己写函数

Haskell的函数语法非常直白，很像数学中的函数：

```haskell
triple x = 3 * x
```

就定义好了一个函数`triple`，它的作用就是返回输入参数的三倍。

很像数学里的函数的写法：
$$
triple(x) = 3*x
$$
多个参数：

```haskell
length x y = sqrt (x * x + y * y)
```

也很像数学中的函数：
$$
length(x,y) = sqrt(x*x+y*y)
$$
如果函数要分类讨论，可以使用“模式匹配”等技巧，它们在函数式编程中替代了逻辑判断：

```haskell
-- 当参数恰好匹配的时候会返回对应的值
description "ccg" = "tql"
description "zd" = "More Money Than God"
description "lfs" = "vegetable exploded"
-- 都没有匹配到，会进入这个默认的匹配
description x = "temporary no information"
```

记得匹配的顺序是从上到下，因此如果参数为x的匹配放到第一个那么就会GG。

（说起来有点像匹配URL啊……）

如果要匹配的是一个范围，那么应当使用“哨卫”语法：

```haskell
f x
 | x <= 10 = x
 | x <= 20 = x/2
 | x <= 30 = x*x
 | otherwise = x*x*x
```

就像是：
$$
f(x) =
\begin{equation}
\begin{cases}
x & x\le10\\
x/2 & 10 < x \le 20\\
x*x & 20 < x \le 30 \\
x*x*x & otherwise
\end{cases}
\end{equation}
$$
如果在列表上进行模式匹配，可以这样写：

```haskell
listFunction [] = "Empty!"
listFunction (x:[]) = "Only One!"
listFunction (x:y:[]) = "There are two!"
-- 这里要提一下，show函数返回输入值的字符串表示
listFunction (x:y:_) = "More than 2! First two are " ++ show x ++ " and " ++ show y
```

#### 递归

> 想要理解递归，你要先理解递归。

有了上面那一堆东西，大部分命令式语言能实现的东西就能被实现了，但是我们还没讲到一样重要的东西：递归。

我们来考察“最大值”函数，它应该接受一个列表，返回列表中的最大值。

在命令式编程中，我们会使用一个循环来实现这一点。

然而我们没有循环了，该怎么办？

用递归啊。

我们可以这样想，如果一个列表里只有一个元素，那么这个元素就是最大的：

```haskell
maxInList [x] = x
```

否则，就应该是这个列表第一个值和其余部分中的最大值中比较大的那个

```haskell
maxInList (x:xs) = max x (maxInList xs)
```

于是就这么愉快地写好了，这个函数只有两行，如果使用命令式语言，恐怕很难用两行完成（当然你要是硬要用C语言然后把代码都挤在一行上我也没话说）。

为了进一步展示函数式编程的美，我们来看看函数式的快速排序：

```haskell
quicksort [] = []
quicksort (x:xs) = (quicksort [y | y <- xs, y < x]) ++ [x] ++ (quicksort [y | y <- xs, y >= x])
```

比对一下我们数据结构书中丑陋的实现：

```c++
template <class ElemType>
void QuickSort(ElemType elem[], int low, int high, int n)
{
    ElemType e = elem[low];				// 取枢轴元素 
    int i = low, j = high;
	while (i < j)	{
		while (i < j && elem[j] >= e)	// 使j右边的元素不小于枢轴元素
			j--;
		if (i < j)
            elem[i++] = elem[j];

		while (i < j && elem[i] <= e)	// 使i左边的元素不大于枢轴元素
			i++;
		if (i < j)
            elem[j--] = elem[i];
	}
	elem[i] = e;
    if (low < i-1)	QuickSort(elem, low, i - 1, n);		// 对子表elem[low, i - 1]递归排序
	if (i + 1 < high) QuickSort(elem, i + 1, high, n);	// 对子表elem[i + 1, high]递归排序
}
```

Oh……这都是什么玩意[^5]。

这里要题一句，递归常常被认为相比循环是很慢的，这确实有道理，但是也不能一概而论，因为Haskell已经在这个方面做了大量优化（尾递归等等）。

### curry化函数与Hindley-Milner类型签名

我们前面说过Haskell中的函数可以带多个参数：

```haskell
length x y = sqrt (x * x + y * y)
```

但是我实际上，我要说，所有的Haskell函数都只接受一个参数，返回一个值。

那上面那个玩意是怎么弄出来的呢？

我们先看看这个函数的类型：（在GHCI中使用`:t length`）

```haskell
length :: Floating a => a -> a -> a
```

WTF？这是啥神仙玩意？

实际上这是一个叫Hindley-Milner类型签名的东西，Haskell主要使用这种东西来标记一个函数的类型。

这个东西这样读：

Length is a fuction which takes an argument of type "a" and returns a fuction which (

takes an argument of type "a" and returns a value of type "a" 

) where "a" is a type of typeclass Floating

用中文：

Length函数接受一个"a"类型的值作为参数，返回一个（接受一个"a"类型值作为参数，返回一个"a"类型值的函数），其中"a"是Floating类型类下的类型。

如果你还是觉得有点晕的话，我们给上面的类型打上括号：

```haskell
length :: Floating a => (a -> (a -> (a)))
```

可以理解为，这里一共有两个函数，一个是`length`本身，它接受一个"a"类型参数，返回一个类型为

```haskell
Floating a => a -> a
```

的函数。

这个新的函数接受一个"a"类型参数，返回一个"a"类型的值。

所以一个Haskell函数只接受一个参数，然后要么返回一个函数，负责“吃掉”剩下的参数，要么返回一个值，就是函数运行的结果。

不过后面为了方便，我还是会说某某函数“接受两个参数”，不过你们心里要清楚就是了。

那么这样有什么好处呢？

一个好处是容易创建偏函数：

```haskell
length x y = sqrt (x * x + y * y)
f = length 2
f 3 -- 即length 2 3
f 4 -- 即length 2 4
(*3) -- 返回参数乘3的结果的函数，下面将高阶函数里会用到
(<10) -- 判断参数是否<10的函数
```

### 高阶函数

我们曾经说过，在函数式编程中我们可以将函数也作为参数传递，这就能玩出很多花样来了，比如现在在程序员中已经耳熟能详的`map`-`reduce`-`filter`：

```haskell
-- map :: (a -> b) -> [a] -> [b]
-- 即对一个列表中的每个元素应用一个函数，返回结果列表
map (*3) [1,2,3,4,5] -- [3,6,9,12,15]
-- filter :: (a -> Bool) -> [a] -> [a]
-- 即从列表中选择出符合条件的函数
filter (<10) (map (*3) [1,2,3,4,5]) -- [3,6,9]
```

Haskell中的`reduce`叫`foldl`：

```haskell
foldl (\acc x -> acc + x) 0 (filter (<10) (map (*3) [1,2,3,4,5])) -- 18
```

其中的：

```haskell
(\acc x -> acc + x)
```

这个叫lambda表达式，很多别的语言里也有，他的用途就是定义一个匿名的函数，它接受两个参数`acc`和`x`，返回他们的和。

不过聪明的你一定可以发现，这个函数其实就是`+`运算符，所以你也可以写成这样：

```haskell
foldl (+) 0 (filter (<10) (map (*3) [1,2,3,4,5]))
```

当然除了`map`-`reduce`-`filter`之外，还有很多其他的高阶函数，比如`zip`等等，也在日常使用其他语言的编程中有一些应用，如果你觉得用的到的话可以自己去查一查资料。

### typeclass

看到`typeclass`不要想到面向对象中的`class`，相比之下，`typeclass`更像`interface`，也就是表达“一种类型的能力”（`interface`大概是这个意思）而非“一个对象的能力”（`class`大概是这个意思）。

说的简单一些，`typeclass`就要求一个类型能被放在某个函数的参数里做运算。

有以下一些常见的`typeclass`：

- Eq类型类

  可判断相等性的类型，要求类型实现了`==`和`/=`两个函数[^4]。

- Ord类型类

  可比较大小的类型，要求类型实现了`compare`。

- Show类型类

  可以转成字符串，也就可以被显示出来的类型，实现`show`。

- Read类型类

  可以从字符转出来的类型，实现`read`。

- Enum类型类

  可以求其前驱和后继的类型，实现`pred`和`succ`。

- Bounded类型类

  有界的类型，实现`minBound`和`maxBound`。

- Num类型类

  表示数值的类型类，基本上就是`Int`、`Integer`、`Float`、`Double`。

- Floating类型类

  表示浮点数的类型类，基本上就是`Float`和`Double`。

- Integeral类型类

  表示整数的类型类，基本上就是`Int`（会溢出的整数）和`Integer`（大整数）。

这些就是一些基本的类型类。

当然你可以自己做一些类型，并让它们实现某个类型类，但这部分绝非Haskell最令人感到舒适的部分，毕竟这是传统面向对象语言的专长（而我的思维方式不幸地已经适应了这种写法）。

不过在此还是留下例子：

```haskell
data TrafficLight = Red | Yellow | Green

instance Eq TrafficLight where
　　 Red == Red = True
　　 Green == Green = True
　　 Yellow == Yellow = True
　　 _ == _ = False
```

### 函子

> 设*C*和*D*为范畴，从*C*至*D*的**函子**为一映射![F](https://wikimedia.org/api/rest_v1/media/math/render/svg/545fd099af8541605f7ee55f08225526be88ce57):
>
> - 将每个对象![X \in C](https://wikimedia.org/api/rest_v1/media/math/render/svg/cbbba9385d2769d1b712aace22eb12b7b027532f)映射至一对象![F(X) \in D](https://wikimedia.org/api/rest_v1/media/math/render/svg/7133b230eb2fabfe9212374d671ba25a9587a4b1)上，
> - 将每个态射![f:X\rightarrow Y \in C](https://wikimedia.org/api/rest_v1/media/math/render/svg/2df18d6f5a51aa7cf12ba70209987ee2f6d1c10c)映射至一态射![F(f):F(X) \rightarrow F(Y) \in D](https://wikimedia.org/api/rest_v1/media/math/render/svg/3a6564d3053f8f71b0af20bada84eb2710cb6942)上，使之满足下列条件：
> - 对任何对象![X \in \mathcal{C}](https://wikimedia.org/api/rest_v1/media/math/render/svg/ff0f1e44334d39c0ba83ae6d79d31cede4491cc8)，恒有![{\displaystyle F(\mathbf {id} _{X})=\mathbf {id} _{F(X)}}](https://wikimedia.org/api/rest_v1/media/math/render/svg/7011a0191d55c97595b9ee935c79625f6bc46e92)。
> - 对任何态射![f: X \to Y, \; g: Y \to Z](https://wikimedia.org/api/rest_v1/media/math/render/svg/adc8502944942868160be8aa386e13ee47fc919f)，恒有![F(g \circ f) = F(g) \circ F(f)](https://wikimedia.org/api/rest_v1/media/math/render/svg/5386b2f5cd99fb03896b82b2a5efeec6ca0edb30)。换言之，函子会保持单位态射与态射的复合。
>
> 一个由一范畴映射至其自身的函子称之为“自函子”。

上面这坨都是啥神仙玩意。

~~数学家就喜欢把其实很简单事情搞得看上去超级复杂，美其名曰“严密”，以凸显其远超常人的智商，实际上我们都知道……好吧他们是真的很聪明TAT。~~

我用一句话说清楚：

函子（Functor）就是可以被map-over（即通过map向对象中的子对象应用一个函数）的对象[^6]。

或者，一码胜千言：

```haskell
class Functor f where
　　fmap :: (a -> b) -> f a -> f b
```

啊，`Functor`是一个类型类，它要求实现了它的类型实现`fmap`函数，它取一个`(a -> b)`和一个`f a`（即f类型里面的a类型）值作为参数，返回一个`f b`的值。

比如列表就是一个`Functor`：

```haskell
map :: (a -> b) -> [a] -> [b]

instance Functor [] where
　　fmap = map
```

另外，Haskell中的`Set`和`Maybe`（可空值）也是`Functor`。

`Maybe`是个好东西，下面就用它讲解了：

```haskell
instance Functor Maybe where
    fmap func (Just x) = Just (func x)  -- 有东西写作 Just xxx, map上去就是Just f(xxx)
    fmap func Nothing  = Nothing		-- 没东西写作 Nothing, map上去还是Nothing
```

总的来说，`Functor`就是表现的像是容器或者上下文的一个类型，你可以通过`fmap`向容器中的元素应用一个操作这样。

### Applicative

`Applicative`是`Functor`的升级版本（也称`Applicative Functor`），这是个啥呢？

我们已经知道了我们可以将一个函数`map`到一个`Functor`上，但是如果我们要应用的函数[^7]也在上下文中呢？

例如`Just (+3)`这种？

在已经能完成`Functor`所有功能的基础上，`Applicative`也会帮我们解开函数的上下文，然后应用：

```haskell
class Functor f => Applicative f where  -- Applicative一定是Fuctor
    pure :: a -> f a					-- 返回一个包裹在上下文中的值
    (<*>) :: f (a -> b) -> f a -> f b   -- 应用上下文中的函数
```

例如`Maybe`：

```haskell
instance Applicative Maybe where
    pure = Just
    Nothing <*> _ = Nothing				-- 应用 Nothing 得 Nothing
    (Just func) <*> something = fmap func something
```

### Monad (Ah! Finally!)

> Monad有啥难的，不过是自函子范畴上的一个幺半群罢了。

~~这么说的都给我拖出去毙了。就你懂群论代数系统范畴论。😠~~

~~抱歉毙不掉，第一个说这句话的是Haskell委员会成员。~~

`Monad`是`Applicative`的升级版本，它在`Applicative`的基础上，添加了一个“接受一个上下文中的值和一个(接受普通值返回上下文中的值的函数)，返回一个上下文中的值”的功能。

（简化过的）Monad是这样的：

```haskell
class Applicative m => Monad m where    
	return :: a -> m a     
	(>>=) :: m a -> (a -> m b) -> m b
```

同样看`Maybe`：

```haskell
class Applicative Maybe => Monad Maybe where
    return :: a -> Maybe a
    (>>=) :: Maybe a -> (a -> Maybe b) -> Maybe b
```

那么引入这样一堆玩意有啥好处？

我们来看这个：

```haskell
half x = if even x
    then Just (x `div` 2)
    else Nothing
```

```haskell
Prelude> Just 20 >>= half						-- 把Just 20塞进half函数里
Just 10
Prelude> Just 20 >>= half >>= half				-- 把Just 20的结果塞进half函数里
Just 5
Prelude> Just 20 >>= half >>= half >>= half
Nothing
```

链式调用，管道操作，酷毙了。

![monad_chain](http://blog.leichunfeng.com/images/monad_chain.png)

另外，monad的另外一个用法是用来实现函数式编程中那些不得不有的状态，比如IO monad和随机数monad（返回包裹在“随机数生成器状态”上下文中的随机数，Ouch，真难看），这不是函数式编程中好的那一部分，所以我不讲。

## 从函数式编程到函数式架构

上面这些东西都很不错，但我觉得你很难在“搬砖”的时候用到他们。

搬砖的时候最多用一下`map`、`reduce`、`filter`和少量递归的想法，几乎没有可能会显式地用到`Applicative`和`Monad`这些，原因很简单：他们太难了，很多人理解不能。

但是这些都是微观的函数式编程，我认为函数式真正NB的用途在于架构上，也就是“宏观的函数式编程”。

我们想一想我们在函数式编程里学到了什么。

1. “可变的”、“副作用”是不好的
2. 数据流>>函数>>函数>>函数 = 程序的结果

这些想法在架构中也能用到。

1. “可变”、“副作用”会带来管理上的复杂性，每个函数或方法必须明确“调用前要满足的条件”和“调用后会导致的副作用”，而这很可能会导致“认知超载”，故应当限制可变的东西。

   或者说，可以将系统设计为：

   系统状态=f(系统状态，用户行为)

   这样系统状态的改变的唯一原因就是“用户行为”[^8]。

2. 领域层（这是从DDD里借来的词） >> 渲染函数 = 表现层

将他们结合起来，我们可以得到这样一个架构：

1. 有一个“领域层”
2. 领域层 = applyAction(领域层,用户行为)
3. 表现层 = render(领域层)

那么这样一个架构像什么呢？

你可以说它像MVVM：

- “领域层” —— VM层
- render函数——由MVVM框架负责提供。
- 用户行为——是指用户修改了VM层的数据

但它更像是Flux：

![img](http://www.ruanyifeng.com/blogimg/asset/2016/bg2016011503.png)

- "领域层"——Store
- render函数——自己提供
- Action——就是Action

相比MVVM，Dispatcher为Flux提供了一个应用Action的统一入口，引起Store变化的原因被放在Dispatcher里面统一管理了起来，显得更加清晰。

更进一步的是Redux，它真正完美的实现了我们上面说的函数式架构：

相对于Flux，Redux的全部状态都放在了单一的Store中，也就是说它确实严格控制住了变化。

另外，Flux移除了Dispatcher，而真正的把

领域层 = applyAction(领域层,用户行为)

显式地作为函数写了出来，这个函数叫在Redux中叫`reducer`，即`(state, action) => state`。



[^1]: 我认为应当在适当的时候使用适当的范式、语言、框架，等等。你不太可能会用Python写操作系统，正如你同样不太可能用汇编写机器学习。 
[^2]: 做到这一点的语言就可以说是支持函数式编程， JS和Python本来如此，C++的支持通过函数指针/Callable object/lambda部分实现，Java 8+通过lambda部分实现。
[^3]: 不幸的是，“副作用”还包括IO等，因此实际上是没有办法完全消去副作用的。不过，Haskell在这方面使用了一些……tricks，让程序的大部分都还是“纯”的。
[^4]: 这并不是说你不该学习Lisp！你真的应该去看看SICP！
[^5]: 确实书上的丑陋实现会比FP的优雅实现要快一些（虽然时间复杂度是一样的），但显然FP的实现更容易理解，看FP实现更容易看出快排的精髓：将列表分为小于枢轴元素和大于枢轴元素两部分，再对这两部分分别排序，非FP实现在“如何将列表分为小于枢轴元素和大于枢轴元素两部分”这里写了大量代码，仅从代码量来看重要程度的话，有本末倒置之嫌，会使得学生错误的把重点放在“如何交换元素”上。当年要是我学快排的时候看到FP这样的实现，应该能更快地理解快速排序的想法，此时反过来再去研究“如何将列表分为小于枢轴元素和大于枢轴元素两部分”也会比较容易。
[^6]: 注意这是Haskell和大部分程序语言中对Functor的定义，它并不完全和上面的严密数学定义等价！
[^7]: 别忘了！函数是一等公民！它也是一个值，也能放在容器中！
[^8]: `Functor`、`Applicative`和`Monad`的部分介绍和图片来自[这里](http://blog.leichunfeng.com/blog/2015/11/08/functor-applicative-and-monad/)
[^9]: 记得吗，一个类或者模块应该有且只有一个改变的原因（SRP），开发过程和程序的运行过程中的最佳实践其实也是相通的啊。
[^10]: 当然，MVVM、Flux和Redux各个层之间的通信要靠各种不同的方法，比如Rx等。