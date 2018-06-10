from openerp import models, fields, api


class ProjectInvestingInformation(models.Model):
    
    _inherit = 'project.project'
    
    project_token = fields.Char(string="Project token address")
    project_token_name = fields.Char(string="Token name")
    token_amount = fields.Float(string="Token Amount")
    description = fields.Text(string="Desctiprion")
    image = fields.Binary(string="Image ICO")
    image_medium = fields.Binary()
    image_small = fields.Binary()
    project_address = fields.Char(string="Address for token seling")
    exchange_rate = fields.Float(string="Exchange Rate")
    open_close_for_investment = fields.Boolean()
    forms_of_investment = fields.Selection([('ICO','ico'),('DAICO','daico')],string="Forms of investment")
    exchange_price = fields.Float(string="Exchange price")
    investment_condition = fields.Text(string="Investment condition")
    buy_back_address = fields.Char(string="Buy back address") 
    abi_buy_back = fields.Char(string="ABI smart contract") 
    crowd_sale_abi = fields.Char(string="ABI crowd sale contract") 
    #addition fields for project card
    term_and_condition = fields.Text(string="Term & Condition")
    round_of_investment = fields.One2many('round.investment','project_id',string="Rounds of investment")
    tokens_price = fields.Float(string="Token's Price")
    project_team = fields.One2many('project.team','project_id',string="Project Team")
    #passport of project
    #market
    market_size = fields.Float(string="Market size")
    cagr = fields.Float(string="Compound Annual Growth Rate (CAGR)")
    planned_share_market = fields.Float(string="Planned share of the market")
    market = fields.Text(string="Market")
    #Technology
    technology = fields.Text(string="Technology")
    #finance
    total_investment = fields.Float(string="Total investment")
    finance_description = fields.Text(string="Description")
    #Legal issues
    legal_issues = fields.Text(string="Legal Issues")
    


class ProjectTeam(models.Model):
    
    _name='project.team'
    
    project_id = fields.Many2one('project.project')
    team_mamber = fields.Many2one('res.partner',string="Team mamber")


class RoundInvestment(models.Model):
    
    _name = 'round.investment'
    
    project_id = fields.Many2one('project.project')
    start_date = fields.Date(string="Start round of investing") 
    end_date = fields.Date(string="End round of investing")
    min_amount = fields.Float(string="Minimal amount")
    max_amount = fields.Float(string="Max amount")