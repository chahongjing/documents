use test

db.user.insert({"name":"������","age":25})

db.user.update({"name":"������"},{"$set":{"sex":"male"}}, true, true)
db.user.update({"name":"������"},{"$unset":{"sex":"male"}}, true, true)

::��insertһ��, ֻ����������洫����_idֵ����ȸ���_idֵ���и���, ��δ�ҵ�����, �����
db.user.save({"_id":ObjectId("558e3d2748f5f451deaf0938"), "name":"����","age":22, "birthday":ISODate("1990-11-02 07:58:51.718")})

db.user.save({"_id":ObjectId("558e3d2748f5f451deaf0938"),"age":32, "birthday":ISODate("1977-11-02 07:58:51.718")})


db.user.insert({"name":"����ɾ��","age":22})
db.user.find()
db.user.remove({"name":"����ɾ��"})
