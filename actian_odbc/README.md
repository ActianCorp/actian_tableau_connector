Actian ODBC Connector for Tableau
=================================

Latest version available at [GitHub](https://github.com/ActianCorp/actian_tableau_connector).

Table of contents
-----------------

  * [Usage](#usage)
    + [Install ODBC driver](#install-odbc-driver)
    + [Obtain Connector](#obtain-connector)
    + [Launch Tableau with new flags](#launch-tableau-with-new-flags)
    + [Notes](#notes)


Usage
-----

### Install ODBC driver

Install ODBC Driver from [ESD](https://esd.actian.com/product/Actian_Data_Platform/Client_Runtime)

NOTE Tableau Desktop is a 64-bit product, it requires a 64-Bit ODBC Driver client installation.


### Obtain Connector

Download taco from files https://github.com/ActianCorp/actian_tableau_connector/releases/ and copy into:

  * For Microsoft Windows `"%USERPROFILE%\Documents\My Tableau Repository\Connectors"`


### Launch Tableau

Launch Tableau:
 * Choose "Connect To a Server"
 * Click "More..."
 * Select "Actian ODBC by Actian"
 * Fill in "Server" and other fields, using information from your DBA
     * "Options" field takes ODBC Connection String Keywords, see https://docs.actian.com/avalanche/index.html#page/Connectivity/Connection_String_Keywords.htm
       Example below:
       
           SELECTLOOPS=Y;NUMERIC_ OVERFLOW=IGNORE
