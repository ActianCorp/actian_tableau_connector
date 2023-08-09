# Actian Tableau Connector Development Notes

Table of contents
-----------------

  * [Overview](#overview)
  * [Install required drivers](#install-drivers)
  * [Obtain Connector/install](#obtain-and-install-connector)
  * [Launch Tableau with new flags](#launch-tableau-with-new-flags)
  * [Notes](#notes)

### Overview

This is a Connector for Tableau created with the [connector-plugin-sdk](https://github.com/tableau/connector-plugin-sdk).

Starting point for building a connector: [Tableau Connector SDK](https://tableau.github.io/connector-plugin-sdk/docs/)  

#### Important note on building the connection dialog

- For Tableau 2020.3 and later, follow [Connection Dialog v2](https://tableau.github.io/connector-plugin-sdk/docs/mcd)  
- For Tableau versions prior to 2020.3, follow [Connection Dialog v1](https://tableau.github.io/connector-plugin-sdk/docs/ui.html)  


### Actian JDBC and ODBC Connectors - version 1.0.1 and prior

Recommended version of Tableau Desktop is 2019.4.2 (20194.20.0119.2058).

When running from source code (i.e. rather than from a built taco) 2019.2.2, 2019.2.3, as well as 2019.2 are known to also work.

### Install Drivers

See:

  * [readme for ODBC](actian_odbc/README.md) - *preferred* due to ODBC support being in Tableau for longer
  * [readme for JDBC](actian_jdbc/README.md)


### Obtain and Install Connector

Obtain Connectors source code, for example:

    git clone https://github.com/ActianCorp/actian_tableau_connector.git

Determine full path, for example, assuming Microsoft Windows.

    cd /d c:\
    git clone https://github.com/ActianCorp/actian_tableau_connector.git

Full path is:

    C:\actian_tableau_connector\

### Launch Tableau with new flags

**NOTE** when running from source code the `taco` files need to be removed, those take precedence in Tableau.

#### MacOS Tableau Desktop

See https://tableau.github.io/connector-plugin-sdk/docs/share

#### Windows Tableau Desktop

There are three main options for launching plugins.

  1. Runtime mode, from taco file, optionally using `-DConnectPluginsPath` (if omitted default path `"%USERPROFILE%\Documents\My Tableau Repository\Connectors"` is used). Performs code signing check.
  2. Unsigned runtime mode, from taco file, using `-DDisableVerifyConnectorPluginSignature=true`. Optionally using `-DConnectPluginsPath` (if omitted default path used).
  3. Dev mode, from source code, using `-DConnectPluginsPath` flag.

Examples to Launch Tableau via command line (or create/update shortcut) to:

    "C:\Program Files\Tableau\Tableau 2019.4\bin\tableau.exe" -DConnectPluginsPath=%CD%
    "C:\Program Files\Tableau\Tableau 2019.4\bin\tableau.exe" -DDisableVerifyConnectorPluginSignature=true
    "C:\Program Files\Tableau\Tableau 2019.2\bin\tableau.exe" -DConnectPluginsPath=C:\actian_tableau_connector\

Where `C:\Program Files\Tableau\Tableau 2019.2`, etc. is the location where Tableau was installed.

**NOTE** when running from source code the `taco` files need to be removed, those take precedence in Tableau.

#### Tableau Server

See https://tableau.github.io/connector-plugin-sdk/docs/run-taco




Notes
-----


### Running tests

#### Loading data

If running test suite, see [data loading readme](https://github.com/clach04/connector-plugin-sdk/tree/actian/tests/datasets/TestV1/actian/README.md).

### Object name case

For running the test suite, Tableau expects the non-default mixed case. This will not be needed for https://github.com/tableau/connector-plugin-sdk/issues/216 (`CAP_ODBC_BIND_DETECT_ALIAS_CASE_FOLDING`)

If your object name case is all lower case (which is the default for Actian Avalanche/Vector/ActianX/Ingres) mixed case option is **not** required.

I.e. mixed case is required if running Tableau Connector SDK tests suite.

See https://github.com/clach04/connector-plugin-sdk/tree/actian/tests/datasets/TestV1/actian for scripts to create and load database for testing.

Create database with mixed case object name support:

    iigetres ii.`iipmhost`.createdb.delim_id_case
    iisetres ii.`iipmhost`.createdb.delim_id_case mixed
    createdb mixedcase
    # optionally restore:
    iisetres ii.`iipmhost`.createdb.delim_id_case lower

### Debugging errors

Error dialogs from Tab often don't have much content. More detailed logs go to the "Logs" directory and is created on each start up. E.g. under Windows `"%USERPROFILE%\Documents\My Tableau Repository\Logs"`.

Delete or rename the existing logs directory, re-start/run and then look in the logs directory. Specifically look for `log.txt` which is a json file and can be read with https://github.com/tableau/tableau-log-viewer/
