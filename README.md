# 🐚 Bash Shell Script Database Management System (DBMS)

## 📖 Project Overview
This project is a **Database Management System (DBMS)** implemented using **Bash Shell Scripting**. It allows users to store and retrieve data from the hard disk in a structured manner. The system provides a **Command-Line Interface (CLI)** menu-driven application for managing databases and tables.

---

## 🚀 Features

### 🏠 Main Menu
The application provides the following options in the **Main Menu**:
1. **📂 Create Database**: Create a new database.
2. **📜 List Databases**: List all existing databases.
3. **🔗 Connect to Database**: Connect to a specific database to perform table operations.
4. **❌ Drop Database**: Delete an existing database.
5. **🚪 Exit**: Exit the application.

---

### 🗂️ Database Menu
Once connected to a specific database, the user can access the following options:
1. **📊 Create Table**: Create a new table with specified columns, data types, and primary key.
2. **📋 List Tables**: List all tables in the current database.
3. **🗑️ Drop Table**: Delete an existing table.
4. **➕ Insert into Table**: Insert a new row into a table.
5. **🔍 Select From Table**: Retrieve and display rows from a table.
6. **❌ Delete From Table**: Delete rows from a table based on a condition.
7. **✏️ Update Table**: Update rows in a table based on a condition.
8. **🔙 Back to Main Menu**: Return to the main menu.
9. **🚪 Exit**: Exit the application.

---

## 🏗️ Project Structure
- **📂 Databases**: Each database is stored as a **directory** in the current script's working directory.
- **📄 Tables**: Each table is stored as a **file** within the corresponding database directory.
- **📝 Metadata**: Table metadata (e.g., column names, data types, and primary key) is stored in a separate metadata file for each table.

---

## 🔑 Key Functionality

### 1. **📊 Create Table**
- The user is prompted to specify:
  - Column names.
  - Data types for each column (e.g., `int`, `str`, `float`, `date`).
  - Primary key (if any).
- The table and its metadata are saved in the database directory.

### 2. **➕ Insert into Table**
- The user is prompted to enter values for each column.
- The system validates:
  - Data types of the input values.
  - Uniqueness of the primary key (if specified).

### 3. **🔍 Select From Table**
- Rows are displayed in a **well-formatted table** on the terminal.
- Supports filtering rows based on a condition.

### 4. **✏️ Update Table**
- The user can update specific rows based on a condition.
- The system ensures:
  - Data type validation for updated values.
  - Uniqueness of the primary key (if updated).

### 5. **❌ Delete From Table**
- The user can delete rows based on a condition.

---

## 🛠️ Data Validation
- **Data Types**: The system enforces data types for columns (e.g., `int`, `str`, `float`, `date`).
- **Primary Key**: Ensures the primary key is unique during insertion and updates.
- **Input Validation**: Validates user input to prevent errors and maintain data integrity.

---

## 🖥️ Usage

### Running the Script
1. Clone the repository or download the script.
2. Make the script executable:
   ```bash
   chmod u+x dbms.sh
   
3. Run the script: 
 ```bash
   ./dbms.sh
---

## 👩‍💻 Author
- **Eng: Hams & Eng: Nouran**
- GitHub: [NouranElshazly](https://github.com/NouranElshazly) | [HamsEldakrory](https://github.com/HamsEldakrory)

