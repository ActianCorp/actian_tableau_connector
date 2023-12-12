# Script for packaging and signing Actian Tableau connectors
#
# Parameters passed to script:
#   1) Build number (required)
#   2) Jenkins Workspace (required)
#   3) Branch name (optional)
#
# Requirements prior to running script:
#   - Digicert Software Trust Manager is installed and configured.
#   - The command "smctl healthcheck" runs successfully, reporting:
#     - A valid signer certificate is available.
#     - The user has the privilege to sign.
#

# Set repository variables
TABSDKREPO=https://github.com/tableau/connector-plugin-sdk.git
ACTIANREPO=https://github.com/ActianCorp/actian_tableau_connector.git

# Set directory variables
BASEDIR=$HOME/tableau
TACODIR=$BASEDIR/tacos
LOGDIR=$BASEDIR/logs
SCRIPTDIR=$BASEDIR/scripts
GITHUBDIR=$BASEDIR/github
ACTIANDIR=$GITHUBDIR/actian_tableau_connector
JDBCDIR=$ACTIANDIR/actian_jdbc
ODBCDIR=$ACTIANDIR/actian_odbc
TABSDKDIR=$GITHUBDIR/connector-plugin-sdk
PKGRDIR=$GITHUBDIR/connector-plugin-sdk/connector-packager

# Set environment variables needed for accessing certificate
export SM_HOST=https://clientauth.one.digicert.com
export SM_CLIENT_CERT_FILE=/usr/local/digicert/certs/Certificate_pkcs12.p12

# Verify that build number was passed in
if [ -z $1 ]; then
   echo Missing build number parameter
   exit 1
fi

BUILD=$1

# Verify that Jenkins workspace directorywas passed in
if [ -z $2 ]; then
   echo Missing workspace directory parameter
   exit 1
fi

WKSP=$JENKINS_HOME/$2
echo Using Jenkins workspace: $WKSP

# Check if branch name was passed
if [ $3 ]; then
   BRANCH="-b $3"
fi
echo DEBUG BRANCH=$BRANCH

# Check for jarsigner command
if [ -z $(which jarsigner) ]; then
   echo jarsigner not found
   exit 1
fi

# Ensure subdirectories exist
if [ ! -d "$TACODIR" ]; then
  mkdir -p $TACODIR/unsigned
fi
if [ ! -d "$LOGDIR" ]; then
  mkdir $LOGDIR
fi

TS=$(date +"%Y%b%d-%H%M%S")

# Log parameters passed to script
echo $TS  $BUILD  $WKSP >> $LOGDIR/builds.log

cd $BASEDIR

# Create Python vitual environment (tested with Python 3.8.10)
python3 -m venv .venv
. ./.venv/bin/activate

# Clone repositories#
rm -rf $GITHUBDIR/*
git clone $BRANCH $ACTIANREPO $ACTIANDIR
git clone $TABSDKREPO $TABSDKDIR

# Get version from manifest.xml
VERJDBC=$(grep plugin-version $JDBCDIR/manifest.xml  | cut -d '=' -f4 | cut -d "'" -f2)
VERODBC=$(grep plugin-version $ODBCDIR/manifest.xml  | cut -d '=' -f4 | cut -d "'" -f2)

# Set taco file names
JDBC_TACO=actian_jdbc-v$VERJDBC.taco
ODBC_TACO=actian_odbc-v$VERODBC.taco
JDBC_TACO_FINAL=$JDBC_TACO.build_$BUILD
ODBC_TACO_FINAL=$ODBC_TACO.build_$BUILD

# Package tacos
cd $TABSDKDIR/connector-packager
python setup.py install
python -m connector_packager.package $JDBCDIR  --dest $TACODIR -l $LOGDIR
mv $LOGDIR/packaging_logs.txt $LOGDIR/packaging_logs_jdbc_build_$BUILD.txt
python -m connector_packager.package $ODBCDIR  --dest $TACODIR -l $LOGDIR
mv $LOGDIR/packaging_logs.txt $LOGDIR/packaging_logs_odbc_build_$BUILD.txt

cd $BASEDIR

#Sign tacos
jarsigner -keystore NONE -storepass NONE -storetype PKCS11 -sigalg SHA256withRSA -providerClass sun.security.pkcs11.SunPKCS11 -providerArg /usr/local/digicert/bin/pkcs11properties.cfg -signedjar $TACODIR/$JDBC_TACO_FINAL -sigfile Actian -tsa http://timestamp.digicert.com $TACODIR/$JDBC_TACO vector_oct_2023_2026
jarsigner -keystore NONE -storepass NONE -storetype PKCS11 -sigalg SHA256withRSA -providerClass sun.security.pkcs11.SunPKCS11 -providerArg /usr/local/digicert/bin/pkcs11properties.cfg -signedjar $TACODIR/$ODBC_TACO_FINAL -sigfile Actian -tsa http://timestamp.digicert.com $TACODIR/$ODBC_TACO vector_oct_2023_2026

# Keep unsigned taco files and logs
mv $TACODIR/$JDBC_TACO $TACODIR/unsigned/$JDBC_TACO.UNSIGNED.$BUILD
mv $TACODIR/$ODBC_TACO $TACODIR/unsigned/$ODBC_TACO.UNSIGNED.$BUILD

# Report final taco files
echo
echo Signed Taco Files on $(hostname):
echo $TACODIR/$JDBC_TACO_FINAL
echo $TACODIR/$ODBC_TACO_FINAL
echo

cp $TACODIR/$JDBC_TACO_FINAL $WKSP/
cp $TACODIR/$ODBC_TACO_FINAL $WKSP/

# Report certificate timestamps and taco version from manifest.xml
echo ==========  Taco versions and timestamps  ==========
echo JDBC Taco: $JDBC_TACO_FINAL
echo Version $VERJDBC
jarsigner -verbose -verify $TACODIR/$JDBC_TACO_FINAL | grep expire
echo ----------------------------------------------------
echo ODBC Taco: $ODBC_TACO_FINAL
echo Version $VERODBC
jarsigner -verbose -verify $TACODIR/$ODBC_TACO_FINAL | grep expire
echo ====================================================
echo

