``` python
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

plt.style.use('seaborn-white')

data = pd.read_csv(r'cn-requestLength.log') # 把请求长度预先存放到文件中了
d = data.iloc[:, 0]
split = pd.cut(d, [0, 50, 100, 200, 300, 400, 500, 1000, 3000, 8000],
               labels=[u"(0,50]", u"(50,100]", u"(100,200]", u"(200,300]", u"(300,400]", u"(400,500]", u"(500,1K]",
                       u"(1K,3K]", u"(3K,+INF]"])
freq = split.value_counts()
freq_sort = freq.sort_index()

c = {'section': freq_sort.index, 'total': freq_sort.values}
d = pd.DataFrame(c)

ax = plt.figure(figsize=(10, 9)).add_subplot(111)
sns.barplot(x="section", y="total", data=d, palette="Set3")  # palette设置颜色

plt.title('cn-pro: params length distribution', size=25)
plt.xticks(fontsize=9)
plt.yticks(fontsize=9)
#
for x, y in zip(range(9), d.total): ax.text(x, y, '%d' % y, ha='center', va='bottom', fontsize=10, color='grey')
plt.savefig('Python绘制的频数分布图.jpg', dpi=500, box_inches='tight')
```

``` python
# base64
import json,base64

data = {"header":{"method":"batchGetSummaryDetail","sign":"038A04FE3E46E4152D660CC6550D9E47","appid":"xms"},"body":"{\"region\":1,\"summaryIdList\":[280968618,280968646]}"}
# 先转化为bytes类型数据
data_bytes = json.dumps(data, separators=(',', ':')).encode()
print(type(data_bytes))
# 编码
base_data = base64.b64encode(data_bytes)
print(base_data)
```