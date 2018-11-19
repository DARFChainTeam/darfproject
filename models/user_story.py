from openerp import models, fields, api




class UserStory(models.Model):
    
    _name = 'user.story'
    _inherit = ['mail.thread', 'mail.activity.mixin', 'portal.mixin']
    
    name = fields.Char(string="Name of story")
    project = fields.Many2one('project.project',string="Project")
    description = fields.Text(string="Description of story")
    partner_id = fields.Many2one('res.partner',string="Investor")
    stage_id = fields.Many2one('project.task.type',string="Stage")
    
   
    
    @api.one
    def write(self,values):
        values.update({'partner_id':self.env['res.users'].sudo().search([('id','=',1)]).partner_id.id})
        res = super(UserStory,self).write(values)
        return res
        
    @api.model
    def create(self,values):
        values.update({'partner_id':self.env['res.users'].search([('id','=',1)]).partner_id.id})
        res = super(UserStory,self).create(values)
        return res