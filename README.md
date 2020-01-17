# 批量转账脚本

#### 操作步骤
1. 打开BitcoinDiamond-Qt, 接收-请求付款, 往该节点转入需要转账的金额
2. 用文本编辑器打开address_list.csv, 写入需要转账的地址列表, 格式必须是<地址,金额>, 不包括尖括号, 以半角逗号分隔, 没有空格, 金额单位是BCD, 每行一个地址, 文件名必须是address_list.csv
3. 双击transfer.py.command即可, 成功会输出交易id, 错误会输出错误信息

该脚本相当于BitcoinDiamond-Qt转账时添加多个收款人, 也可以用BitcoinDiamond-Qt代替

#### **注意**
不要随便双击脚本, 除非address_list.csv中的地址和数量是正确的, 不要重复点击脚本, 否则会造成重复转账, 转账完成后最好把address_list.csv删除, 然后用BitcoinDiamond-Qt把余额转走