# -*- coding: utf-8 -*-
# Part of Odoo. See LICENSE file for full copyright and licensing details.

import base64
import datetime
from odoo import http, _
from odoo.exceptions import AccessError
from odoo.http import request
from odoo.tools import consteq
from odoo.addons.portal.controllers.mail import _message_post_helper
from odoo.addons.portal.controllers.portal import CustomerPortal, pager as portal_pager, get_records_pager
from ast import literal_eval


class CustomerPortal(CustomerPortal):

    def _prepare_portal_layout_values(self):
        values = super(CustomerPortal, self)._prepare_portal_layout_values()
        partner = request.env.user.partner_id
        projects = request.env['customer.investment.list'].search([('customer_id','=',partner.id)])
        print(projects)
        projects_customer_list = []
        if projects:
            for project_item in projects.sudo().search([]):
                project_item_dic = {}
                project_item_dic.update({'project_name':project_item.project_of_invest.name,
                                        'project_token_name':project_item.project_of_invest.project_token_name,
                                        'token_amount':project_item.project_of_invest.token_amount,
                                        'project_token_amount':project_item.project_customer_token_amount,
                                        'id':project_item.project_of_invest.id,})
                projects_customer_list.append(project_item_dic)
        else:
            project_item_dic = {}
        print(projects_customer_list)
        values.update({
            'projects': projects_customer_list,
        })
        return values
    
    
    @http.route(['/my/home/project/<int:project>'], type='http', auth="user", website=True)
    def project_page(self, project, **kw):
        project = request.env['project.project'].browse([project])
        project_sudo= project.sudo()
        partner = request.env.user.partner_id
        return request.render("darfproject.project_page", {
            'project': project_sudo,
        })

    @http.route(['/my/home/projectsboard'], type='http', auth="user", website=True)
    def project_board(self, **kw):
        project = request.env['project.project'].search([])
        project_sudo= project.sudo()
        partner = request.env.user.partner_id
        print(project_sudo)
        return request.render("darfproject.projects_board", {
            'projects': project_sudo,
        })

    @http.route(['/my/home/invest/<int:project>'], type='http', auth="user", website=True)
    def project_invest(self, project, **kw):
        project = request.env['project.project'].browse([project])
        project_sudo= project.sudo()
        partner = request.env.user.partner_id
        print(project_sudo)
        return request.render("darfproject.project_invest", {
            'project': project_sudo,
        })

    @http.route(['/my/home/setting'], type='http', auth="user", website=True)
    def customer_setting(self,  **kw):
        partner = request.env.user.partner_id
        print(partner)
        return request.render("darfproject.customer_setting", {
            'customer': partner,
        })

    @http.route(['/web/condition'], type='json', auth="user", website=True)
    def buy_condition(self, project_id,token_value, **kw):
        partner = request.env.user.partner_id
        print(project_id, token_value)
        return True

    @http.route(['/web/buytoken'], type='json', auth="user", website=True)
    def buy_tokens(self, project_id,accept,token_value, **kw):
        partner = request.env.user.partner_id
        print(project_id, token_value,'test accept', accept,'partner_id:',partner.id)
        project_id = int(project_id)
        get_list = request.env['customer.investment.list'].search([('customer_id','=',partner.id),('project_of_invest','=',project_id)])
        if get_list:
            print(get_list)
            token_value = get_list.project_customer_token_amount + int(token_value)
            get_list.write({'project_customer_token_amount':token_value})
        else:
            dict_for_write = {'project_of_invest':project_id,
                              'project_customer_token_amount':token_value}
            print(dict_for_write)
            partner.write({'investment_list':[(0,0,dict_for_write)]})
        return True

    @http.route(['/my/home/condition/<int:project_id>/<int:token_value>'], type='http', auth="user", website=True)
    def buy_condition_page(self, project_id,token_value,  **kw):
        partner = request.env.user.partner_id
        project = request.env['project.project'].browse([project_id])
        return request.render("darfproject.term_and_condition", {
            'project': project,
            'token_value':token_value,
                        })
