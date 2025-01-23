
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
 8) clear ; cd .. ; mainmenu;;  #/DBMS_USING_BASH_SCRIPT/Database/$dbname  this why we use cd ..
 9) exit;;
 *) echo "Wrong choice Plase selecet the correct one:  "; tablemenu;;
esac
}
function CreateTable
{
	read -p "Please Enter Table Name : " tablename
	if [[ -e $tablename ]]
		then 
			echo "Table is Already Exist Please Choose another name  "
			tablemenu 
		else 
			  if [[ ! $tablename  =~ ^[a-zA-Z0-9_]+$ ]]
		  then
		  	echo "!-------------- Invalid name! Only letters, numbers, and underscores are allowed. -------!"

		   elif [[ $tablename =~ ^[0-9] ]]
		   then 
			   echo "!----------------- Table   Name Cannot Start With  NUmbers --------------------------!"  
		   elif [[ ${#tablename} -lt 3 || ${#tablename} -gt 50 ]]   # # used to find the lenght of the word 
		   then 
			   echo "!---------------- Invalid name! Must be between 3 and 50 characters long. ------------!" 
		   else
	 
			read -p "Please Enter column Numbers " columnnum
		  if ! [[ "$columnnum" =~ ^[0-9]+$ ]]; then
            echo "Invalid input! Please enter a number."
            tablemenu
        fi
			#validation 

			sep=":"
			counter=1
			rowsep="\n"
			hasPK=false
			primkey=""
			metaData="Field"$sep"Type"$sep"key"
			for ((counter;counter<=columnnum;counter++))
			do 
			read -p "Enter Name of column No:$counter : " colname 
			echo "Enter Types of $colname :"
			select var in "int" "str" "float" "date"
			do 
				case $var in 
					int) 
						coltype="int"
						break;;
					str)
						coltype="str"
						break;;
					float)
						coltype="float"
						break;;
					date)
						coltype="date"
						break;;

					*)
					echo "Wrong choice Please Enter to Make a correct choice again !"
				esac
			done

		if [[ "$primkey" == "" ]]
		then 
			echo "Do you want to make it Primary " 
			select var in "Yes" "No"
				do 
				case $var in 
				Yes)
					primkey="PK"
					metaData+=$rowsep$colname$sep$coltype$sep$primkey
					hasPK=true

					break;;
				No)
					metaData+=$rowsep$colname$sep$coltype$sep""
					break;;
				*)
					echo "wrong choice Please Enter to Make a correct choice again !"
					break;;
				esac
			done 
			else
				metaData+=$rowsep$colname$sep$coltype$sep""
		fi
		if [[ $counter == $columnnum ]]
		then
		   maintable=$maintable$colname
		else

		   maintable=$maintable$colname$sep
		fi
		done 
 if [[ "$hasPK" == false ]]; then
            echo "Error: At least one column must be a primary key."
            tablemenu
        else
            # Create metadata and table files
            echo -e "$metaData" > ."$tablename-metadata"
            echo -e "$maintable" > "$tablename"

            if [[ $? == 0 ]]; then
                echo "Table created successfully."
                tablemenu
            else
                echo "Failed to create table $tablename."
                tablemenu
            fi
        fi
    fi
	fi
		  tablemenu
}
function DropTable
{
	read -p "Enter name of table you want to delete it " tablename
	if [[ -e $tablename ]]
	then
	 read -p "Do you want to dropped $tablename (y/N)? " check
			   if [[ $check =~ ^([yY][eE][sS]|[Yy]) ]]
			   then 
			      rm -r $tablename .$tablename-metadata
			      echo "Table $tablename is Dropped Succesfully... "
			     tablemenu
			   else 
			      echo "Table Cannot dropped  "
			     tablemenu
			   fi
	   else 
		   echo "Table $tablename is not exist "
		   tablemenu
	   fi



}
function InsertintoTable {
    read -p "Please Enter Table name: " tablename
    if [[ ! -e ."$tablename-metadata" ]]; then
        echo "Error: Table $tablename does not exist."
        tablemenu
    fi

    colsNUM=$(awk 'END{print NR}' ."$tablename-metadata")
    sep=":"
    row=""
    rowsep="\n"
    for (( i=2; i<=colsNUM; i++ )); do
        colName=$(awk 'BEGIN{FS=":"}{if(NR=='$i') print $1}' ."$tablename-metadata")
        colType=$(awk 'BEGIN{FS=":"}{if(NR=='$i') print $2}' ."$tablename-metadata")
        colKey=$(awk 'BEGIN{FS=":"}{if(NR=='$i') print $3}' ."$tablename-metadata")
        echo -e "$colName ($colType) = \c"
        read data

        # Validate Input
        #integer input 
        if [[ $colType == "int" ]]; then
            while ! [[ $data =~ ^[0-9]+$ ]]; do
                echo -e "Invalid DataType! Please enter a valid integer."
                echo -e "$colName ($colType) = \c"
                read data
            done
        # string input
        elif [[ $colType == "str" ]]; then
            while ! [[ $data =~ ^[a-zA-Z_]+$ ]]; do
                echo -e "Invalid DataType! Please enter a valid string (letters, numbers, underscores)."
                echo -e "$colName ($colType) = \c"
                read data
            done
        

	 	elif [[ "$colType" == "float" ]]; then
	        while ! [[ "$data" =~ ^[+-]?[0-9]*\.[0-9]+$|^[+-]?[0-9]+$ ]]; do
	            echo -e "Invalid DataType! Please enter a valid float."
	            echo -e "$colName ($colType) = \c"
	            read data
	        done
	    
	    # Validate Input for Date
   		 elif [[ "$colType" == "date" ]]; then
	        while ! [[ "$data" =~ ^([0-9]{4})-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$ ]]; do
	            echo -e "Invalid Date Format! Please enter a valid date (YYYY-MM-DD)."
	            echo -e "$colName ($colType) = \c"
	            read data
	        done

    
 		if  !date -d "$date" 2>/dev/null 
 		then 
 			echo "Invalid Dte Please enter a valid date (YYYY-MM-DD)"
 			read -p "$colName ($colType)"data 
 			

 	    fi
    fi

        if [[ "$colKey" == "PK" ]]; then
            while true; do
                if grep -q "^$data$sep" "$tablename"; then	
                    echo -e "Invalid input for Primary Key: '$data' already exists."
                else
                    break
                fi
                echo -e "$colName ($colType) = \c"
                read data
            done
        fi

        # Set Row Data
        if [[ $i == $colsNUM ]]; then
            row=$row$data$rowsep
        else
            row=$row$data$sep
        fi
    done

    echo -e "$row" >> "$tablename"
    if [[ $? == 0 ]]; then
        echo "Data inserted successfully."
    else
        echo "Error inserting data into table $tablename."
    fi
    row=""
    tablemenu
}

function DeletefromTable {
  read -p "Enter Table Name:  " tablename
  if [[ -e $tablename ]]; 
  then
    read -p "Enter Column Name: " colname
    fieldname=$(awk 'BEGIN{FS=":"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$colname'")print i}}}' $tablename)
    if [[ $fieldname == "" ]]; 
    then
      echo "Column $colname Not Found"
      tablemenu
    else
      read -p "Enter what value you want to delete: " value
      datavalue=$(awk 'BEGIN{FS=":"}{if ($'$fieldname'=="'$value'") print $'$fieldname'}' $tablename)
      if [[ $datavalue == "" ]]; then
        echo "Value $value Not Found"
        tablemenu
      else
        row=$(awk 'BEGIN{FS=":"}{if ($'$fieldname'=="'$value'") print NR}' $tablename)
        sed -i "${row}d" $tablename
        echo "Row with value $value Deleted Successfully"
        tablemenu
      fi
    fi
  else
    echo "Table $tablename does not exist"
  fi
}




mainmenu

