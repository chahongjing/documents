### 跨域
1. 无关Cookie跨域Ajax请求
- 客户端 以 jQuery 的 ajax 为例：
~~~ js
$.ajax({
        url : 'http://remote.domain.com/corsrequest',
        data : data,
        dataType: 'json',
        type : 'POST',
        crossDomain: true,
        contentType: "application/json", // POST时必须
       主要注意的是参数 crossDomain: true。发送Ajax时，Request header 中会包含跨域的额外信息，但不会含cookie。
~~~
- 服务器端 跨域的允许主要由服务器端控制。服务器端通过在响应的 header 中设置Access-Control-Allow-Origin及相关一系列参数，提供跨域访问的允许策略。相关参数的设置介绍，可参见 [Access_control_CORS]
~~~ java
/**
* Spring Controller中的方法：
*/
    @RequestMapping(value = "/corsrequest")
    @ResponseBody
    public Map<String, Object> mainHeaderInfo(HttpServletResponse response) {
        response.setHeader("Access-Control-Allow-Origin", "*");
        ...
}
~~~
- 通过在响应 header 中设置 ‘*’ 来允许来自所有域的跨域请求访问。
~~~ java
response.setHeader("Access-Control-Allow-Origin", "*");
// 只允许来自特定域 
http://my.domain.cn:8080
// 的跨域访问
response.setHeader("Access-Control-Allow-Origin", "http://my.domain.cn:8080");
// 较灵活的设置方式，允许所有包含mydomain.com的域名访问.
if(request.getHeader("Origin").contains("mydomain.com")) {
    response.setHeader("Access-Control-Allow-Origin", request.getHeader("Origin"));
}
~~~
2. 带Cookie的跨域Ajax请求
- 客户端发送Ajax时，Request header中便会带上 Cookie 信息。
~~~ js
$.ajax({
        url : 'http://remote.domain.com/corsrequest',
        data : data,
        dataType: 'json',
        type : 'POST',
        xhrFields: {
            withCredentials: true
        },
        crossDomain: true,
        contentType: "application/json",
        ...
// 通过设置 
withCredentials: true
~~~
- 服务器端相应的，对于客户端的参数，服务器端也需要进行设置：
~~~ java
/**
* Spring Controller中的方法：
*/
@RequestMapping(value = "/corsrequest")
@ResponseBody
public Map<String, Object> getUserBaseInfo(HttpServletResponse response) {
    if(request.getHeader("Origin").contains("woego.cn")) {
        response.setHeader("Access-Control-Allow-Origin", request.getHeader("Origin"));
    }
    response.setHeader("Access-Control-Allow-Credentials", "true");
    ...
}
~~~
对应客户端的 
~~~ js
xhrFields.withCredentials: true
~~~
- 参数，服务器端通过在响应 header 中设置 
~~~ java
Access-Control-Allow-Credentials = true
~~~
- 来运行客户端携带证书式访问。通过对 Credentials 参数的设置，就可以保持跨域 Ajax 时的 Cookie。这里需要注意的是：服务器端 Access-Control-Allow-Credentials = true时，参数Access-Control-Allow-Origin的值不能为 '*'。
3. Java中使用跨域 Filter。当允许跨域访问的接口较多时，在每个请求中都添加 Access-Control-Allow-Origin 显然是不合适的。对于比较原生的 Java web 应用，使用 Filter 是一个不错的选择。NOTE：不同的框架，特别是支持REST的框架，大多提供了自己的跨域设置方式，如Spring4的Config等，可以优先从使用的框架中寻找支持。Filter本身很简单，可以直接把上面两句设置 Header 的语句抽取出来写一个Filter。这里推荐一个 Tomcat 中的 Filter：org.apache.catalina.filters.CorsFilter。
引入 这个类在 Tomcat 的 catalina.jar 中，可以通过将 tomcat/lib 下的 jar 包引用到项目中的方式来使用。但如果你对项目的 jar 环境有’洁癖’, 也可以单独把 这个类的 SVN源码 拷贝到项目中，修改（删除）一下‘日志’和‘异常提示内容’的引用就可以运行在任何原生java web项目中了。