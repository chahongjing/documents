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
// 分组后，按分数求合后全排
GET /my_test/_search
{
    "size": 10,
    "query":
    {
        "match":
        {
            "query": "手机"
        }
    },
    "aggs":
    {
        "gro":
        {
            "terms":
            {
                "field": "search_from",
                "order":
                {
                    "su": "desc"
                }
            },
            "aggs":
            {
                "su":
                {
                    "sum":
                    {
                        "script":
                        {
                            "source": "_score"
                        }
                    }
                }
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

#### should不生效
```json
{
    "from": 0,
    "size": 2,
    "query":
    {
        "bool":
        {
            "must":
            [
                {
                    "match":
                    {
                        "productRecommend": "1"
                    }
                },
                {
                    "match":
                    {
                        "location": "成都市"
                    }
                }
            ],
            "should":
            [
                {
                    "match":
                    {
                        "shopId": "1"
                    }
                }
            ]
        }
    }
}
要调整为
{
    "from": 0,
    "size": 12,
    "query":
    {
        "bool":
        {
            "must":
            [
                {
                    "match":
                    {
                        "productRecommend": "1"
                    }
                },
                {
                    "match":
                    {
                        "location": "成都市"
                    }
                },
                {
                    "bool":
                    {
                        "should":
                        [
                            {
                                "match":
                                {
                                    "shopId": "1"
                                }
                            },
                            {
                                "match":
                                {
                                    "shopId": "2"
                                }
                            }
                        ]
                    }
                }
            ]
        }
    }
}
```
#### 查看配置信息
``` json
// 查看索引信息
GET /index_name
// 查看映射
GET /info_mixms_kbs_test/_mapping
// 映射添加字段，注意properties要全部的属性，因为这是覆盖式的更新，可以先执行上面的GET查询映射信息
PUT /info_mixms_kbs_test/_mapping
{
  "properties": {
    "old_field": {
      "xxxx": "xxxxxx"
    },
    "your_field": {
      "type": "keyword"
    }
  }
}
```
#### 查询数据
``` json
// 通过字段查询
GET /index_name/_search?q=title:小米蓝牙手柄如何与小米电视
// 通过id查询
GET /index_name/_doc/yourId?pretty
// 通过条件查询
GET /index_name/_search
{
  "query": {
    "match": {
      "title": "小米蓝牙"
    }
  }
}
// 通过条件查询
GET /index_name/_search
{
  "query": {
    "terms": {
      "type": [4, 5]
    }
  }
}
// 通过日期查询
GET /index_name/_search
{
  "query": {
    "bool": {
      "must": [
        {"term": {"create_miliao": {"value": 3150270580}}
        },
        {
          "range": {
            "create_time": {
              "gte": "2022-05-23 10:30:00",
              "time_zone": "+08:00"
            }
          }
        }
      ]
    }
  }
}
// and和or条件 type=4 and (title like '%小米%' or title like '%红米%')
GET /index_name/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "match": {
            "type": "4"
          }
        },
        {
          "bool": {
            "should": [
              {
                "match": {
                  "title": "小米"
                }
              },
              {
                "match": {
                  "title": "红米"
                }
              }
            ]
          }
        }
      ]
    }
  }
}
```
#### 创建数据
``` json
// 创建数据
PUT /index_name/_doc/yourId
{
    "title" : "测试",
    "content" : "测试内容"
}
```
#### 更新数据
``` json
// 更新数据，如果没有，则插入
POST /index_name/_update/yourId
{
  "doc": {
    "content": "更新后的内容"
  },
  "doc_as_upsert": true
}
// 更新数据指定字段
POST /index_name/_update/yourId
{
  "doc": {
    "content":"来吧"
  }
}

// 如果不存在，执行upsert,如果存在执行doc中的更新
POST /index_name/_update/yourId
{
  "doc": {
    "content": "just update"
  },
  "upsert": {
    "title" : "upsert title",
    "content" : "upsert content"
  }
}
```
#### 删除数据
``` json
// 通过id删除数据
DELETE /index_name/_doc/yourId
// 通过条件删除数据
POST /index_name/_delete_by_query
{
  "query": {
    "match": {
      "_id": "yourId"
    }
  }
}
```
#### 删除索引
``` json
// 删除索引
DELETE /kfs_kbs_query_test

// 创建索引
PUT /kfs_kbs_query_test
{
    "mappings":
    {
        "properties":
        {
            "create_time":
            {
                "type": "long"
            },
            "region":
            {
                "type": "long"
            },
            "search_from":
            {
                "type": "keyword"
            },
            "query":
            {
                "type": "text",
                "analyzer": "ik_smart",
                "search_analyzer": "smart_analyzer"
            },
            "case_id":
            {
                "type": "keyword"
            },
            "thread_id":
            {
                "type": "keyword"
            },
            "queue_id":
            {
                "type": "keyword"
            },
            "miliao":
            {
                "type": "long"
            }
        }
    }
}





PUT /kfs_kbs_query_prod
{
    "settings":
    {
        "index":
        {
            "refresh_interval": "30s",
            "indexing":
            {
                "slowlog":
                {
                    "level": "info",
                    "threshold":
                    {
                        "index":
                        {
                            "warn": "1s",
                            "trace": "0ms",
                            "debug": "100ms",
                            "info": "500ms"
                        }
                    },
                    "source": "false"
                }
            },
            "translog":
            {
                "flush_threshold_size": "1024mb",
                "sync_interval": "60s",
                "durability": "async"
            },
            "unassigned":
            {
                "node_left":
                {
                    "delayed_timeout": "5m"
                }
            },
            "analysis":
            {
                "filter":
                {
                    "cn_stop":
                    {
                        "type": "stop",
                        "stopwords":
                        [
                            "也",
                            "了",
                            "仍",
                            "从",
                            "以",
                            "使",
                            "则",
                            "却",
                            "又",
                            "及",
                            "对",
                            "就",
                            "并",
                            "很",
                            "或",
                            "把",
                            "是",
                            "的",
                            "着",
                            "给",
                            "而",
                            "被",
                            "让",
                            "在",
                            "还",
                            "比",
                            "等",
                            "当",
                            "与",
                            "于",
                            "但"
                        ]
                    },
                    "synonymous_filter":
                    {
                        "type": "synonym",
                        "expand": "true",
                        "synonyms":
                        [
                            "拆机,装机,拆装机",
                            "厨宝,小厨宝",
                            "不能,无法",
                            "xiaomi,小米",
                            "redmi,红米",
                            "book,笔记本",
                            "xiaomibook,mibook,小米笔记本",
                            "redmibook,红米笔记本",
                            "watch,手表",
                            "top20,t20",
                            "双十一,双11",
                            "双十二,双12",
                            "开发者模式,开发者选项",
                            "意外险,意外保障服务",
                            "pad,平板"
                        ]
                    }
                },
                "analyzer":
                {
                    "content_analyzer":
                    {
                        "filter":
                        [
                            "lowercase",
                            "synonymous_filter"
                        ],
                        "tokenizer": "ik_max_word"
                    },
                    "smart_analyzer":
                    {
                        "filter":
                        [
                            "lowercase",
                            "cn_stop",
                            "synonymous_filter"
                        ],
                        "tokenizer": "ik_smart"
                    },
                    "title_analyzer":
                    {
                        "filter":
                        [
                            "lowercase",
                            "synonymous_filter"
                        ],
                        "tokenizer": "ik_max_word"
                    }
                }
            }
        }
    },
    "mappings":
    {
        "properties":
        {
            "create_time":
            {
                "type": "long"
            },
            "region":
            {
                "type": "long"
            },
            "search_from":
            {
                "type": "keyword"
            },
            "query":
            {
                "type": "text",
                "analyzer": "ik_max_word",
                "search_analyzer": "title_analyzer"
            },
            "case_id":
            {
                "type": "keyword"
            },
            "thread_id":
            {
                "type": "keyword"
            },
            "queue_id":
            {
                "type": "keyword"
            },
            "miliao":
            {
                "type": "long"
            }
        }
    }
}
```
``` java
// 查看分词结果
GET /kbs_baike_test/_analyze
{
   "analyzer": "content_analyzer",
   "text": "我的ner"
}
```
#### 多字段查询
multi_match
#### 判断是否有某个字段
``` java
// must, must_not
GET /index_name
{
  "query": {
    "bool": {
      "must": {
        "exists": {
          "field": "title"
        }
      }
    }
  }
}
```
#### 查询索引总记录数count(*)
``` java
GET /index_name/_count
```
#### 查询索引全量数据
``` java
GET /index_name/_search
{
  "query": {
    "match_all": {}
  }
}
```
#### 查看索引字段映射信息
``` java
GET /index_name/_mapping
```
#### 分词
```java
GET /index_name/_analyze
{
  "field": "title",
  "text": ["南京市长江大桥"]
}
```
#### 子文档查询
``` json
GET /info_kfs_wo_instance_mi-cn/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "term": {
            "_id": {
              "value": "9569617c6c9849ef9d937641c1ca3a7e"
            }
          }
        }
      ], 
      "should": [
        {
          "bool": {
            "should": [
              {
                "match": {
                  "answer": "空调"
                }
              }
            ],
            "filter": [
              {
                "bool": {
                  "should": [
                    {
                      "term": {"_id":"9569617c6c9849ef9d937641c1ca3a7e"}
                    },
                    {
                      "term": {"_id":"9569617c6c9849ef9d937641c1ca3a7e"}
                    },
                    {
                      "term": {"_id":"9569617c6c9849ef9d937641c1ca3a7e"}
                    },
                    {
                      "term": {"_id":"9569617c6c9849ef9d937641c1ca3a7e"}
                    }
                  ]
                }
              }
            ]
          }
        },
        {
          "nested": {
            "path": "extra",
            "inner_hits": {
              "name": "subdoc",
              "ignore_unmapped": false
            },
            "query": {
              "bool": {
                "should":[
                  {
                    "match_phrase": {
                      "extra.value": "大家电部"
                    }
                  }
                ],
                "filter": [
                  {
                    "bool": {
                      "must": [
                        {
                          "bool": {
                            "should": [
                              {
                                "term": {"_id":"9569617c6c9849ef9d937641c1ca3a7e"}
                              },
                              {
                                "term": {"_id":"9569617c6c9849ef9d937641c1ca3a7e"}
                              },
                              {
                                "term": {"_id":"9569617c6c9849ef9d937641c1ca3a7e"}
                              },
                              {
                                "term": {"_id":"9569617c6c9849ef9d937641c1ca3a7e"}
                              }
                            ]
                          }
                        },
                        {
                          "bool": {
                            "should": [
                              {
                                "term": {"_id":"9569617c6c9849ef9d937641c1ca3a7e"}
                              },
                              {
                                "term": {"_id":"9569617c6c9849ef9d937641c1ca3a7e"}
                              }
                            ]
                          }
                        }
                      ]
                    }
                  }
                ]
              }
            }
          }
        }
      ],
      "filter": [
        {
          "term": {
            "region": "1"
          }
        }
      ]
    }
  }
}
```

```es
中华人民共和国国徽
ik_max_word：会将文本做最细粒度的拆分。拆分为："中华人民共和国"和"国徽"
ik_smart：会做最粗粒度的拆分，拆分为："中华人民共和国"，"中华人民"，"中华"，"华人"，"人民共和国"，"人民"，"共和国"，"共和"，"国"，"国徽"
```