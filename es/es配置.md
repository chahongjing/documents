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