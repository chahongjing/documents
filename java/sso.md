# 安装cas-server
1. 在官网下载cas-server。[cas git下载未编译文件](https://github.com/apereo/cas/releases) | 
[cas各个版本及依赖jar包](http://repo1.maven.org/maven2/org/apereo/cas/cas-server-webapp-tomcat/)
2. 修改pom中(cas-server版本为5.3.10)依赖的数据库连接jar包，在注释 Additional dependencies may be placed here处
~~~ xml
<dependency>
    <groupId>org.apereo.cas</groupId>
    <artifactId>cas-server-support-jdbc</artifactId>
    <version>${cas.version}</version>
</dependency>
<dependency>
    <groupId>org.apereo.cas</groupId>
    <artifactId>cas-server-support-jdbc-drivers</artifactId>
    <version>${cas.version}</version>
</dependency>
<dependency>
    <groupId>mysql</groupId>
    <artifactId>mysql-connector-java</artifactId>
    <version>8.0.13</version>
</dependency>
~~~
3. mvn package编译war包
4. 将编译的war包放到tomcat中，解压后修改application.properties配置文件，然后就可以使用用户名密码登录了
  - 去掉配置文件中的`cas.authn.accept.users=casuser::Mellon`默认用户名和密码
  - 创建数据库
  ~~~ sql
  CREATE DATABASE toolsitemvc4j DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE TABLE IF NOT EXISTS myuser(userid INT primary key, code VARCHAR(100), name VARCHAR(100), password VARCHAR(100)) COMMENT='用户表';

INSERT INTO myuser(userid,code,password,name) VALUES (1,'admin','123456','admin');
INSERT INTO myuser(userid,code,password,name) VALUES (2,'adminmd5','e10adc3949ba59abbe56e057f20f883e','adminmd5');
INSERT INTO myuser(userid,code,password,name) VALUES (3,'adminsalt','d4135f5902dc61968f3e439f58a0f10e','adminsalt');
  ~~~
  - 添加jdbc配认证
  ~~~ ini
  #添加jdbc认证
cas.authn.jdbc.query[0].sql=SELECT * FROM myuser WHERE code = ?
#那一个字段作为密码字段
cas.authn.jdbc.query[0].fieldPassword=password
#配置数据库连接
cas.authn.jdbc.query[0].url=jdbc:mysql://127.0.0.1:3306/toolsitemvc4j?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true&useSSL=false
cas.authn.jdbc.query[0].dialect=org.hibernate.dialect.MySQLDialect
#数据库用户名
cas.authn.jdbc.query[0].user=root
#数据库密码
cas.authn.jdbc.query[0].password=root
#mysql驱动
cas.authn.jdbc.query[0].driverClass=com.mysql.cj.jdbc.Driver
  ~~~
### 配置md5加盐验证
~~~ ini
#配置md5加密策略
cas.authn.jdbc.query[0].passwordEncoder.type=DEFAULT
cas.authn.jdbc.query[0].passwordEncoder.characterEncoding=UTF-8
cas.authn.jdbc.query[0].passwordEncoder.encodingAlgorithm=MD5
~~~
### 配置md5加盐值处理
~~~ ini
#配置md5加盐值处理
#加密迭代次数
cas.authn.jdbc.encode[0].numberOfIterations=2
#该列名的值可替代上面的值，但对密码加密时必须取该值进行处理
cas.authn.jdbc.encode[0].numberOfIterationsFieldName=
#静态盐值
cas.authn.jdbc.encode[0].staticSalt=.
#盐值固定列
cas.authn.jdbc.encode[0].saltFieldName=userid
cas.authn.jdbc.encode[0].sql=SELECT * FROM myuser WHERE code = ?
#对处理盐值后的算法
cas.authn.jdbc.encode[0].algorithmName=MD5
cas.authn.jdbc.encode[0].passwordFieldName=password
#cas.authn.jdbc.encode[0].expiredFieldName=expired
#cas.authn.jdbc.encode[0].disabledFieldName=disabled
#数据库连接
cas.authn.jdbc.encode[0].url=jdbc:mysql://127.0.0.1:3306/toolsitemvc4j?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true&useSSL=false
cas.authn.jdbc.encode[0].dialect=org.hibernate.dialect.MySQL5Dialect
cas.authn.jdbc.encode[0].driverClass=com.mysql.cj.jdbc.Driver
cas.authn.jdbc.encode[0].user=root
cas.authn.jdbc.encode[0].password=root
~~~
**注意：如果两种方式都配置的话,默认先用普通MD5验证，如果验证失败，打印异常日志,然后再使用加盐方式验证。**
### java密码加盐
~~~ java
public class PasswordSaltTest {
    private String staticSalt = ".";
    private String algorithmName = "MD5";
    private String encodedPassword = "123456";
    private String dynaSalt = "test";
    private int hashIterations = 2;

    public String getSSOPassword(String password, String salt) {
        ConfigurableHashService hashService = new DefaultHashService();
        // 静态盐值
        hashService.setPrivateSalt(ByteSource.Util.bytes(this.staticSalt));
        // md5hash
        hashService.setHashAlgorithmName(this.algorithmName);
        // 加密2次
        hashService.setHashIterations(this.hashIterations);
        HashRequest request = new HashRequest.Builder()
                .setSalt(salt)
                .setSource(password)
                .build();
        String res =  hashService.computeHash(request).toHex();
        System.out.println(res);
        return res;
    }
}
~~~