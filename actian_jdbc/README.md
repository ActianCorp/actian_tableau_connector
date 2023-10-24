Actian JDBC Connector for Tableau
=================================

Latest version available at [GitHub](https://github.com/ActianCorp/actian_tableau_connector).

Table of contents
-----------------

  * [Usage](#usage)
    + [Install JDBC driver jar file](#install-jdbc-driver-jar-file)
    + [Obtain Connector](#obtain-connector)
    + [Launch Tableau](#launch-tableau)


Usage
-----

### Install JDBC driver jar file

Install JDBC jar file, Tableau instructions for this are located at [Tableau Drivers](https://onlinehelp.tableau.com/current/pro/desktop/en-us/examples_otherdatabases_jdbc.htm).

Obtain iijdbc.jar and copy into `C:\Program Files\Tableau\Drivers`

iijdbc.jar can either be downloaded from [ESD](https://esd.actian.com/product/Actian_Data_Platform/JDBC/java/Actian_Data_Platform_JDBC_Drivers)
or obtained from a client installation from:

  * `%II_SYSTEM%\ingres\lib\iijdbc.jar` - Windows
  * `$II_SYSTEM/ingres/lib/iijdbc.jar` - Linux/Unix


### Obtain Connector

Download taco from files https://github.com/ActianCorp/actian_tableau_connector/releases/ and copy into:

  * For Microsoft Windows `"%USERPROFILE%\Documents\My Tableau Repository\Connectors"`
  * For Apple Mac `/Users/your_user/Documents/My Tableau Repository/Connectors`


### Launch Tableau

Launch Tableau:
 * Choose "Connect To a Server"
 * Click "More..."
 * Select "Actian JDBC by Actian"
 * Fill in "Server" and other fields, using information from your DBA
