#!/bin/bash

# ============================
#     Bash DBMS System
# ============================

main_menu() {
    clear
    while true; 
    do
        clear
        echo -e "\e[32m╔═════════════════════════════════════════════════════════╗\e[0m"
        echo -e "\e[32m║     🛢️  \e[1mBash DBMS System\e[0m\e[32m                                 ║\e[0m"
        echo -e "\e[32m╠═════════════════════════════════════════════════════════╣\e[0m"
        echo -e "\e[32m║ 1) 📁 Create Database                                   ║\e[0m"
        echo -e "\e[32m║ 2) 📄 List Databases                                    ║\e[0m"
        echo -e "\e[32m║ 3) 🔗 Connect to Database                               ║\e[0m"
        echo -e "\e[32m║ 4) ❌ Drop Database                                     ║\e[0m"
        echo -e "\e[32m║ 5) 🚪 Exit                                              ║\e[0m"
        echo -e "\e[32m╚═════════════════════════════════════════════════════════╝\e[0m"
        echo
        read -p "Choose an option PLZ: " choice

        case $choice in
            1) create_database 
            ;;
            2) list_databases 
            ;;
            3) connect_database 
            ;;
            4) drop_database 
            ;;
            5) 
                echo -e "\e[1;32m✅ Exiting... Goodbye!\e[0m"
                sleep 1
                exit
                ;;
            *)
                echo -e "\e[1;31m❌ Invalid choice!\e[0m"
                sleep 1
                ;;
        esac
    done
}



create_database() {
    read -p "Enter database name: " dbname
    case "$dbname" in
        "")
            echo -e "\e[1;31m❌ Database name cannot be empty.\e[0m"
              sleep 3
            ;;
        [a-zA-Z_][a-zA-Z0-9_-]*)
            if [[ -d "$dbname" ]]; then
                echo -e "\e[1;33m⚠️  Database '\e[4m$dbname\e[0;1;33m' already exists!\e[0m"
                sleep 3 
            else
                mkdir "$dbname"
                echo -e "\e[1;32m✅ Database '\e[4m$dbname\e[0;1;32m' created successfully.\e[0m"
            fi
            ;;
        *)
            echo -e "\e[1;31m❌ Invalid database name.\e[0m"
            echo -e "\e[36m✔️  Use letters, numbers, _ or - (not starting with a number).\e[0m"
              sleep 3
            ;;
    esac
    sleep 3
}


list_databases() {
    echo -e "\e[1;34m📂 Available Databases:\e[0m"
    
    db_list=$(ls -d */ 2>/dev/null | sed 's#/##')  # إزالة الشرط المائل /

    if [[ -z "$db_list" ]]; then
        echo -e "\e[1;33m❗ No databases found.\e[0m"
    else
        echo -e "\e[32m$db_list\e[0m"
    fi

    echo
    read -p "Press Enter to continue..." 
}


connect_database() {
    read -p "🔌 Enter database name to connect: " dbname

    if [[ -d "$dbname" ]]; then
        cd "$dbname" || return
        echo -e "\e[1;32m✅ Connected to database '\e[4m$dbname\e[0;1;32m'.\e[0m"
          sleep 1
        database_menu
    else
        echo -e "\e[1;31m❌ Database '\e[4m$dbname\e[0;1;31m' not found!\e[0m"
        sleep 3
    fi
}


drop_database() {
    read -p "🗑️  Enter database name to delete: " dbname

    if [[ -d "$dbname" ]]; then
        read -p "⚠️ Are you sure you want to delete '$dbname'? [y/N]: " confirm
        case "$confirm" in
            [yY]|[yY][eE][sS])
                rm -r "$dbname"
                echo -e "\e[1;32m✅ Database '\e[4m$dbname\e[0;1;32m' deleted successfully.\e[0m"
                sleep 2
                ;;
            *)
                echo -e "\e[1;33m❎ Deletion cancelled.\e[0m"
                sleep 3;
                ;;
        esac
    else
        echo -e "\e[1;31m❌ Database '\e[4m$dbname\e[0;1;31m' not found!\e[0m"
        sleep 3
    fi

    sleep 1
}

