BASE_DIR='d:\MyDoc'
LOG_DIR='d:\MyDoc'
DIRLIST=($BASE_DIR $LOG_DIR $SCRIPT_DIR $SH_DIR)
for i in ${DIRLIST[@]}
do
  echo $i
done
dbnum=a
if [[ $dbnum =~ ^[0-9]+$ ]]
then
  echo ""
  echo "Press ENTER to return to main menu ..."
  read
else
  echo
  echo " !!! Enter Number !!!"
  echo
fi
