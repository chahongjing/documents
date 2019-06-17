## 设置列显示注释
1. Model->Extensions：新建一个，然后点击箭头属性按钮<br>
![pd](/imgs/pd/pd1.png)<br>
![pd](/imgs/pd/pd2.png)<br>
2. Profile右键，点击Add Metaclasses，然后选择Column，然后点击OK:<br>
![pd](/imgs/pd/pd3.png)<br>
![pd](/imgs/pd/pd4.png)<br>
3. 选中Column，右键选择New->Extended Attribute，给一个名字，dataType选择String，选中Computer，选中Read only<br>
![pd](/imgs/pd/pd5.png)<br>
![pd](/imgs/pd/pd6.png)<br>
4. 切换到Get Method Script tab:把原有的代码：`%Get% = ""`换成：`%Get% = Rtf2Ascii (obj.Comment)`。注意：mysql是换成`%Get% = Rtf2Ascii (obj.Comment)`。<br>
![pd](/imgs/pd/pd7.png)<br>
5. 再进入Tools->Display Preferences->Table->Advanced->Columns，看看是不是有刚刚我们新建的那个attribute啦，勾选保存即可完成。zh_comment就是我新建的属性<br>
![pd](/imgs/pd/pd8.png)<br>
![pd](/imgs/pd/pd9.png)<br>
## 设置表的名称
1. 再进入Tools->Display Preferences->Table<br>
![pd](/imgs/pd/pd8.png)<br>
2. 选择Table, 勾选注释，点击确定<br>
![pd](/imgs/pd/pd10.png)<br>
3. 在弹出的框中选择all symbols即可。<br>
![pd](/imgs/pd/pd11.png)<br>