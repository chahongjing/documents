use test

db.user.insert({"name":"曾军毅","age":25})

db.user.update({"name":"曾军毅"},{"$set":{"sex":"male"}}, true, true)
db.user.update({"name":"曾军毅"},{"$unset":{"sex":"male"}}, true, true)

::和insert一样, 只不过如果里面传的有_id值则会先根据_id值进行更新, 若未找到数据, 则插入
db.user.save({"_id":ObjectId("558e3d2748f5f451deaf0938"), "name":"张三","age":22, "birthday":ISODate("1990-11-02 07:58:51.718")})

db.user.save({"_id":ObjectId("558e3d2748f5f451deaf0938"),"age":32, "birthday":ISODate("1977-11-02 07:58:51.718")})


db.user.insert({"name":"即将删除","age":22})
db.user.find()
db.user.remove({"name":"即将删除"})
