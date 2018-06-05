from openerp import models, fields, api


class CustomerInvestment(models.Model):
    
    _inherit = 'res.partner'
    
    investment_list = fields.One2many('customer.investment.list','customer_id',string="Customer's investment")
    ethereum_address = fields.Char(string="Ethereum address")
    bitcoin_address = fields.Char(string="Bitcoin address")

class CustomerInvestmentList(models.Model):
    
    _name = 'customer.investment.list'
    
    project_of_invest = fields.Many2one('project.project')
    customer_id = fields.Many2one('res.partner')
    project_customer_token_amount = fields.Float(string="Amount of tokens")
    