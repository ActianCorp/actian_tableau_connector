(function dsbuilder(attr)
{
    var params = {};

    if (attr["server"].toLowerCase() == "(local)")  // TODO localhost, etc. check
    {
        params["SERVER"] = "(local)";
        // local connection, no auth specified
        // port is ignored
    }
    else
    {
        // TODO try using HostName and ListenAddress named params instead of single SERVER
        // this would allow overrides - Tableau may not support this though :-(
        params["SERVER"] = '@' + attr["server"] + ',' + attr["port"]; // NOTE implicit tcp_ip protocol
        params["UID"] = attr["username"];
        params["PWD"] = attr["password"];
    }
    params["DATABASE"] = attr["dbname"];
    var slash_index = params["DATABASE"].search('/');
    if (slash_index >= 0)
    {
        params["ServerType"] = params["DATABASE"].slice(slash_index + 1);  // determine server class (skip slash)
        params["DATABASE"] = params["DATABASE"].slice(0, slash_index);  // strip class, leaving only database name
    }


    // support any ODBC connection attribute
    // specify as OPTION=VALUE;OPTION2=VALUE2
    var tmp_input = attr[connectionHelper.attributeVendor1].trim()
    if (tmp_input)
    {
        // trim() maybe overkill, better safe than sorry
        var tmp_list = tmp_input.split(';');
        for (var key in tmp_list)
        {
            var tmp_str_pair = tmp_list[key].trim();
            if (tmp_str_pair)
            {
                var key_value_list = tmp_str_pair.trim().split('=');
                params[key_value_list[0].trim()] = key_value_list[1].trim();
            }
        }
    }

    var formattedParams = [];

    formattedParams.push(connectionHelper.formatKeyValuePair(driverLocator.keywordDriver, driverLocator.locateDriver(attr)));

    for (var key in params)
    {
        formattedParams.push(connectionHelper.formatKeyValuePair(key, params[key]));
    }

    return formattedParams;
})
