
#!/usr/bin/bash
shopt -s extglob # enable shell to extend global patterns
:

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White



# Clear the color after that
clear='\033[0m'

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
echo  -e ${BRed}"Welcome to Our DataBase Management System  made by Eng : Hams and Eng Nouran "${clear}
#create the main menu function

function mainmenu
{
	echo -e ${BBlue} "           <<<<<<<<<<<<<<<<<<<< MAIN MENU >>>>>>>>>>>>>>>>>>>>>"${clear}
	echo -e ${Yellow}"                        ( ----------- 1- Create DB ------------)"${clear}
	echo -e ${Yellow}"                        ( ----------- 2- List DBS   -----------)"${clear}
	echo -e ${Yellow}"                        ( ----------- 3- Connect DB------------)"${clear}
	echo -e ${Yellow}"                        ( ----------- 4- Drop DB   ------------)"${clear}
	echo -e ${Yellow}"                        ( ----------- 5-    Exit   ------------)"${clear}
	echo -e ${Blue} "PLEASE ENTER YOU CHOICE FROM THE PREVIOUS MAIN MENU : " ${clear}
	read choice
	case $choice in
		1) CreateDB ;;
		2) ls $db_dir ; mainmenu;;
		3) ConnectDB ;;
		4) DropDB ;;
		5) exit ;;
		*) echo -e ${Red}"wrong choice Plase selecet the correct one " ${clear}; mainmenu;; 
	esac
}

