//--------------
//ROUTER -------
//--------------

function router(collections, action, id)
{
    var selector = document.getElementById('app_content');
    var basePageTitle = 'Evaluat0r - ';
    var pageTitle = '';

    switch(collections)
    {
        case 'themes':
            pageTitle += 'Thèmes';
            
            switch(action)
            {
                case 'edit':
                    if(!id)
                        riot.route('themes/all/1'); 
                    else 
                    {
                        pageTitle += ' : Géstion des questions';
                        riot.mount(selector, 'themes_edit', {'theme': theme, 'question': question, 'page': {id:id} });
                    }
                break;
                
                case 'delete': break;
                case 'add': break;
                
                default:
                case 'all':
                     if(!id) id = 1;
                     riot.mount(selector, 'themes', {'theme' : theme, 'page' : { id : id}});
                    break;
            }
            break;
            
        case 'templates':
            pageTitle += 'Modèles';
        
            switch(action)
            {
                default:
                case 'all':  
                    if(!id) id = 1;
                    riot.mount(selector, 'templates', {'template': template, 'page':{id:id}});
                break;   
            }
            break;
        
        case 'sessions':
            pageTitle += 'Session';
        
            switch(action)
            {
                default:
                case 'all':  
                    if(!id) id = 1;
                    riot.mount(selector, 'sessions');
                break;   
            }
            break;
        
        default: 
            pageTitle += 'Accueil';
            riot.mount(selector, 'home', auth);
        break;
    }
    
    document.title =  basePageTitle + pageTitle;
};

riot.route(router);
riot.route.exec(router);
