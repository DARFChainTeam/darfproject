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