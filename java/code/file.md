### file
~~~ java
// parentDir是指当前文件所在的目录，即下面的D:\\书目录，类型为File
File[] files = new File("D:\\书").listFiles((parentDir, name) -> {
    System.out.println(parentDir);
    System.out.println(name);
    return true;
});
~~~