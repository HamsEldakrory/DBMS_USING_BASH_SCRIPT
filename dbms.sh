
#!/usr/bin/bash
shopt -s extglob # enable shell to extend global patterns
:
db_dir="$(pwd)/Database"
if [[ -e "$db_dir" ]]
then 	
	cd "$db_dir"
	echo DataBase is connected ....
else 
	mkdir -p "$db_dir"
	cd  "$db_dir"

	echo DataBase is connected ...
fi 
echo Welcome to Our DataBase Management System  made by Eng : Hams and Eng Nouran 
#create the main menu function

function mainmenu
{
	echo  "                    <<<<<<<<<<<<<<<<<<<< MAIN MENU >>>>>>>>>>>>>>>>>>>>>"
	echo  "                        ( ----------- 1- Create DB ------------)"
	echo  "                        ( ----------- 2- List DBS   -----------)"
	echo  "                        ( ----------- 3- Connect DB------------)"
	echo  "                        ( ----------- 4- Drop DB   ------------)"
	echo  "                        ( ----------- 5- Exit      ------------)"
	read -p "PLEASE ENTER YOU CHOICE FROM THE PREVIOUS MAIN MENU : " choice
	case $choice in
		1) CreateDB ;;
		2) ls $db_dir ; mainmenu;;
		3) ConnectDB ;;
		4) DropDB ;;
		5) exit ;;
		*) echo "wrong choice Plase selecet the correct one " ; mainmenu;;
	esac
}

# function to create the database
function CreateDB {
	 read -p "Enter DB Name : " dbname 
	 if [[ -e $dbname ]]
		 then 
		   echo "DataBase is already exist "
		   mainmenu 
	 else 
		  if [[ ! $dbname  =~ ^[a-zA-Z0-9_]+$ ]]
		  then
		  	echo "!-------------- Invalid name! Only letters, numbers, and underscores are allowed. -------!"

		   elif [[ $dbname =~ ^[0-9] ]]
		   then 
			   echo "!----------------- DataBase Name Cannot Start With  NUmbers --------------------------!"  
		   elif [[ ${#dbname} -lt 3 || ${#dbname} -gt 50 ]]   # # used to find the lenght of the word 
		   then 
			   echo "!---------------- Invalid name! Must be between 3 and 50 characters long. ------------!" 
		   else
			   mkdir  $db_dir/$dbname 
			   echo "DataBase is created succesfully ..."  
		  fi 

		 mainmenu 
	fi 
}
function ConnectDB 
{
	   read -p "Enter your selected DataBase name: " dbname
	   if [[ -e $dbname ]]
	   then
		   cd $db_dir/$dbname 
		   echo "DataBase $dbname was Connected successfully......."
		   tablemenu
	   else
		   echo "DataBase $dbname  wasn't found "
		   mainmenu
	   fi
   
}

function DropDB
{
	   read -p "PLease Enter Name of db you want to drop : " dbname 
	   if [[ -e $dbname ]]
		   then 
		   read -p "Do you want to dropped $dbname (y/N)? " check
			   if [[ $check =~ ^([yY][eE][sS]|[Yy]) ]]
			   then 
			      rm -r $dbname 
			      echo "DataBase $dbname is Dropped Succesfully... "
			      mainmenu
			   else 
			      echo "DataBase Cannot dropped  "
			      mainmenu
			   fi
	   else 
		   echo "DataBase $dbname is not exist "
		   mainmenu 
	   fi
   
}

function tablemenu
{
 echo  "                  <<<<<<<<<<<<<<<<<< TABLE MENU>>>>>>>>>>>>>>>>>>>>"
 echo  "                    ( ------------ 1-Create Table       --------------)"  
 echo  "                    ( ------------ 2-List Tables        --------------)"  
 echo  "                    ( ------------ 3-Drop Table         --------------)"  
 echo  "                    ( ------------ 4-Insert Into Table  --------------)"  
 echo  "                    ( ------------ 5-Select from Table  --------------)"  
 echo  "                    ( ------------ 6-Delete From Table  --------------)" 
 echo  "                    ( ------------ 7-Update Table       --------------)"   
 echo  "                    ( ------------ 8- Back To Main Menu --------------)"   
 echo  "                    ( ------------ 9- Exit              --------------)"   
 read -p "Please Enter Your choice From The Previous Table Menu: " choice
 case $choice in 
 1) CreateTable;;
 2) ls ; tablemenu ;;
 3) DropTable;;
 4) InsertintoTable;;
 5) clear ; selectmenu;;
 6) DeletefromTable;;
 7) UpdateTable;;
 8) clear ; cd .. ; mainmenu;;  #/home/nouran/Desktop/DBMS_Project/DBMS_USING_BASH_SCRIPT/Database/$dbname  this why we use cd ..
 9) exit;;
 *) echo "Wrong choice Plase selecet the correct one:  "; tablemenu;;
esac
}


mainmenu

