# velocity
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