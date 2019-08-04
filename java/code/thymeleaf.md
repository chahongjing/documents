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
~~