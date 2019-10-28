### th:insert 3.0+版本新加的,th:replace 2.0+ 3.0+都可用,th:include 这个在3.0版本已经不建议使用
~~~ html
<!-- 有这么一个html段 -->
<footer th:fragment="copy"> 
  © 2011 The Good Thymes Virtual Grocery
</footer>

<!-- 引用html段 -->
<body>
  <div th:insert="footer :: copy"></div>
  <div th:replace="footer :: copy"></div>
  <div th:include="footer :: copy"></div>
</body>

<!-- 最终结果 -->
<body>
  <p th:text="abc">会编码</p>
  <p th:utext="abc">不会编码，有注入风险</p>
  <!-- th:insert，div tag内部插入html段 -->
  <div>
    <footer>
      © 2011 The Good Thymes Virtual Grocery
    </footer>
  </div>
  <!-- th:replace，使用html段直接替换 div tag -->
  <footer>
    © 2011 The Good Thymes Virtual Grocery
  </footer>
  <!-- th:include，div tag内部插入html段（仅保留段子元素的内容） -->
  <!-- 仔细对比 th:insert 与 th:include的结果 -->
  <div>
    © 2011 The Good Thymes Virtual Grocery
  </div>
</body>
~~~
![thymeleaf](/imgs/java/2.jpg)
![thymeleaf](/imgs/java/3.jpg)
~~~ html
<!-- menu.html -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link href="favicon.ico" rel="shortcut icon" type="image/x-icon">
<script type="text/javascript" th:src="${@resourceService.getVersion('/css/common/bootstrap-3.3.7-dist/css/bootstrap.min.css')}"></script>
<script type="text/javascript" th:src="${@resourceService.getVersion('/js/common/jquery-3.4.1.min.js')}"></script>
<script type="text/javascript" th:src="${@resourceService.getVersion('/js/common/common.js')}"></script>
<script type="text/javascript" th:src="${@resourceService.getVersion('/js/common/vue.js')}"></script>

<!-- index.html -->
<!DOCTYPE html>
<html lang="zh" xmlns:th="http://www.thymeleaf.org">
<head>
    <div th:replace="layout/header"></div>
</head>
<body>
</body>
</html>
~~~
~~~ java
@Component("resourceService")
public class ResourceServiceImpl {
    public String getVersion(String path) {
//        classpath:/static
//        classpath:/public
//        classpath:/resources
//        classpath:/META-INF/resources
        String root = ClassUtils.getDefaultClassLoader().getResource(StringUtils.EMPTY).toString();
        if(root.startsWith("file:/")) {
            root = root.substring(6);
        }
        File file = Paths.get(root, "/static", path).toFile();
        if(file.exists()) {
            long version = file.lastModified();
            path += "?_v=" + version;
        }
        System.out.println("version:" + path);
        return path;
    }
}
~~~