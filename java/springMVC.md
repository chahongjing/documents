# spring mvc配置
1. 新建Maven Project, 其中一个next步骤选择filter为maven-archetype-webapp.
2. 修改pom.xml导入mvc相关jar包. 添加版本节点, 值可根据对应版本要求进行修改(注意命名空间)
~~~ xml
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
    <properties>
        <org.springframework.version>5.1.7.RELEASE</org.springframework.version>
    </properties>

    <dependencies>
        <dependency>
            <groupId>javax.servlet</groupId>
            <artifactId>javax.servlet-api</artifactId>
            <version>3.1.0</version>
            <scope>provided</scope>
        </dependency>
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-webmvc</artifactId>
            <version>${org.springframework.version}</version>
        </dependency>

        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-jdbc</artifactId>
            <version>${org.springframework.version}</version>
        </dependency>
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-aspects</artifactId>
            <version>${org.springframework.version}</version>
        </dependency>
    </dependencies>
</project>
~~~
3. 修改项目配置文件WEB-INF文件夹下的web.xml, 添加如下节点, 注意spring上下文中的xml配置指向的是自己的配置bean文件
~~~ xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app>
	<!-- 上下文配置 -->
    <context-param>
        <param-name>contextConfigLocation</param-name>
        <param-value>classpath:applicationContext.xml,classpath:/config/spring-context-*.xml</param-value>
    </context-param>
    <!-- 上下文监听 -->
    <listener>
        <listener-class>org.springframework.web.context.ContextLoaderListener
        </listener-class>
    </listener>
	<!-- springmvc servlet -->
    <servlet>
        <servlet-name>springmvc</servlet-name>
        <servlet-class>org.springframework.web.servlet.DispatcherServlet
        </servlet-class>
        <load-on-startup>1</load-on-startup>
        <init-param>
            <param-name>contextConfigLocation</param-name>
            <param-value>classpath:/config/spring-mvc.xml</param-value>
        </init-param>
    </servlet>
    <servlet-mapping>
        <servlet-name>springmvc</servlet-name>
        <url-pattern>/</url-pattern>
    </servlet-mapping>

    <filter>
        <filter-name>EncodingFilter</filter-name>
        <filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>
        <init-param>
            <param-name>encoding</param-name>
            <param-value>UTF-8</param-value>
        </init-param>
        <init-param>
            <param-name>forceEncoding</param-name>
            <param-value>true</param-value>
        </init-param>
    </filter>

    <filter-mapping>
        <filter-name>EncodingFilter</filter-name>
        <url-pattern>/*</url-pattern>
    </filter-mapping>
</web-app>
<!--                 applicationContext.xml文件配置                  -->
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:aop="http://www.springframework.org/schema/aop"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd
		http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context-4.2.xsd http://www.springframework.org/schema/aop http://www.springframework.org/schema/aop/spring-aop.xsd">

    <!-- properties配置信息当使用@Value时必须要添加此节点-->
    <context:property-placeholder location="classpath:application.properties"/>

    <context:component-scan base-package="com.zjy.bll,com.zjy.baseframework">
        <context:exclude-filter type="annotation" expression="org.springframework.stereotype.Controller" />
        <context:exclude-filter type="annotation" expression="org.springframework.web.bind.annotation.ControllerAdvice" />
    </context:component-scan>

    <!-- 使AspectJ注解起作用：自动为匹配的类生成代理对象 -->
    <aop:aspectj-autoproxy></aop:aspectj-autoproxy>
</beans>

<!--                spring mvc配置                               -->
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:mvc="http://www.springframework.org/schema/mvc"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:p="http://www.springframework.org/schema/p"
       xsi:schemaLocation="http://www.springframework.org/schema/mvc http://www.springframework.org/schema/mvc/spring-mvc-4.2.xsd
		http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-4.2.xsd
		http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context-4.2.xsd">

    <!-- ①：在指定的包下扫描@Component @Controller @Service @Reposity等注解 -->
    <!--<context:component-scan base-package="com.zjy.web.controller,com.zjy.bll,com.zjy.baseframework"/>-->
    <context:component-scan base-package="com.zjy" use-default-filters="false">
        <context:include-filter type="annotation" expression="org.springframework.stereotype.Controller" />
        <context:include-filter type="annotation" expression="org.springframework.web.bind.annotation.ControllerAdvice" />
    </context:component-scan>

    <!-- ②：对模型视图名称的解析，即在模型视图名称添加前后缀 -->
    <bean class="org.springframework.web.servlet.view.InternalResourceViewResolver"
          p:prefix="${web.view.prefix}" p:suffix="${web.view.suffix}"/>

    <!-- 静态文件映射，将无法mapping到Controller的path交给default servlet handler处理 -->
    <mvc:default-servlet-handler/>
    <!-- 对静态资源文件的访问 -->
    <!-- <mvc:resources mapping="/resources/**" location="/" cache-period="10000" /> -->


    <!-- 这个是SpringMVC必须要配置的，因为它声明了@RequestMapping、@RequestBody、@ResponseBody等。并且，该配置默认加载很多的参数绑定方法，比如json转换解析器等。 -->
    <mvc:annotation-driven>
        <!-- json格式化器 -->
        <mvc:message-converters>
            <!-- <bean class="org.springframework.http.converter.StringHttpMessageConverter" />
            <bean class="org.springframework.http.converter.json.MappingJackson2HttpMessageConverter" /> -->
            <ref bean="jsonConverter"/>
            <ref bean="stringHttpMessageConverter"/>
        </mvc:message-converters>
    </mvc:annotation-driven>

    <!-- json格式化器 -->
    <bean id="stringHttpMessageConverter"
          class="org.springframework.http.converter.StringHttpMessageConverter">
        <constructor-arg value="UTF-8" index="0"></constructor-arg>
        <property name="supportedMediaTypes">
            <list>
                <value>text/plain;charset=utf-8</value>
                <value>text/html;charset=utf-8</value>
                <value>application/json;charset=utf-8</value>
                <value>application/xml;charset=utf-8</value>
            </list>
        </property>
    </bean>

    <!-- json格式化器 -->
    <bean id="jsonConverter" class="com.alibaba.fastjson.support.spring.FastJsonHttpMessageConverter">
        <property name="supportedMediaTypes">
            <list>
                <value>application/json;charset=UTF-8</value>
                <value>text/json;charset=UTF-8</value>
                <value>text/html;charset=UTF-8</value>
            </list>
        </property>
        <property name="fastJsonConfig">
            <bean class="com.zjy.bll.common.FastJsonConfigExt">
                <property name="charset" value="UTF-8" />
                <property name="serializeFilters">
                    <list>
                        <bean class="com.zjy.bll.common.DateFormaterFilter" />
                        <bean class="com.zjy.bll.common.ZonedDateFormaterFilter" />
                    </list>
                </property>
                <property name="serializerFeatures">
                    <array value-type="com.alibaba.fastjson.serializer.SerializerFeature">
                        <value>DisableCircularReferenceDetect</value>
                    </array>
                </property>
            </bean>
        </property>
    </bean>

    <!-- 文件上传 -->
    <bean id="multipartResolver"
          class="org.springframework.web.multipart.commons.CommonsMultipartResolver">
        <!-- 设置上传文件的最大尺寸为1MB -->
        <property name="defaultEncoding" value="UTF-8" />
        <property name="maxUploadSize" value="1048576" />
    </bean>
</beans>
~~~
4. 在resources下添加application.properties文件, 内容如下:
~~~ ini
# jdbc.oracle
#db.driverClassName=oracle.jdbc.OracleDriver
## sid
#db.url=jdbc:oracle:thin:@127.0.0.1:1521:orcl
## serviceName
##db.url=jdbc:oracle:thin:@//127.0.0.1:1521/orcl
#db.userName=zjy
#db.password=1024
#db.testSql=select 'x' from dual
#db.dialect=oracle

# jdbc.mysql
#db.driverClassName=com.mysql.cj.jdbc.Driver
#db.driverClassName=com.mysql.jdbc.Driver
#db.url=jdbc:mysql://127.0.0.1:3306/toolsitemvc4j?useUnicode=true&characterEncoding=utf-8&useSSL=false
#db.url=jdbc:mysql://localhost/toolsitemvc4j?useUnicode=true&characterEncoding=utf-8
#db.userName=root
#db.password=root
#db.testSql=select 'x'
#db.dialect=mysql

# jdbc.sql server
#db.driverClassName=com.microsoft.sqlserver.jdbc.SQLServerDriver
##db.url=jdbc:sqlserver://PC201404190064\\MSSQL; DatabaseName=ToolSiteMvc4J
#db.url=jdbc:sqlserver://127.0.0.1; DatabaseName=ToolSiteMvc4J
#db.userName=sa
#db.password=1024
#db.testSql=select 'x'
#db.dialect=sqlserver

# jdbc.sqlite
db.driverClassName=org.sqlite.JDBC
# diskdirive: jdbc:sqlite://d://app.db
db.url=jdbc:sqlite::resource:db/app.db
db.phyUrl=jdbc:sqlite://F:/Source/Java/ToolSiteMvc4J/trunk/web/src/main/resources/db/app.db
db.testSql=select 'x'
db.dialect=SQLite
# sqlite has no user and passord
db.userName=
db.password=
~~~