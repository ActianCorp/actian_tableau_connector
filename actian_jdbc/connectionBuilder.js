(function dsbuilder(attr)
{
    var urlBuilder = null;

    if (attr["server"].toLowerCase() == "(local)")  // match ODBC implementation, even though JDBC driver does not understand (local)
    {
        urlBuilder = "jdbc:ingres://" + "localhost:" + attr[connectionHelper.attributePort] + "/" + attr[connectionHelper.attributeDatabase] + ";";
    }
    else
    {
        urlBuilder = "jdbc:ingres://" + attr[connectionHelper.attributeServer] + ":" + attr[connectionHelper.attributePort] + "/" + attr[connectionHelper.attributeDatabase] + ";";
    }

    return [urlBuilder];
})
