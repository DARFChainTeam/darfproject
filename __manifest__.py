{
    'name': "Darf Project",
    'version': '1.0',
    'depends': ['base',
                'portal',
                'account',
],
    'author': "Sergey Stepanets",
    'category': 'Application',
    'description': """
    Module that realize projects estimation and project registration 
    """,
    'data': [
     'views/project_estimate.xml',
     'views/scoring_setting_item.xml',
     'views/project_project.xml',
     'views/customer_invest.xml',
     'views/web/project_registration.xml',
    ],
}