# function to create the database
function CreateDB {
	 # read -p "Enter DB Name : " dbname 
	 echo -e ${BCyan} "Enter DB Name" ${clear}
	 read dbname
	 if [[ -e $dbname ]]
		 then 
		   echo -e ${Red}"DataBase is already exist "${clear}
		   mainmenu 
	 else 
		  if [[ ! $dbname  =~ ^[a-zA-Z0-9_]+$ ]]
		  then
		  	echo -e ${Red}"!-------------- Invalid name! Only letters, numbers, and underscores are allowed. -------!"${clear}

		   elif [[ $dbname =~ ^[0-9] ]]
		   then 
			   echo -e ${Red}"!----------------- DataBase Name Cannot Start With  NUmbers --------------------------!" ${clear}
		   elif [[ ${#dbname} -lt 3 || ${#dbname} -gt 50 ]]   # # used to find the lenght of the word 
		   then 
			   echo -e ${Red}"!---------------- Invalid name! Must be between 3 and 50 characters long. ------------!" ${clear}
		   else
			   mkdir  $db_dir/$dbname 
			   echo -e ${Green}"DataBase is created succesfully ..."  
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
			if [[ ! $colname =~ ^[a-zA-Z0-9_]+$ ]]
			 then
			 	echo "!------ Invalid name! Only letters, numbers, and underscores are allowed. ----!"
			 	tablemenu
			 elif [[ $colname =~ ^[0-9] ]];
			  then
			 	echo "!-------- Table   Name Cannot Start With  NUmbers ---------------!"  
			 	tablemenu
			 else

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
                echo -e "Invalid DataType! Please enter a valid string (letters,underscores)."
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

        sep=":"  # Make sure this matches your field separator

	 # Primary Key Uniqueness Check
        if [[ "$colKey" == "PK" ]]; then
            while true; do
                if awk -F: -v pk="$data" -v col="$((i - 1))" '
                    NR > 1 && $col == pk {exit 1}' "$tablename"; then
                    break
                else
                    echo "Invalid input for Primary Key: '$data' already exists."
                fi
                echo -n "$colName ($colType) = "
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
function UpdateTable {
    read -p "Enter Table Name  : " tablename

    # Validation on table existence
    if [[ ! -e $tablename ]]; then
        echo "Error: Table $tablename doesn't exist !!"
        tablemenu
        return
    fi

    # Validation on table being empty
    if [[ ! -s $tablename ]]; then
        echo "Error: Table $tablename is empty."
        tablemenu
        return
    fi

    # Check if metadata file exists
    if [[ ! -e ."$tablename-metadata" ]]; then
        echo "Error: Metadata file for table '$tablename' does not exist."
        tablemenu
        return
    fi

    read -p "Enter Condition Column Name : " field

    # Validation on condition column name
    if [[ -z $field ]]; then
        echo "Error: Condition column name cannot be empty."
        tablemenu
        return
    fi

    # Find the column index for the condition column
    fid=$(awk -F: 'NR==1 {for (i=1; i<=NF; i++) if ($i=="'$field'") print i }' "$tablename")

    # Validation on condition column existence
    if [[ -z $fid ]]; then
        echo "Error: Column $field does not exist in table $tablename."
        tablemenu
        return
    fi

    read -p "Enter Value of Condition Column $field: " val

    # Validation on condition value
    if [[ -z $val ]]; then
        echo "Error: Condition value cannot be empty."
        tablemenu
        return
    fi

    # Check if the value exists in the condition column
    res=$(awk -F: -v col="$fid" -v value="$val" '$col == value {print $col}' "$tablename" 2>>./.error.log)

    if [[ -z $res ]]; then
        echo "Error: Value '$val' not found in column '$field'."
        tablemenu
        return
    fi

    read -p "Enter Field Name to Update: " setField

    # Validation on update field name
    if [[ -z $setField ]]; then
        echo "Error: Field name to update cannot be empty."
        tablemenu
        return
    fi

    # Find the column index for the update field
    setFid=$(awk -F: 'NR==1 {for (i=1; i<=NF; i++) if ($i=="'$setField'") print i}' "$tablename")

    if [[ -z $setFid ]]; then
        echo "Error: Column '$setField' does not exist in table '$tablename'."
        tablemenu
        return
    fi

    # Debug: Print column index
    echo "Column Index for Update Field: $setFid"

    # Get the column type for validation
    coltype=$(awk -F: -v field="$setField" '$1 == field {print $2}' ."$tablename-metadata")

    # Debug: Print column type
    echo "Column Type for Update Field: $coltype"

    if [[ -z $coltype ]]; then
        echo "Error: Column type for '$setField' not defined in table."
        tablemenu
        return
    fi

    read -p "Enter the New Value : " newval

    # Validation on new value
    if [[ -z $newval ]]; then
        echo "Error: New value cannot be empty."
        tablemenu
        return
    fi

    # Validate new value based on column type
    case "$coltype" in
        int)
            if ! [[ "$newval" =~ ^[0-9]+$ ]]; then
                echo "Error: The value for $setField column must be INTEGER."
                tablemenu
                return
            fi
            ;;
        str)
            if ! [[ "$newval" =~ ^[a-zA-Z_]+$ ]]; then
                echo "Error: The value for $setField column must be STRING."
                tablemenu
                return
            fi
            ;;
        float)
            if ! [[ "$newval" =~ ^[0-9]+\.[0-9]+$ ]]; then
                echo "Error: The value for $setField column must be FLOAT."
                tablemenu
                return
            fi
            ;;
        date)
            if ! [[ "$newval" =~ ^([0-9]{4})-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$ ]]; then
                echo "Error: The value for $setField column must be DATE (YYYY-MM-DD)."
                tablemenu
                return
            fi
            ;;
        *)
            echo "Error: Unknown column type '$coltype'."
            tablemenu
            return
            ;;
    esac

    # Get row number of the condition value
    rowNumber=$(awk -F: -v col="$fid" -v value="$val" '$col == value {print NR}' "$tablename" 2>>./.error.log)

    # Update the specific column in the target row
    awk -F: -v row="$rowNumber" -v col="$setFid" -v newValue="$newval" 'BEGIN {OFS=FS} {
        if (NR == row) {
            $col = newValue  # Update the specific column
        }
        print $0  # Print the updated row
    }' "$tablename" > temp_table && mv temp_table "$tablename"

    if [[ $? -eq 0 ]]; then
        echo "Row updated successfully."
    else
        echo "Error: Failed to update row(s) in table '$tablename'."
    fi
    tablemenu
}


