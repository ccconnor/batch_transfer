#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import traceback

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
file_name = 'address_list.csv'


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
    df = pd.read_csv(file_name, header=None, sep=',', names=['address', 'value'])
    for index, row in df.iterrows():
        address_dict[row['address']] = row['value']
    return address_dict


def send_to_address_list_from_csv():
    tx_id = bitcoinrpc.sendmany('', get_address_list())
    print('tx_id:', tx_id)


if __name__ == '__main__':
    print('\n\n+++++++++++++++++begin+++++++++++++++++\n')
    try:
        set_net_type('mainnet')
        send_to_address_list_from_csv()
    except Exception as e:
        print(e)
        print(traceback.format_exc())
    print('\n++++++++++++++++++end++++++++++++++++++\n\n')
