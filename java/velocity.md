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

velocity配置文件中的编码配置类:
//对html文件编码的配置
org.apache.velocity.app.event.implement.EscapeHtmlReference
//对javascript文件编码的配置
org.apache.velocity.app.event.implement.EscapeJavascriptReference
//对sql文件编码的配置
org.apache.velocity.app.event.implement.EscapeSqlReference
//对xml文件编码的配置
org.apache.velocity.app.event.implement.EscapeXmlReference
1:在velocity.properties中配置全局变量转义：
default.contentType=text/html; charset=UTF-8
input.encoding=UTF-8
output.encoding=UTF-8
eventhandler.referenceinsertion.class = org.apache.velocity.app.event.implement.EscapeHtmlReference
eventhandler.referenceinsertion.class = org.apache.velocity.app.event.implement.EscapeSqlReference
eventhandler.escape.html.match = /msg.*/
eventhandler.escape.sql.match = /sql.*/
2:在velocity.properties中配置局部变量转义：
default.contentType=text/html; charset=UTF-8
input.encoding=UTF-8
output.encoding=UTF-8
eventhandler.referenceinsertion.class = org.apache.velocity.app.event.implement.EscapeHtmlReference
eventhandler.referenceinsertion.class = org.apache.velocity.app.event.implement.EscapeSqlReference
eventhandler.escape.html.match = /_html_*/
eventhandler.escape.sql.match = /_sql_*/
前台数据显示时 要转义的数据变量名定义需遵循:
格式:_html_自定义名字
例如：_html_title、_html_userName等等