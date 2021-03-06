var template = riot.observable();
template.apiBaseUrl = global_baseUrl+'/api/templates';

template.sortByName =  function(a, b) 
{
    var aName = a.name.toLowerCase();
    var bName = b.name.toLowerCase(); 
    return ((aName < bName) ? -1 : ((aName > bName) ? 1 : 0));
}

//----------------
//API ------------
//----------------

template.getAll = function(page)
{
    $.ajax({ url: template.apiBaseUrl+'?page='+page, success: template.onGetAll});
}

template.refreshAll = function(page)
{
    $.ajax({ url: template.apiBaseUrl+'?page='+page, success: template.onRefreshAll});
}

template.delete = function(id)
{
    $.ajax({type: "DELETE", url: template.apiBaseUrl+'/'+id, success: template.onDelete});
}

template.add = function(params)
{
    $.ajax({type: "POST", url: template.apiBaseUrl+'/add', data: params, success: template.onAdd});
}

template.getThemes = function(id)
{
    $.ajax({ url: template.apiBaseUrl+'/'+id+'/themes', success: template.onGetThemes});
}

template.addTheme = function(id, params)
{
   $.ajax({type: "POST", url: template.apiBaseUrl+'/'+id+'/themes/add',  data: params, success: template.onAddTheme});
}

template.removeTheme = function(id, themeId)
{
    $.ajax({ type: "DELETE", url: template.apiBaseUrl+'/'+id+'/themes/'+themeId, success: template.onRemoveTheme});
}

//-----------------
//EVENTS ----------
//-----------------

template.onGetAll = function(json)
{
    template.trigger('template_getAll', json);
}

template.onRefreshAll = function(json)
{
    template.trigger('template_refreshAll', json);
}

template.onDelete = function(json)
{
    template.trigger('template_delete', json);
}

template.onAdd = function(json)
{
    template.trigger('template_add', json);
}

template.onGetThemes = function(json)
{
    template.trigger('template_themes', json);
}

template.onAddTheme = function(json)
{
    template.trigger('template_add_theme', json);
}

template.onRemoveTheme = function(json)
{
    template.trigger('template_remove_theme', json);
}