# Copyright (c) 2015, Oracle Engineered Systems Team
#
#    NAME
#      zdlra.sh -  ZDLRA Monitroing Script
#
#    DESCRIPTION
#
#    NOTES
#      <other useful comments, qualifications, etc.>
#
#    MODIFIED   (MM/DD/YY)
#    dongwkim    10/01/15 - Creation
#    dongwkim    01/03/16 - List Replication backup
#    dongwkim    01/03/16 - Add backup result menu
#    dongwkim    01/08/16 - List Tape backup
#    dongwkim    01/20/16 - Get registered db list by rasys.db table
#    dongwkim    01/20/16 - List 'DB FULL' in backup result menu
#    dongwkim    03/03/16 - Add backup result summary : List last backup per database
#    dongwkim    03/03/16 - Add Queue Status : Menu
#    dongwkim    03/22/16 - Create advanced menu
#    dongwkim    04/10/16 - use TNS for connection
#    dongwkim    04/11/16 - Encrypt RASYS password
#    Umesh Tanna   14/07/16 - Added option to show help
#    Umesh Tanna   14/07/16 - Added option 3.3 in advance mode
#    Umesh Tanna   14/07/16 - Added column to show deduplication factor in list protected database option
#    Umesh Tanna   14/07/16 - Added line after each option to print message to return to main menu
#    dongwkim    10/20/16 - use ra_disk_restore_range instead of ra_restore_range
#    dongwkim    11/14/16 - add ba_access in archivelog query
#    dongwkim    11/21/16 - add compressed column to list_backup.sh to distinguish replication tape and replication
#    dongwkim    11/21/16 - menuKR() Korean version menu

#!/bin/bash
lang=kr
BASE_DIR=/home/oracle/backup
ratns=sariwon

###### DO NOT CHANGE BELOW #######
version=161121
LOG_DIR=$BASE_DIR/log
SCRIPT_DIR=$BASE_DIR/scripts
SH_DIR=$SCRIPT_DIR/sh
DIRLIST=($BASE_DIR $LOG_DIR $SCRIPT_DIR $SH_DIR)
export ORACLE_HOME=/u01/app/oracle/product/12.1.0.2/dbhome_1
export PATH=$ORACLE_HOME/bin:$PATH:.
###### DO NOT CHANGE UNTIL THIS LINE #######


####################################################
#AES-128 Encryption Key , you can change key value.
key=welcome1
####################################################

# Encrypt rasys user passwd to file
mkenpasswd(){
inpwd=$1
`echo $inpwd | openssl enc -aes-128-cbc -a -salt -out $BASE_DIR/.rapasswd -pass pass:$key`
}

# Decrypt rasys user passwd to connect ra as rasys
mkdepasswd(){
if [ -r $BASE_DIR/.rapasswd ]
then
 rasyspwd=`openssl enc -aes-128-cbc -a -d -salt -in $BASE_DIR/.rapasswd -pass pass:$key`
else
 echo "RASYS Password has not encrypted!!"
 echo "Run \$zdlra.sh -passwd"
 exit
fi
}

initsetup(){
echo "Checking Required Files..."
if [ ! -f zdlra_sh.tar ]
  then
    echo "ERROR: zdlra_sh.tar dose not exist"
    exit
fi

echo "Creating Initial Directory"

for i in ${DIRLIST[@]}
 do
  if [ -d ${i} ]
  then
    echo  $i": directory is existing skip.."
  else
    echo " Creating " $i
    mkdir -p $i
  fi
 done
echo -n "Copy Scripts "
tar xf zdlra_sh.tar -C $SH_DIR
echo " to " $SH_DIR
}

version(){
printf "\nScript version is %7s\n\n" $version
}

menu(){
echo -e "\e[32mWelcome to Recovery Appliance\e[0m"
echo -e "\e[32m============================"
echo "1. List Protected Database"
echo "2. List Storage Location"
echo "3. List Last Backup"
echo "4. List Backup History"
echo "5. List Archive Backup"
echo "6. List Incoming Backup"
echo "7. List Incident "
echo "q. Quit"
echo -e "============================"

echo -en " Select Menu .. \e[0m"
}
menuKR(){
echo -e "\e[32mWelcome to Recovery Appliance\e[0m"
echo -e "\e[32m============================"
echo "1. 보호대상 데이터베이스 조회"
echo "2. 백업 저장공간 조회"
echo "3. 마지막 백업 조회"
echo "4. 백업 히스토리 조회"
echo "5. 아카이브로그 백업 조회"
echo "6. 실시간 백업 속도 조회"
echo "7. 인시던트 조회 "
echo "q. 종료"
echo -e "============================"

echo -en " 메뉴선택 .. \e[0m"
}

