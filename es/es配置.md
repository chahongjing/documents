### text文本不支持聚合等操作，提示要设置fielddata=true
1. 先查询索引信息 GET /your_index。如我的索引是：workorder_extend，则：GET /workorder_extend
![索引信息](/imgs/es/1.png)
2. 设置fielddata=true。语法：PUT /your_index/_mapping/your_doc，如下图content为字段
``` json
PUT /workorder_extend/_mapping/workorder_extend
{
  "properties":{
    "content":{
      "type": "text",
      "fielddata": true,
      "analyzer":"ik_max_word",
      "search_analyzer":"ik_smart"
    }
  }
}
```
3. 聚合查询
``` json
GET workorder_extend/_search
{
  "aggs": {
    "content": {
      "terms": { 
        "size":100,
        "field": "content",
        "include" : "[\u4E00-\u9FA5][\u4E00-\u9FA5].*"
      }
    }
  }
}
```
1、match：返回所有匹配的分词。
2、match_all：查询全部。
3、match_phrase：短语查询，在match的基础上进一步查询词组，可以指定slop分词间隔。
4、match_phrase_prefix：前缀查询，根据短语中最后一个词组做前缀匹配，可以应用于搜索提示，但注意和max_expanions搭配。其实默认是50.......
5、multi_match：多字段查询，使用相当的灵活，可以完成match_phrase和match_phrase_prefix的工作。

bool查询总结
must：与关系，相当于关系型数据库中的 and。
should：或关系，相当于关系型数据库中的 or。
must_not：非关系，相当于关系型数据库中的 not。
filter：过滤条件。
range：条件筛选范围。
gt：大于，相当于关系型数据库中的 >。
gte：大于等于，相当于关系型数据库中的 >=。
lt：小于，相当于关系型数据库中的 <。
lte：小于等于，相当于关系型数据库中的 <=。

term:单个精准匹配
terms：多个精准匹配，各个匹配结果之间的并集
