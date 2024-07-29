``` python
import requests
import json
import base64
import hashlib

def calculate_md5_hex(app_id, body, app_key):
    # 将字符串拼接为字节串
    input_str = (app_id + body + app_key).encode('utf-8')

    # 计算MD5哈希值
    md5_hash = hashlib.md5()
    md5_hash.update(input_str)
    md5_hex = md5_hash.hexdigest().upper()
    
    return md5_hex


url = 'https://aaaaaaa/api/x5/'  

# 构造请求参数
data = {
    "header":
    {
        "method": "batchGetSummaryDetail",
        "sign": "xxxxxxxxxxxxxxxxxxxx",
        "appid": "xms"
    },
    "body": '{"region":1,"summaryIdList":[280968618,280968646]}'
}

print(data)

# 将请求参数转换为JSON字符串并进行Base64加密
# data_str = json.dumps(data)
# data_base64 = base64.b64encode(data_str.encode()).decode()

# 计算签名
appid = "key"  # 替换为实际的appid
appkey = "ssssss"  # 替换为实际的appkey
body_json = data["body"]
print(body_json)
sign = calculate_md5_hex(appid, body_json, appkey)
print(sign)

# 更新请求参数中的签名和base64编码后的body
data["header"]["sign"] = sign
# data["body"] = body_base64

# 将请求参数转换为JSON字符串并进行Base64加密
data_bytes = json.dumps(data, separators=(',', ':')).encode()
# print(type(data_bytes))
# 编码
data_base64 = base64.b64encode(data_bytes).decode()
print(data_base64)

# 设置请求头
headers = {
    "Content-Type": "application/x-www-form-urlencoded"
}

# 发起POST请求
payload = {
    "data": data_base64
}
response = requests.post(url, data=payload, headers=headers)

print(response)
print(response.text)

# 解析响应
result = response.json()
print(result)
```