function selectmenu
{
	echo "        <<<<<<<<<<<<<<<<<<<<< SELECT MENU >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" 
	echo "            (-------------1- Select all column from table ---------------) "
	echo "            (-------------2- Select spectific column from table ---------) " 
	echo "            (-------------3- Select from table under condition-----------) "
	echo "            (--------------------4-Back to table menu--------------------) "
	echo "            (--------------------5-Back to main menu---------------------) "
	echo "            (-------------------------6-Exit-----------------------------) "
	read -p  "Enter your choice from previous select menu: " choice
	case $choice in
     1)SelectAll;;
     2)SelectCol;;
     3)clear; selectcondmenu;;
     4)clear; tablemenu;; 
     5)clear; mainmenu;;
     6)exit;;
     *)echo "Wrong choice please select correct one: "; selectmenu;;
    esac 
}
function SelectAll
{
	read -p "Enter Table Name : " tablename
	if [[ -e $tablename ]]
	then
		echo "All Columns of table $tablename : "
		cat  "$tablename"
		selectmenu

	else
		echo "Table $tablename Not Exist"
		selectmenu
	fi 
			
}
function SelectCol
{
	read -p "Enter Table Name: " tablename
	if [[ -e $tablename ]]
	then
		cat "$tablename"
		read -p "Enter column number you Want to select: " colsNUM
		allcolnum=$(head -n 1 "$tablename" | awk 'BEGIN{FS=":"} {print NF}')
		if [[ $colsNUM -gt 0 && $colsNUM -le $allcolnum ]]; 
		then
            cut -d':' -f"$colsNUM" "$tablename"
        else
        	echo "Invalid column number "
        	selectmenu
        fi
	else
	  echo "Table $tablename Not Exist"
	  selectmenu
	fi	
}
function selectcondmenu
{
	echo "        <<<<<<<<<<<<<<<<<<<<Select Under Condition Menu>>>>>>>>>>>>>>>>>>>>>>>> "
	echo "           (-----------1-Select all coulmns under condition--------------) "
	echo "           (------------2-Select spectific column under condition--------) "
	echo "           (--------------------3-Back to Select Menu--------------------) "
	echo "           (-------------------4-Back to Table Menue---------------------) "
	echo "           (-------------------5- Back to Main Menu----------------------) "
	echo "           (--------------------------6-Exit-----------------------------) "
	read -p "Enter your choice from previous select under condition menu: " choice
	case $choice in 
	 1)AllCond;;
	 2)SpecCond;; 
	 3)clear; selectmenu;;
	 4)clear; tablemenu;;
	 5)clear; mainmenu;;
	 6)exit;;
     *) echo "Wrong choice please select correct one:  "; selectcondmenu;; 
	 esac	
}
function AllCond {
    echo "Select All Columns where field (op) value"
    read -p "Enter table name: " tablename
    if [[ -e $tablename ]]
    then
        read -p "Enter field where you want to select: " fieldname
        field=$(awk 'BEGIN{FS=":"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$fieldname'") print i}}}' $tablename)
        if [[ -z "$field" ]]
        then 
            echo "Field $fieldname Not Found"
            selectcondmenu
        else
            read -p "Enter operator (==,!=,<=,>=,<,>): " operator
            if [[ $operator == "<" ]] || [[ $operator == ">" ]] || [[ $operator == "<=" ]] || [[ $operator == ">=" ]] || [[ $operator == "==" ]] || [[ $operator == "!=" ]]
            then
                read -p "Enter value where you want to select: " value
                header=$(head -n 1 "$tablename" | column -t -s ':')
                echo "$header"
                result=$(awk 'BEGIN{FS=":"} NR>1 {if ($'$field' '$operator' "'$value'") print $0}' $tablename | column -t -s ':')
                if [[ -z "$result" ]] 
                then
                    echo "Value $value Not Found"
                    selectcondmenu
                else
                    echo "$result"
                    selectcondmenu
                fi
            else
                echo "Invalid operator"
                selectcondmenu
            fi
        fi
    else
        echo "Table $tablename Does Not Exist"
        selectcondmenu
    fi
}
function SpecCond {
    echo "Select spectific Columns where field (op) value"
    read -p "Enter table name: " tablename
    if [[ -e $tablename ]]
    then
        read -p "Enter field where you want to select: " fieldname
        field=$(awk 'BEGIN{FS=":"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$fieldname'") print i}}}' $tablename)
        if [[ -z "$field" ]]
        then 
            echo "Field $fieldname Not Found"
            selectcondmenu
        else
            read -p "Enter operator (==,!=,<=,>=,<,>): " operator
            if [[ $operator == "<" ]] || [[ $operator == ">" ]] || [[ $operator == "<=" ]] || [[ $operator == ">=" ]] || [[ $operator == "==" ]] || [[ $operator == "!=" ]]
            then
                read -p "Enter value where you want to select: " value
                result=$(awk 'BEGIN{FS=":"} NR>1 {if ($'$field' '$operator' "'$value'") print $'$field'}' $tablename | column -t -s ':')
                if [[ -z "$result" ]] 
                then
                    echo "Value $value Not Found"
                    selectcondmenu
                else
                	echo "$fieldname"
                    echo "$result"
                    selectcondmenu
                fi
            else
                echo "Invalid operator"
                selectcondmenu
            fi
        fi
    else
        echo "Table $tablename Does Not Exist"
        selectcondmenu
    fi
}

mainmenu

