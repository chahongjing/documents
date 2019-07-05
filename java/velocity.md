# velocity
- \#来标识脚本，如#if
- $标识对象
- !用来强制把不存在的变量显示为空白。
- 用{}把变量和字符串分开。#set ($user="csy"}，${user}name，返回csyname
- test"$var" 返回testhello，test'$var' 返回test'$var'
- #if( $foo )，当$foo为null或为Boolean对象的false值执行.
~~~ java
// 定义变量
#set($awbpre='112')
#set($awbno='89089011')
#set($airwayBillNo=$awbpre+' - '+$awbno)
// 遍历数组
#set($list = ["CTU", "SHA", "LAX"])
#foreach ($item in $list)
  $velocityCount . $item <br/>
#end
// 遍历HashTable
#foreach($key in $table.keySet())
  $key -> $table.get($key)<br/>
#end
// 判断集合是否为空
#if($null.isNull($orderList.orders) || $orderList.orders.size()==0)
// 判断单个对象是否为空
#if($(orderDto))
// 格式化
$date.year - $date.month - $date.day
$date.format('yyyy-MM-dd HH:mm:ss',$order.createTime,$locale)
$number.format('0.00',$order.amount)
// 内置对象
$request
name = $request.getParameter("name")
$session
// 模块化
#parse("template/header.vm")
~~~