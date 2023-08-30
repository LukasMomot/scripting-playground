[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $ParameterName
)


# check if SqlSever poweershell module is installed and import it
if (-not (Get-Module -Name SqlServer)) {
    Install-Module -Name SqlServer -Scope CurrentUser -Force
}

# read alls txt files from current directory and concat content to one variable
$files = Get-ChildItem -Path . -Filter *.txt
$content = ""
foreach ($file in $files) {
    $temp = Get-Content $file
    $content = $content -join "`n GO;"
    $content = $content -join "`n $temp"
}

$script = @"
   begin tran t1 {
    $content
   }
"@

# Define the path to the SQL files
$path = "C:\path\to\sql\files"

# Define the SQL Server connection details
$server = "localhost"
$database = "mydatabase"
$username = "myusername"
$password = "mypassword"

# Define the SQL query to wrap the concatenated SQL scripts in a transaction
$transactionQuery = "BEGIN TRANSACTION`n"

# Get all SQL files in the specified path
$sqlFiles = Get-ChildItem -Path $path -Filter *.sql

# Loop through each SQL file and append its contents to the transaction query
foreach ($file in $sqlFiles) {
    $transactionQuery += Get-Content $file.FullName | Out-String
    $transactionQuery += "`nGO`n"
}

# Add the commit or rollback statement to the end of the transaction query using multiple lines
$transactionQuery += "IF @@ERROR = 0`n    COMMIT TRANSACTION`nELSE`n    ROLLBACK TRANSACTION`n"

# Define the SQL Server connection string
$connectionString = "Server=$server;Database=$database;User ID=$username;Password=$password;"

# Create a new SQL Server connection
$connection = New-Object System.Data.SqlClient.SqlConnection($connectionString)

# Open the SQL Server connection
$connection.Open()

# Create a new SQL Server command using the transaction query and connection
$command = New-Object System.Data.SqlClient.SqlCommand($transactionQuery, $connection)

# Execute the SQL Server command and store the result
$result = $command.ExecuteNonQuery()

# Close the SQL Server connection
$connection.Close()

# Output the result of the SQL Server command
$result

# execute sql script against database

