#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import os

import pandas as pd
from bitcoinrpc.authproxy import AuthServiceProxy

mainnet = {
    'rpc_user': 'bitcoinrpc',
    'rpc_password': '123456',
    'rpc_host': '127.0.0.1',
    'rpc_port': 7116
}

testnet = {
    'rpc_user': 'bitcoinrpc',
    'rpc_password': '123456',
    'rpc_host': '127.0.0.1',
    'rpc_port': 17116
}

regtest = {
    'rpc_user': 'bitcoinrpc',
    'rpc_password': '123456',
    'rpc_host': '127.0.0.1',
    'rpc_port': 27116
}

bitcoinrpc = None
file_name = os.path.dirname(os.path.abspath(__file__)) + '/address_list.csv'


def set_net_type(network):
    global bitcoinrpc
    if network == 'mainnet':
        net = mainnet
    elif network == 'testnet':
        net = testnet
    elif network == 'regtest':
        net = regtest
    else:
        return
    bitcoinrpc = AuthServiceProxy(
        "http://%s:%s@%s:%s" % (net['rpc_user'], net['rpc_password'], net['rpc_host'], net['rpc_port']))


def get_new_address(count):
    for i in range(count):
        address = bitcoinrpc.getnewaddress()
        print(address)


def get_address_list():
    address_dict = {}
    df = pd.read_csv(file_name, header=None, sep=',', names=['address', 'value'], dtype={'address': str, 'value': str})
    for index, row in df.iterrows():
        address_dict[row['address']] = row['value']
    return address_dict


def send_to_address_list_from_csv():
    tx_id = bitcoinrpc.sendmany('', get_address_list())
    print('转账成功')
    print('交易哈希:', tx_id)


if __name__ == '__main__':
    print('\n')
    input_str = input('是否确认转账(Y/N)')
    if input_str != 'Y':
        print('退出转账\n\n')
        exit(0)

    print('\n\n+++++++++++++++++begin+++++++++++++++++\n')
    try:
        print('开始转账...')
        set_net_type('regtest')
        send_to_address_list_from_csv()
    except Exception as e:
        print('转账失败')
        print(e)
    print('\n++++++++++++++++++end++++++++++++++++++\n\n')
