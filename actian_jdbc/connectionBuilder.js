(function dsbuilder(attr)
{
    var urlBuilder = "jdbc:ingres://" + attr[connectionHelper.attributeServer] + ":" + attr[connectionHelper.attributePort] + "/" + attr[connectionHelper.attributeDatabase] + ";";

    return [urlBuilder];
})
