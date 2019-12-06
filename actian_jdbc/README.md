Actian JDBC Connector for Tableau
=================================

Latest version available at [GitHub](https://github.com/clach04/actian_tableau_connector).

Table of contents
-----------------

  * [Usage](#usage)
    + [Install JDBC driver jar file](#install-jdbc-driver-jar-file)
    + [Obtain Connector/install](#obtain-connector-install)
    + [Launch Tableau with new flags](#launch-tableau-with-new-flags)


Usage
-----

### Install JDBC driver jar file

Install JDBC jar file, Tableau instructions for this are located at [Tableau Drivers](https://onlinehelp.tableau.com/current/pro/desktop/en-us/examples_otherdatabases_jdbc.htm).

Obtain iijdbc.jar and copy into `C:\Program Files\Tableau\Drivers`

iijdbc.jar can either be downloaded from [ESD](https://esd.actian.com/product/Avalanche/JDBC/java/Actian_Avalanche_JDBC_Drivers)
or obtained from a client installation from:

  * `%II_SYSTEM%\ingres\lib\iijdbc.jar` - Windows
  * `$II_SYSTEM/ingres/lib/iijdbc.jar` - Linux/Unix
