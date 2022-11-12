#!/bin/bash
#Purpose:This script prompts users to delete a file or directory
#Website: Toluxtrucks.com
#Created Date: Sun Nov 6 00:22:13 EDT 2022
#Author: Tolulope Gbadamosi

PRACTISEDIR="/Users/dc/bash_project/sample_backup"
SRC=$1
DEST=$2
RUNNER=$3
BACKUP_TYPE=$4
TS=`date +%m%d%y%H%M%S`

if [[ $4 == "f" ]]
then
    BACKUP_TYPE="FILE"
else   
    BACKUP_TYPE="DIRECTORY"
fi

#Creating the log Directory
LOG_DIR=${PRACTISEDIR}/${DEST}/${RUNNER}/${BACKUP_TYPE}/log/${TS}
mkdir -p ${LOG_DIR}
LOG_FILE=${PRACTISEDIR}/${DEST}/${RUNNER}/${BACKUP_TYPE}/log/${TS}/control_script.log
touch ${LOG_FILE}

echo "Starting the script at ${TS}" >>${LOG_FILE}

FINAL_BK_LOC="${PRACTISEDIR}/${DEST}/${RUNNER}/${BACKUP_TYPE}/${TS}"


if [[ $# -ne 4 ]]
then
    echo "Required command line arugument incomplete">>${LOG_FILE}
    echo "The first command line argumnent should be: 'SOURCE FILE OR DIRECTORY'
          The second command line argumnent should be: 'DESTINATION DIRECTORY'
          The third command line argumnent should be: 'RUNNER(Your name)'">>${LOG_FILE}
    exit
else
    # Creating a new directory called myfirstdir
    echo "Starting control script">>${LOG_FILE}
    if [[ -d ${FINAL_BK_LOC} ]]
    then
        echo "Directory Exists">>${LOG_FILE}
        exit
    else
        echo "Directory does not exist, creating new Directory: ${FINAL_BK_LOC}">>${LOG_FILE}
         mkdir -p ${FINAL_BK_LOC}
        if [[ $? -ne 0 ]]
        then
            echo "Creation of ${FINAL_BK_LOC} failed">>${LOG_FILE}
            exit
        else
            echo "Directory creation successful">>${LOG_FILE}
        fi

    fi
    # Copying source file into destination directory
    echo "Copying ${SRC} to ${FINAL_BK_LOC}">>${LOG_FILE}
    cp -r ${SRC} ${FINAL_BK_LOC}
    if [[ $? -ne 0 ]]
    then
        echo "The copy command failed">>${LOG_FILE}
        exit
    else
        echo "The file was copied successfully">>${LOG_FILE}
    fi

fi

##Delete a file from a directory 
read -p "Which Directory would you like to delete from: " DDIR

if [[ -d ${DDIR} ]]
then
    options=`ls ${DDIR}`

    PS3="Please select file or directory to delete: "

    select options in ${options}
    do 
    echo "You have selected to delete:  '${options}'">>${LOG_FILE}
    read -p "Are you sure you want to remove the file or directory '${options}' : " ANS
    if [[ $ANS == 'Y' || $ANS == 'y' || $ANS == 'yes' || $ANS == "YES" ]]
    then
        echo "Removing ${options}">>${LOG_FILE}
        rm -rf ${options}
        echo "The remaining files in the directory are: ">>${LOG_FILE}
        ls  ${DDIR}|nl -s '] ' >>${LOG_FILE}
    elif [[ $ANS == 'N' || $ANS == 'n' || $ANS == 'no' || $ANS == "NO" ]]
    then
        echo "File or directory deletion cancelled">>${LOG_FILE}
    else
        echo "Invalid Option">>${LOG_FILE}
    fi
    exit
    done
else
   echo "Specified directory does not exist">>${LOG_FILE}
   exit
fi





TS=`date +%m%d%y%H%M%S`
echo "Ending the script at ${TS}">>${LOG_FILE}