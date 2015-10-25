var themes = riot.observable();
themes.apiBaseUrl = '/api/';

//----------------
//API ------------
//----------------

themes.getAll = function(page)
{
    $.ajax({ url: themes.apiBaseUrl+'themes?page='+page, success: themes.onGetAll});
}

themes.refreshAll = function(page)
{
    $.ajax({ url: themes.apiBaseUrl+'themes?page='+page, success: themes.onRefreshAll});
}

themes.add = function(params)
{
    $.ajax({type: "POST", url: api.apiBaseUrl+'themes/add', data: params, success: themes.onAdd});
}

themes.delete = function(id)
{
    $.ajax({type: "DELETE", url: api.apiBaseUrl+'themes/'+id, success: themes.onDelete});
}

themes.get = function(id)
{
    $.ajax({ url: themes.apiBaseUrl+'themes/'+id, success: themes.onGet});
}

themes.getQuestions = function(id)
{
    $.ajax({ url: themes.apiBaseUrl+'themes/'+id+'/questions', success: themes.onGetQuestions});
}

//-----------------
//EVENTS ----------
//-----------------

themes.onGetAll = function(json)
{
    themes.trigger('themes_getAll', json);
}

themes.onGet = function(json)
{
    themes.trigger('themes_get', json);
}

themes.onRefreshAll = function(json)
{
    themes.trigger('themes_refreshAll', json);
}

themes.onAdd = function(json)
{
    themes.trigger('themes_add', json);
}

themes.onDelete = function(json)
{
    themes.trigger('themes_delete', json);
}

themes.onGetQuestions = function(json)
{
    themes.trigger('themes_getQuestions', json);
}

themes.sortByName =  function(a, b) 
{
    var aName = a.name.toLowerCase();
    var bName = b.name.toLowerCase(); 
    return ((aName < bName) ? -1 : ((aName > bName) ? 1 : 0));
}