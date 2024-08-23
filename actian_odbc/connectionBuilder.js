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
        if (attr["password"] != "")
        {
            params["PWD"] = attr["password"];
        }
    }
    params["DATABASE"] = attr["dbname"];
    var slash_index = params["DATABASE"].search('/');
    if (slash_index >= 0)
    {
        params["ServerType"] = params["DATABASE"].slice(slash_index + 1);  // determine server class (skip slash)
        params["DATABASE"] = params["DATABASE"].slice(0, slash_index);  // strip class, leaving only database name
    }

    if (attr["driver"] !== "")
    {
        params["DRIVER"] = attr["driver"];
    }

    if (attr["auth_type"] != "native" && attr["auth_server"] != "")
    {
        params["AUTH_TYPE"] = attr["auth_type"];
        params["AUTH_SERVER"] = attr["auth_server"];
    }

    var formattedParams = [];

    formattedParams.push(connectionHelper.formatKeyValuePair(driverLocator.keywordDriver, driverLocator.locateDriver(attr)));

    for (var key in params)
    {
        formattedParams.push(connectionHelper.formatKeyValuePair(key, params[key]));
    }

    return formattedParams;
})