advmenu(){
echo -e "\e[107m\e[5m\e[31m    ZDLRA Advanced View Mode\e[0m"
echo -e "\e[31m=================================="
echo "1.   List Protected Database"
echo "1.1. List Protection Policy"
echo "1.2. List VPC users"
echo "2.   List Storage Location"
echo "2.1  List Purge Order When Space Is Low"
echo "3.   List Last Backup"
echo "3.1. List Backup History"
echo "3.2. List Datafile(VB) Backup"
echo "4.   List Archive Backup"
echo "5.   List Incoming Backup"
echo "6.   List Backup/Rep/Tape Queue"
echo "7.   List Incident "
echo "8.   List Running Task Summary"
echo "8.1. List Running Task "
echo "9.   Query Task "
echo "q.   Quit"
echo "=================================="

echo -ne " Select Menu .. \e[0m"
}

advrun()
{
 while true
 do
   clear
   advmenu
   read m_input
   case $m_input in
   1)
   sh $SH_DIR/ra_database.sh $rasyspwd $ratns
   echo ""
   echo "Press ENTER to return to main menu ..."
   read
   ;;
   1.1)
   sh $SH_DIR/ra_policy.sh $rasyspwd $ratns
   echo ""
   echo "Press ENTER to return to main menu ..."
   read
   ;;
   1.2)
   sh $SH_DIR/ra_vpc_user.sh $rasyspwd $ratns
   echo ""
   echo "Press ENTER to return to main menu ..."
   read
   ;;
   2)
   sh $SH_DIR/ra_storage.sh  $rasyspwd $ratns
  echo ""
  echo "Press ENTER to return to main menu ..."
  read
  ;;
  2.1)
  sh $SH_DIR/ra_purge_order.sh  $rasyspwd $ratns
  echo ""
  echo "Press ENTER to return to main menu ..."
  read
  ;;
  3)
  sh $SH_DIR/list_backup_summary.sh $rasyspwd $ratns
  echo ""
  echo "Press ENTER to return to main menu ..."
  read
  ;;
  3.1)
  sh $SH_DIR/list_db.sh $rasyspwd $ratns
  read -p "Enter Database NUM# :" dbnum
  if [[ $dbnum =~ ^[0-9]+$ ]]
  then
    sh $SH_DIR/list_backup_history.sh $rasyspwd $dbnum $ratns
    echo ""
    echo "Press ENTER to return to main menu ..."
    read
  else
    echo
    echo " !!! Enter Number !!!"
    echo
    sleep 1
  fi
  ;;
  3.2)
  sh $SH_DIR/list_db.sh $rasyspwd $ratns
  read -p "Enter Database NUM# :" dbnum
  if [[ $dbnum =~ ^[0-9]+$ ]]
  then
    sh $SH_DIR/list_backup.sh $rasyspwd D $dbnum $ratns
    echo "Press ENTER to return to main menu ..."
    read
  else
    echo
    echo " !!! Enter Number !!!"
    echo
  fi
  ;;
  3.3)
  sh $SH_DIR/list_db.sh $rasyspwd $ratns
  read -p "Enter Database NUM# :" dbnum
  if [[ $dbnum =~ ^[0-9]+$ ]]
  then
    sh $SH_DIR/list_piece_count.sh $rasyspwd I $dbnum $ratns
    echo ""
    echo "Press ENTER to return to main menu ..."
    read
  else
    echo
    echo " !!! Enter Number !!!"
    echo
  fi
  ;;
  4)
  sh $SH_DIR/list_db.sh $rasyspwd $ratns
  read -p "Enter Database NUM# :" dbnum
  if [[ $dbnum =~ ^[0-9]+$ ]]
  then
    sh $SH_DIR/list_arc.sh $rasyspwd $dbnum $ratns
    echo ""
    echo "Press ENTER to return to main menu ..."
    read
  else
    echo
    echo " !!! Enter Number !!!"
    echo
  fi
  ;;
  5)
  sh $SH_DIR/ra_incoming.sh $rasyspwd $ratns
  echo ""
  echo "Press ENTER to return to main menu ..."
  read
  ;;
 6)
 sh $SH_DIR/backup_queue.sh $rasyspwd $ratns
 echo ""
 echo "Press ENTER to return to main menu ..."
 read
 ;;
 7)
 sh $SH_DIR/ra_incident.sh $rasyspwd $ratns
 echo ""
 echo "Press ENTER to return to main menu ..."
 read
 ;;
 8)
 sh $SH_DIR/ra_task_smy.sh $rasyspwd 1 $ratns
 echo ""
 echo "Press ENTER to return to main menu ..."
 read
 ;;
 8.1)
 sh $SH_DIR/ra_task.sh $rasyspwd % 1 $ratns
 echo ""
 echo "Press ENTER to return to main menu ..."
 read
 ;;
 9)
 read -p "Enter Task Name :" tname
 read -p "Enter DB Name :" dname
 if [ -z "$dname" ]
 then
   dname='%'
 fi
 read -p "Enter Begin Time(-hour)  :" btime
 read -p "Enter End   Time(-hour)  :" etime
 if [ -z "$tname" ] || [ -z "$btime" ] || [ -z "$etime" ]
 then
   echo ""
   echo "Invalid input. Give value for task name, begin time and end time. Press ENTER key to continue..."
 else
  sh $SH_DIR/ra_task_one.sh $rasyspwd $tname $dname $btime $etime $ratns
 fi
 read
 ;;
 q)
 exit
 ;;
 esac
 done
}
run()
{
while true
  do
    clear
  if [[ $1 == 'kr' ]]  # swich to korean menu
  then
    menuKR
  else                 # run english menu
    menu
  fi

  read m_input
  case $m_input in
  1)
  sh $SH_DIR/ra_database.sh $rasyspwd $ratns
  echo ""
  echo "Press ENTER to return to main menu ..."
  read
  ;;
  2)
  sh $SH_DIR/ra_storage.sh  $rasyspwd $ratns
  echo ""
  echo "Press ENTER to return to main menu ..."
  read
  ;;
  3)
  sh $SH_DIR/list_backup_summary.sh  $rasyspwd $ratns
  echo ""
  echo "Press ENTER to return to main menu ..."
  read
  ;;
  4)
  sh $SH_DIR/list_db.sh $rasyspwd $ratns
  read -p "Enter Database NUM# :" dbnum
  if [[ $dbnum =~ ^[0-9]+$ ]]
  then
    sh $SH_DIR/list_backup_history.sh $rasyspwd $dbnum $ratns
    echo ""
    echo "Press ENTER to return to main menu ..."
    read
  else
    echo
    echo " !!! Enter Number !!!"
    echo
  fi
  ;;
  5)
  sh $SH_DIR/list_db.sh $rasyspwd $ratns
  read -p "Enter Database NUM# :" dbnum
  if [[ $dbnum =~ ^[0-9]+$ ]]
  then
    sh $SH_DIR/list_arc.sh $rasyspwd $dbnum $ratns
    echo ""
    echo "Press ENTER to return to main menu ..."
    read
  else
  echo
  echo "!!!Enter Number!!!"
  echo
  fi
  ;;
  6)
  sh $SH_DIR/ra_incoming.sh $rasyspwd $ratns
  echo ""
  echo "Press ENTER to return to main menu ..."
  read
  ;;
  7)
  sh $SH_DIR/ra_incident.sh $rasyspwd $ratns
  echo ""
  echo "Press ENTER to return to main menu ..."
  read
  ;;
  q)
  exit
  ;;
  esac
  done
}

#####################################################
################### MAIN ############################
#####################################################

if [[ $1 == '-initsetup' ]]
then
  initsetup
  exit
## Advanced View
elif [[ $1 == '-adv' ]]
then
  mkdepasswd
  advrun
  exit
elif [[ $1 == '-passwd' ]]
  then
  echo "Make your password encrypted!"
  echo -n  "Enter RASYS password : "
  read -s rasyspwd
  echo
  mkenpasswd $rasyspwd
  echo
  echo  "RASYS password has encrypted!"
  exit
elif [[ $1 == '-h' ]]
 then
  echo "zdlra.sh -h to show this help"
  echo "zdlra.sh -v to show the script version"
  echo "zdlra.sh -initsetup to install this utility"
  echo "zdlra.sh -adv to run in advance mode"
  echo "zdlra.sh -passwd to generate encrypted password"
elif [[ $1 == '-v' ]]
 then
  version
elif [[ $lang == 'kr' ]]
then
  mkdepasswd
  run kr
  exit
else
  mkdepasswd
  run
  exit
fi