database_menu() {
    while true; 
    do
        clear
        echo -e "\e[36m╔══════════════════════════════════════════════╗\e[0m"
        echo -e "\e[36m║   \e[1m Managing Tables in '\e[4m$dbname\e[0;1;36m'\e[36m              ║\e[0m"
        echo -e "\e[36m╠══════════════════════════════════════════════╣\e[0m"
        echo -e "\e[36m║ 1) 📋 Create Table                            ║\e[0m"
        echo -e "\e[36m║ 2) 📄 List Tables                             ║\e[0m"
        echo -e "\e[36m║ 3) ❌ Drop Table                              ║\e[0m"
        echo -e "\e[36m║ 4) ➕ Insert into Table                       ║\e[0m"
        echo -e "\e[36m║ 5) 🔍 Select From Table                       ║\e[0m"
        echo -e "\e[36m║ 6) 🗑️  Delete From Table                       ║\e[0m"
        echo -e "\e[36m║ 7) ✏️  Update Table                            ║\e[0m"
        echo -e "\e[36m║ 8) 🔙 Return to Main Menu                     ║\e[0m"
        echo -e "\e[36m╚══════════════════════════════════════════════╝\e[0m"
        echo
        read -p "Choose an option [1-8] PLZ: " choice
        case "$choice" in
            1) create_table 
            ;;
            2) list_tables 
            ;;
            3) drop_table 
            ;;
            4) insert_into_table 
            ;;
            5) select_from_table 
            ;;
            6) delete_from_table 
            ;;
            7) update_table 
            ;;
            8) cd ..; break 
            ;;
            *)
                echo -e "\e[1;31m❌ Invalid option.\e[0m"
                sleep 1
                ;;
        esac
    done
}


create_table() {
    read -p "📄 Enter table name: " table

if [[ -f "$table.txt" ]]; then
    echo -e "\e[1;31m❌ Table '\e[4m$table\e[0;1;31m' already exists!\e[0m"
    sleep 3
    return
fi


    read -p "🔑 Enter primary key column name: " primary_key

    while true; 
    do
        read -p "🔢 Enter number of columns: " col_count
        if [[ "$col_count" =~ ^[1-9][0-9]*$ ]]; then
            break
        else
            echo -e "\e[1;31m❌ Please enter a valid positive number.\e[0m"
        fi
    done

    columns=()
    data_types=()

    for ((i = 1; i <= col_count; i++)); 
    do
        while true; 
        do
            read -p "➡️  Enter name for column $i: " col_name

            if [[ " ${columns[*]} " =~ " $col_name " ]]; then
                echo -e "\e[1;33m⚠️  Column name '\e[4m$col_name\e[0;1;33m' already used. Please choose another.\e[0m"
            else
                columns+=("$col_name")
                break
            fi
        done

        while true; 
        do
            echo -e "📌 Enter data type for '\e[1m$col_name\e[0m' (INT, STRING, FLOAT): "
            read col_type
            col_type_upper=$(echo "$col_type" | awk '{print toupper($0)}')

            if [[ "$col_type_upper" == "INT" || "$col_type_upper" == "STRING" || "$col_type_upper" == "FLOAT" ]]; then
                data_types+=("$col_type_upper")
                break
            else
                echo -e "\e[1;31m❌ Invalid data type. Allowed: INT, STRING, FLOAT.\e[0m"
            fi
        done
    done

    header="Primary Key: $primary_key | Columns: ${columns[*]} | Data Types: ${data_types[*]}"
    echo "$header" > "$table.txt"

    echo -e "\e[1;32m✅ Table '\e[4m$table\e[0;1;32m' created successfully.\e[0m"
    sleep 2
    database_menu
}



