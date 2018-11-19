from openerp import models, fields, api




class UserStory(models.Model):
    
    _name = 'user.story'
    _inherit = ['mail.thread', 'mail.activity.mixin', 'portal.mixin']
    
    name = fields.Char(string="Name of story")
    project = fields.Many2one('project.project',string="Project")
    description = fields.Text(string="Description of story")
    partner_id = fields.Many2one('res.partner',string="Investor")
    stage_id = fields.Many2one('project.task.type',string="Stage")
    image = fields.Binary(string="Image",related="project.image")
    image_medium = fields.Binary(related="project.image_medium")
    image_small = fields.Binary(related="project.image_small")
    
    
    
   
    
    @api.one
    def write(self,values):
        values.update({'partner_id':self.env['res.users'].sudo().search([('id','=',self._context['uid'])]).partner_id.id})
        res = super(UserStory,self).write(values)
        return res
        
    @api.model
    def create(self,values):
        values.update({'partner_id':self.env['res.users'].sudo().search([('id','=',self._context['uid'])]).partner_id.id})
        res = super(UserStory,self).create(values)
        return res