#define array of 5 numbers
$numbers = @(1,2,3,4,5)

# check if the array contains 3 using ternary operator
$containsThree = $numbers -contains 3 ? "Yes" : "No"
Write-Host "Does the array contain 3? $containsThree"

#define hashtable
$hash = @{
    "key1" = "value1"
    "key2" = "value2"
}

# access hashtable value using key
Write-Host "Value for key1: $($hash["key1"])"

# get files in current directory
$files = Get-ChildItem -Path . -File
# write file names
foreach ($file in $files) {
    Write-Host "File: $($file.Name)"
}

# extract $hast to json file ovveriding existing file
$hash | ConvertTo-Json | Out-File -FilePath ./hash.json -Force

# get list of all running processes and save it to a txt file. Save only names of processes and omit empty names
Get-Process | Select-Object -ExpandProperty Name | Where-Object { $_ } | Out-File -FilePath ./processes.txt -Force



