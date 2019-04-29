# Web3 controller
# for Web3:
# apt-get update && apt install gcc python3.5-dev
#
#pip3 install web3
#workflow   https://www.draw.io/#G1yXU5Wpk7tX8-46XPNUB-CUb27HRQmbiy


import json
import web3

from web3 import Web3, HTTPProvider, TestRPCProvider
from solc import compile_source
from web3.contract import ConciseContract
