# Actian Tableau Connector

Tableau connector (aka taco) for Actian Avalanche, Vector, and Ingres.

Latest version available at [GitHub](https://github.com/clach04/actian_tableau_connector).

Minimum recommend version of Tableau is 2019.4 (for earlier versions see development notes see [README_DEV.md](README_DEV.md)).

See:

  * [readme for ODBC](actian_odbc/README.md) - *preferred*
  * [readme for JDBC](actian_jdbc/README.md)


## Installation Instructions

Copy taco from files https://github.com/clach04/actian_tableau_connector/releases/tag/unsigned_initial into:

  * For Microsoft Windows `"%USERPROFILE%\Documents\My Tableau Repository\Connectors"`
 
**NOTE** for unsigned early access versions need to launch Tableau with unsigned flag:

    "C:\Program Files\Tableau\Tableau 2019.4\bin\tableau.exe" -DDisableVerifyConnectorPluginSignature=true

For development notes see [README_DEV.md](README_DEV.md).
