# Web3 controller
# for Web3:
# apt-get update && apt install gcc python3.5-dev
#
#pip3 install web3
#workflow   https://www.draw.io/#G1yXU5Wpk7tX8-46XPNUB-CUb27HRQmbiy



import json
import web3

#from web3 import Web3, HTTPProvider, TestRPCProvider
#from solc import compile_source
#from web3.contract import ConciseContract

class Web3Controller:

    def _invoke_smart_contract(self, smart_contract_function_addr, smart_contract_ABI, smart_contract_function_name):
        smart_contract =  web3.eth.contract(address=smart_contract_function_addr, abi= smart_contract_ABI)  # globals()['web3.eth.contract']()
        return  getattr(smart_contract, smart_contract_function_name ) #returns function in smartcontract


    def get_info_external_storage(self, variablename, variablefunction): #needs name of get* function in https://github.com/DARFChainTeam/Angeles.VC-token-scrum-investing/contracts/admin/implementation/externalstorage.sol

        return self._invoke_smart_contract(self, project.external_storage_addr, project.external_storage_ABI, variablefunction).call({'record': variablename})

    def set_info_external_storage(self, variablevalue, variablename, variablefunction): #needs name of set* function in https://github.com/DARFChainTeam/Angeles.VC-token-scrum-investing/contracts/admin/implementation/externalstorage.sol

        return self._invoke_smart_contract(self, project.external_storage_addr, project.external_storage_ABI, variablefunction).call({'record': variablename, 'value': variablevalue}) #todo need to control types!


    def create_project(self): #address Projecttokenaddr, bytes32 DFSProjectdescribe, bytes4 DFStype) OnlyProjectOwner(Projecttokenaddr)

        return
    def change_project_info(self):
        return
    def  finish_project  (self):
        return
    def project_add_state(self):
        return

    def project_get_state(self):
        return

    def setrights(self):
        return
    def checkrights(self, project_token_address):


        return

# token management
#todo add token management to menu, views



