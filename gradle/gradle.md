### 导入项目
- 选择build.gradle文件导入
- 导入后修改build.gradle添加阿里云仓库（添加在最前面）：buildscript->repositories->添加：maven { url "http://maven.aliyun.com/nexus/content/groups/public/"}
- 如果其中有git版本管理，去掉相关代码（四行），直接设置版本号，如currentRevision = "cas-5.3.10"
### 配置国内镜像
- USER_HOME/.gradle/下创建init.gradle文件，添加内容
~~~ json
allprojects{
    repositories {
        def ALIYUN_REPOSITORY_URL = 'http://maven.aliyun.com/nexus/content/groups/public'
        def ALIYUN_JCENTER_URL = 'http://maven.aliyun.com/nexus/content/repositories/jcenter'
        all { ArtifactRepository repo ->
            if(repo instanceof MavenArtifactRepository){
                def url = repo.url.toString()
                if (url.startsWith('https://repo1.maven.org/maven2')) {
                    project.logger.lifecycle "Repository ${repo.url} replaced by $ALIYUN_REPOSITORY_URL."
                    remove repo
                }
                if (url.startsWith('https://jcenter.bintray.com/')) {
                    project.logger.lifecycle "Repository ${repo.url} replaced by $ALIYUN_JCENTER_URL."
                    remove repo
                }
            }
        }
        maven {
            url ALIYUN_REPOSITORY_URL
            url ALIYUN_JCENTER_URL
        }
    }
}
~~~