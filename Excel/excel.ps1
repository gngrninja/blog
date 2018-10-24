#this is a function I found that converts CSV data into a multipart array (which we need to feed the sheets the data)
function ConvertTo-MultiArray {
    [cmdletbinding()]
    param (
        $InputObject,

        [switch]
        $Headers = $false
    )
    begin {

        $Objects = @()
        [ref]$Array = [ref]$null

    }
    process {

        $Objects += $InputObject

    }
    end {

        $Properties   = $Objects[0].PSObject.Properties | ForEach-Object{ $_.Name }
        $Array.Value  = New-Object 'object[,]' ($Objects.Count + 1), $Properties.Count
        $ColumnNumber = 0

        if ($Headers)
        {
            $Properties | ForEach-Object{
                $Array.Value[0, $ColumnNumber] = $_.ToString()
                $ColumnNumber++
            }
            $RowNumber = 1
        }
        else
        {
            $RowNumber = 0
        }
        $Objects | ForEach-Object{
            $Item = $_
            $ColumnNumber = 0
            $Properties | ForEach-Object{
                if ($Item.($_) -eq $null)
                {
                    $Array.Value[$RowNumber, $ColumnNumber] = ""
                }
                else
                {
                    $Array.Value[$RowNumber, $ColumnNumber] = $Item.($_).ToString()
                }
                $ColumnNumber++
            }
            $RowNumber++
        }
        $Array
    }
}

#I use a try / catch / finally here to encapsulate the run and always quit the object at the end
try {
    #Import the data we want to work with
    $data = Import-Csv -Path "$PSScriptRoot\data.csv"

    #This is the data we will use to fill in on sheet 1 as an example later
    $MultiArray = (ConvertTo-MultiArray $data -Headers).Value

    #Excel save file
    $fileName = "$PSScriptRoot\excel.xlsx"

    #Specify the worksheets we want to create via this array
    [System.Collections.ArrayList]$worksheets = @(
        'first sheet','second sheet','thirdsheet'
    )

    #Create excel object
    $excelObject = New-Object -ComObject Excel.Application

    #You can set visible to true to see it working and troubleshoot (if needed)
    $excelObject.Visible       = $false
    $excelObject.DisplayAlerts = $false

    #Create the workbook first
    $workbook = $excelObject.Workbooks.Add() 

    Write-Host "Workbook created... attempting to create sheets"

    #Create worksheets
    foreach ($sheet in $worksheets) {

        #Get all current sheets
        $excelWorksheets = $workbook.sheets

        #This ensures we only create the number of sheets as defined in the array above
        if ($excelWorksheets.Count -ne $worksheets.Count) {

            #add sheet
            $excelWorksheets.Add() 

        }   
    }

    Write-Host "[$($excelWorksheets.Count)] sheets created!"

    #set $i as the value of how many worksheets we have
    $i = $excelWorksheets.Count

    #Loop until $i = 0 so that we can rename the sheets in the order we have set in the array
    #I use -1 for the worksheets index, as arrays in PowerShell start with 0, not 1
    do {

        $excelWorksheets.Item($i).Name = $worksheets[$i-1]         

        Write-Host "Sheet [$i] is now named [$($worksheets[$i-1])]..."

        $i--
        
    } 
    while (

        $i -ne 0

    )
    
    #Example of using the imported CSV for sheet 1
    $worksheet      = $excelWorksheets.Item(1)
    $StartRowNum    = 1
    $StartColumnNum = 1
    $EndRowNum      = $data.Count + 1
    $EndColumnNum   = ($data | Get-Member | Where-Object { $_.MemberType -eq 'NoteProperty' }).Count
    $Range          = $worksheet.Range($worksheet.Cells($StartRowNum, $StartColumnNum), $worksheet.Cells($EndRowNum, $EndColumnNum))
    $Range.Value2   = $MultiArray

    $worksheet.UsedRange.EntireColumn.AutoFit()
    $worksheet.CellFormat.ShrinkToFit

    Write-Host "Added data from csv file to the first sheet..."

    #Save workbook
    $workbook.SaveAs($fileName,51)    
    $workbook.Saved = $true

    Write-Host "Excel file saved to -> [$fileName]!"

}
catch {

    $errorMessage = $_.Exception.Message
    Write-Error "Error setting up spreadsheet -> [$errorMessage]!"

}
finally {

    $excelObject.Quit()
    
    Write-Host "Excel object cleaned up!"
    
}
