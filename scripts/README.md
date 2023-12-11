## Setup notes for machine that executes the script (Linux example)
Create new user.
Create directory: `$HOME/tableau/scripts`  
Place script package_sign_tacos.sh into the `$HOME/tableau/scripts` directory  
Create the Jenkins workspace root directory (e.g. `/var/lib/jenkins`) and give read/write/execute permission to the user.  
Configure the node in Jenkins.  
Command line packages required by the script: jdk, git, unzip, smctl  

## Jenkins Node Configuration

**Remote root directory** - Match location on machine. e.g. `/var/lib/jenkins`  
**Usage** - `Use this node as much as possible`  
**Launch method** - `Launch agents via SSH`  
**Host** - Machine name  
**Credentials** - Will need to create Jenkins credentials matching the user where the script is located.  
**Host Key Verification Strategy** - `Non verifying Verification Strategy`  

## Example Jenkins project configuration

### Section: General

**Parameter**  
 - Type: Label
 - Name: `NODE`
 - Default Value: (host name where script exists)
 - Important

**Parameter**  
 - Type: String Parameter
 - Name: `SCRIPT_PATH`
 - Default Value: `$HOME/tableau/scripts`

**Parameter**  
 - Type: String Parameter
 - Name: `BRANCH`
 - Default Value: (blank)

**Check box:** Restrict where this project can be run (checked)
 - Label Expression: host name

### Section: Build Environment

Check box: Set Build Name (checked)
 - Build Name: `${BUILD_NUMBER}_ACTIAN_TABLEAU_CONNECTOR`

### Section: Build

**Execute shell** - Command  

     bash  
     cd $SCRIPT_PATH  
     $SCRIPT_PATH/package_sign_tacos.sh ${BUILD_NUMBER} ${WORKSPACE} ${BRANCH}  
     if [ $? -eq 0 ]  
     then  
       echo "Packaging and signing operations completed. Check outcome."  
     else  
       exit 3  
     fi  

### Section: Post-build Actions

#### Archive the artifacts  

**Files to archive**  `actian*.taco.build_${BUILD_NUMBER}`

#### Attach Build Log

     Attach Build Log

The script `package_sign_tacos.sh` has been tested on Ubuntu release 20.04 with OpenJDK 1.8.0_392.
