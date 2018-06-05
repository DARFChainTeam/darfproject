from openerp import models, fields, api


class CustomerInvestment(models.Model):
    
    _inherit = 'res.partner'
    
    investment_list = fields.One2many('customer.investment.list','customer_id',string="Customer's investment")

class CustomerInvestmentList(models.Model):
    
    _name = 'customer.investment.list'
    
    project_of_invest = fields.Many2one('project.project')
    customer_id = fields.Many2one('res.partner')
    project_customer_token_amount = fields.Float(string="Amount of tokens")
    