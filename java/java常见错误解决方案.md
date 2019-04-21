1. 启动web项目报严重: Error configuring application listener of class org.springframework.web.context.ContextLoaderListener, 右键项目  propertites  Deployment Assembly  add  选择Java build path entries,确定.
2. 路径中有中文时无法下载。解决办法：在tomcat/conf/server.xml中找到对应的Connector节点，添加URIEncoding="UTF-8"。
