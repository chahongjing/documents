# artTemplate.js
- 对内容编码输出：{{content}}
- 不编码输出：{{#content}}
- if
~~~ html
{{if admin}}
 <p>admin</p>
{{else if code > 0}}
 <p>master</p>
{{else}}
 <p>error!</p>
{{/if}}
~~~
- for
~~~ html
{{each list as value index}}
 <li>{{index}} - {{value.user}}</li>
{{/each}}
<!-- 简写 -->
{{each list}}
 <li>{{$index}} - {{$value.user}}</li>
{{/each}}
~~~
- 辅助方法
~~~ js
template.helper('dateFormat', function (date, format) {
 // ..
 return value;
});
// 模板中使用的方式：
{{time | dateFormat:'yyyy-MM-dd hh:mm:ss'}}  
// 支持传入参数与嵌套使用：
{{time | say:'cd' | ubb | link}} 
~~~
- 实例
~~~ html
<div id="content"></div>
<script id="test" type="text/html">
{{if isAdmin}}
<h1>{{title}}</h1>
<ul>
 {{each list as value i}}
  <li>索引 {{i + 1}} ：{{value}}</li>
 {{/each}}
</ul>
{{/if}}
</script>
<script>
var data = {
 title: '基本例子',
 isAdmin: true,
 list: ['文艺', '博客', '摄影', '电影', '民谣', '旅行', '吉他']
};
var html = template('test', data);
document.getElementById('content').innerHTML = html;
</script>
~~~