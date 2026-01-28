# Actian Tableau Connector

Tableau connector (aka taco) for Actian Data Platform, Vector, and Ingres.

Install from https://extensiongallery.tableau.com/connectors

Development versions available from [GitHub](https://github.com/ActianCorp/actian_tableau_connector).
  * [JDBC](https://extensiongallery.tableau.com/products/936) - recommended
  * [ODBC](https://extensiongallery.tableau.com/products/167)

Tabloids builds are handled in:

  * https://github.com/Tabloids/Actian-Connector_JDBC
  * https://github.com/Tabloids/Actian-Connector_ODBC

Minimum recommend version of Tableau is 2019.4 (for earlier versions see development notes see [README_DEV.md](README_DEV.md)).


## Installation Instructions

Ensure using minimum version of Tableau Desktop 2019.4.2, 20194.20.0119.2058
available from https://www.tableau.com/support/releases/desktop/2019.4.2 is installed.


Download taco from files https://github.com/ActianCorp/actian_tableau_connector/releases/latest and copy into  `My Tableau Repository`(see https://kb.tableau.com/articles/howto/changing-the-my-tableau-repository-location):

  * For Microsoft Windows `My Tableau Repository` typically located in `My Documents`.
    For example, `"%USERPROFILE%\Documents\My Tableau Repository\Connectors"`
  * For Apple MacOS X `My Tableau Repository` typically located in `Documents` of user.
    For example, `/Users/your_user/Documents/My Tableau Repository/Connectors` where
    `your_user` is your username

NOTE problems have been seen when using tools like OneDrive, GDrive, etc. to host the taco files.

See:

  * [readme for JDBC](actian_jdbc/README.md) - *preferred*
  * [readme for ODBC](actian_odbc/README.md)

## Problems

For bugs open an issue https://github.com/ActianCorp/actian_tableau_connector/issues

For further help contact support case at https://supportservices.actian.com/support-services/support

### Error Package signature verification failed during connection creation

Error text:

    Unexpected Error
    There was a problem while running the connector plugin. Reinstall the plugin or contact the plugin provider.
    Note that you might need to make local configuration changes to resolve the error.
    Error Code: 14D18B1F
    Package signature verification failed during connection creation.

This is likely due to due to Tableau bug https://github.com/tableau/connector-plugin-sdk/issues/401
ideal solution is to install latest patch (or a later version). Workaround is to launch Tableau with the allow unsigned property/flag `DisableVerifyConnectorPluginSignature` set to true.

Windows

    "C:\Program Files\Tableau\Tableau 2019.4\bin\tableau.exe" -DDisableVerifyConnectorPluginSignature=true

Apple Mac OS X

    /Applications/Tableau\ Desktop\ 2022.4.app/Contents/MacOS/Tableau -DDisableVerifyConnectorPluginSignature=true

NOTE path is version specific

## Development

For development notes see [README_DEV.md](README_DEV.md).
