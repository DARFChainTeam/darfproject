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

    # PROJECTSMARTCONTRACTNAME = 'scruminvest/project'

    def _Invoke_smart_contract(self, smart_contract_function_addr, smart_contract_ABI,\
                               smart_contract_function_name):
        #todo: adopt to  SmartContractsAdresses ledger
        smart_contract =  web3.eth.contract(address=smart_contract_function_addr, \
                                            abi= smart_contract_ABI)  # globals()['web3.eth.contract']()

        return  getattr(smart_contract, smart_contract_function_name ) #returns function in smartcontract



    def Get_smart_contract_data (self, smartcontractname):
        return (project.smart_contracts[('smart_contract_name','=',\
                                         smartcontractname).smart_contract_address],\
                                         project.smart_contracts[('smart_contract_name','=',\
                                         smartcontractname).smart_contract_ABI] )



    def Get_info_external_storage(self, variablename, variablefunction): #needs name of get* function in https://github.com/DARFChainTeam/Angeles.VC-token-scrum-investing/contracts/admin/implementation/externalstorage.sol
        (external_storage_addr, external_storage_ABI) = self.Get_smart_contract_data(
            'admin/implementation/externalstorage')

        return self._invoke_smart_contract(self, external_storage_addr, external_storage_ABI, variablefunction).call({'record': variablename})



    def Set_info_external_storage(self, variablevalue, variablename, variablefunction): #needs name of set* function in https://github.com/DARFChainTeam/Angeles.VC-token-scrum-investing/contracts/admin/implementation/externalstorage.sol

        (external_storage_addr, external_storage_ABI) = \
                self.Get_smart_contract_data('admin/implementation/externalstorage')
        return self._invoke_smart_contract(self, external_storage_addr, external_storage_ABI,\
                                           variablefunction).call({'record': variablename,\
                                                                   'value': variablevalue}) #todo need to control types!


    def Create_project(self): #address Projecttokenaddr, bytes32 DFSProjectdescribe, bytes4 DFStype)
         # 0. why need checkrights? self.checkrights (project.project_token)

         # 1.transfer tokens to system

         # make page in DFS
        self.DFS_save (self, project.project_token)
        (smart_contract_function_addr, smart_contract_ABI ) = \
                self.Get_smart_contract_data ('scruminvest/project')
         # invoke create_project
        return self._Invoke_smart_contract(self, smart_contract_function_addr,\
                                    smart_contract_ABI, 'create_project').\
                                    call({'Projecttokenaddr': project.project_token,\
                                          'DFSProjectdescribe': project.DFS_Project_describe,\
                                          'DFStype':project.DFS_type    })


    def Change_project_info(self):
        return
    def  Finish_project  (self):
        return
    def Project_add_state(self):
        return

    def Project_get_state(self,project_token):
        return

    def Set_rights(self):
        return

    def Check_rights(self, token_address):


        return

    def DFS_save(self, token_address):

        DFS_addr = 0x0 #mockup
        return DFS_addr
# token management
#todo add token management to menu, views