list_tables() {
    echo -e "\e[1;34m📋 Available Tables:\e[0m"

    tables=( *.txt )

    if [[ ${#tables[@]} -eq 0 || "${tables[0]}" == '*.txt' ]]; then
        echo -e "\e[1;33m❗ No tables found.\e[0m"
    else
        for table in "${tables[@]}"; 
        do
            echo -e "\e[32m- ${table%.txt}\e[0m"
        done
    fi

    echo
    read -p "Press Enter to continue..." 
}


drop_table() {
    read -p "🗑️    Enter table name to delete: " table

    if [[ -f "$table.txt" ]]; then
        read -p "⚠️  Confirm delete '$table'? [y/N]: " confirm
        case "$confirm" in
            [yY]|[yY][eE][sS])
                rm "$table.txt"
                echo -e "\e[1;32m✅ Table '\e[4m$table\e[0;1;32m' deleted successfully.\e[0m"
                ;;
            *)
                echo -e "\e[1;33m❎ Deletion cancelled.\e[0m"
                ;;
        esac
    else
        echo -e "\e[1;31m❌ Table '\e[4m$table\e[0;1;31m' not found!\e[0m"
        sleep 3
    fi

    database_menu
}


insert_into_table() {
    read -p "📥 Enter table name to insert into: " table

    if [[ ! -f "$table.txt" ]]; then
        echo -e "\e[1;31m❌ Table '\e[4m$table\e[0;1;31m' does not exist!\e[0m"
        sleep 3;
        return
    fi

    read -p "📝 Enter comma-separated values (first is Primary Key): " data
    primary_key=$(echo "$data" | cut -d',' -f1)

    if grep -q "^$primary_key," "$table.txt"; then
        echo -e "\e[1;31m❌ Primary key '\e[4m$primary_key\e[0;1;31m' already exists!\e[0m"
        sleep 3;
        return
    fi

    header=$(head -n 1 "$table.txt")
    data_types=$(echo "$header" | cut -d '|' -f3 | sed 's/ Data Types: //')
    
    IFS=' ' read -ra type_array <<< "$data_types"
    IFS=',' read -ra value_array <<< "$data"

    expected_count=$(( ${#type_array[@]} + 1 ))

    if [[ ${#value_array[@]} -ne $expected_count ]]; then
        echo -e "\e[1;31m❌ Expected $expected_count values, but got ${#value_array[@]}.\e[0m"
        return
    fi

    has_error=0  # 0 = no error, 1 = error exists

    for ((i = 1; i < expected_count; i++)); 
    do
        value="${value_array[$i]}"
        type="${type_array[$((i - 1))]}"

        case "$type" in
            INT)
                if ! [[ "$value" =~ ^[0-9]+$ ]]; then
                    echo -e "\e[1;31m❌  Column $((i+1)) must be \e[1mINT\e[0;1;31m, got '\e[4m$value\e[0;1;31m'\e[0m"
                    has_error=1
                fi
                ;;
            FLOAT)
                if ! [[ "$value" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
                    echo -e "\e[1;31m❌  Column $((i+1)) must be \e[1mFLOAT\e[0;1;31m, got '\e[4m$value\e[0;1;31m'\e[0m"
                    has_error=1
                fi
                ;;
            STRING)
                if ! [[ "$value" =~ ^[a-zA-Z0-9@._-]+$ ]]; then
                    echo -e "\e[1;31m❌  Column $((i+1)) must be \e[1mSTRING\e[0;1;31m, got '\e[4m$value\e[0;1;31m'\e[0m"
                    has_error=1
                fi
                ;;
            *)
                echo -e "\e[1;33m⚠️  Unknown data type: $type\e[0m"
                has_error=1
                ;;
        esac
    done

    if [[ $has_error -eq 0 ]]; then
        echo "$data" >> "$table.txt"
        echo -e "\e[1;32m✅  Data inserted successfully into '\e[4m$table\e[0;1;32m'.\e[0m"
        sleep 3
    else
        echo -e "\e[1;33m⚠️  Data not inserted due to validation errors.\e[0m"
        sleep 3;
    fi
    database_menu
}

select_from_table() {
    read -p "📄 Enter table name: " table
    if [[ ! -f "$table.txt" ]]; then
        echo -e "\e[1;31m❌ Table '\e[4m$table\e[0;1;31m' does not exist!\e[0m"
        sleep 2
        return
    fi

    echo -e "\n\e[1;34m🧾 Header:\e[0m"
    echo -e "\e[1;33m$(head -n 1 "$table.txt")\e[0m"

    echo -e "\n\e[1;34m📋 Data:\e[0m"
    tail -n +2 "$table.txt" | nl -v 2 | while IFS= read -r line; 
    do
        echo -e "\e[0;32m$line\e[0m"
    done

    echo
    read -p "🔁 Press Enter to return to menu..." _
}


delete_from_table() {
    read -p "🗑️  Enter table name: " table
    file="$table.txt"

    if [[ ! -f "$file" ]]; then
        echo -e "\e[1;31m❌ Table '\e[4m$table\e[0;1;31m' does not exist!\e[0m"
        sleep 2
        return
    fi

    echo -e "\n\e[1;34m📋 Current Data:\e[0m"
    tail -n +2 "$file" | nl -v 2 | while IFS= read -r line; do
        echo -e "\e[0;32m$line\e[0m"
    done

    total=$(wc -l < "$file")
    echo

    read -p "🔢 Enter line number to delete (starting from 2): " line

    if [[ "$line" =~ ^[0-9]+$ && "$line" -ge 2 && "$line" -le "$total" ]]; then
        read -p "⚠️ Are you sure you want to delete line $line? [y/N]: " confirm
        case "$confirm" in
            [yY]|[yY][eE][sS])
                sed -i "${line}d" "$file"
                echo -e "\e[1;32m✅ Line $line deleted successfully from '\e[4m$table\e[0;1;32m'.\e[0m"
                ;;
            *)
                echo -e "\e[1;33m❎ Deletion cancelled.\e[0m"
                ;;
        esac
    else
        echo -e "\e[1;31m❌ Invalid line number! Please enter a number between 2 and $total.\e[0m"
    fi

    sleep 2
    database_menu
}


update_table() {

    MAGENTA='\033[0;35m'
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    BLUE='\033[0;34m'
    BOLD='\033[1m'
    Rest='\033[0m' 

    echo -e "${BLUE}📂 Enter table name to update:${Rest} "
    read table

    if [[ ! -f "$table.txt" ]]; then
        echo -e "${BOLD}${RED}❌ Table '$table' does not exist!${Rest}"
        sleep 2
        return
    fi

    echo -e "${GREEN}📋 Displaying table content with line numbers:${Rest}"
    header=$(head -n 1 "$table.txt")
    echo -e "${YELLOW}$header${Rest}"
    nl -ba "$table.txt"

    total_lines=$(wc -l < "$table.txt")
    echo -e "${BOLD}${MAGENTA}📝 Enter the line number to update:${Rest}"
    read line

    # line must be positive
    if ! [[ "$line" =~ ^[0-9]+$ ]]; then
        echo -e "${BOLD}${RED}❌ Error: Line number must be a positive integer.${Rest}"
        sleep 2
        return
    fi

    # line must be less than total_lines and greater than or equal to 2 
    if [[ "$line" -lt 2 || "$line" -gt "$total_lines" ]]; then
        echo -e "${BOLD}${RED}❌ Error: Invalid line number. Please choose between 2 and $total_lines.${Rest}"
        sleep 2
        return
    fi

    echo -e "${BLUE}🔁 Enter the new data comma-separated (Primary Key first):${Rest} "
    read new_data

    metadata=$(head -n 1 "$table.txt")
    data_types=$(echo "$metadata" | cut -d '|' -f3 | sed 's/ Data Types: //')
    
    IFS=' ' read -ra type_array <<< "$data_types"
    IFS=',' read -ra value_array <<< "$new_data"

    expected_count=$(( ${#type_array[@]} + 1 ))

    if [[ ${#value_array[@]} -ne $expected_count ]]; then
        echo -e "${RED}❌ Error: Expected $expected_count values, but got ${#value_array[@]}.${Rest}"
        sleep 2
        return
    fi

    has_error=false

    # Primary Key 

    if ! [[ "${value_array[0]}" =~ ^[a-zA-Z0-9@._-]+$ ]]; then
        echo -e "${RED}❌ Error: Primary Key must be STRING format.${Rest}"
        has_error=true
    fi

    # All Data

    for ((i = 0; i < ${#type_array[@]}; i++)); 
    do
        value="${value_array[$((i + 1))]}"
        type="${type_array[$i]}"

        case "$type" in
            INT)
                if ! [[ "$value" =~ ^[0-9]+$ ]]; then
                    echo -e "${RED}❌ Error: Column $((i + 2)) must be INT. Got: $value${Rest}"
                    has_error=true
                fi
                ;;
            FLOAT)
                if ! [[ "$value" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
                    echo -e "${RED}❌ Error: Column $((i + 2)) must be FLOAT. Got: $value${Rest}"
                    has_error=true
                fi
                ;;
            STRING)
                if ! [[ "$value" =~ ^[a-zA-Z0-9@._-]+$ ]]; then
                    echo -e "${RED}❌ Error: Column $((i + 2)) must be STRING. Got: $value${Rest}"
                    has_error=true
                fi
                ;;
            *)
                echo -e "${YELLOW}⚠️ Warning: Unknown data type '$type'${Rest}"
                ;;
        esac
    done

    # No Errors

    if [[ $has_error == false ]]; then
        formatted_data=$(echo "$new_data" | sed 's/[\/&]/\\&/g')
        sed -i "${line}s/.*/$formatted_data/" "$table.txt"
        echo -e "${GREEN}✅ Line $line updated in table '$table'.${Rest}"
    else
        echo -e "${YELLOW}⚠️ Update failed due to validation errors.${Rest}"
    fi

    sleep 3
    database_menu
}



# === Start Script ===
main_menu



