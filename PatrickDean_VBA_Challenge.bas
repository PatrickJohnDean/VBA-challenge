Sub Data_Compiler_Alphabetical()
    
'Create a variable for the current Worksheet

    Dim ws As Worksheet
    
'Start a For loop to loop through each Worksheet in the Workbook

    For Each ws In ThisWorkbook.Worksheets
    
'Add appropriate headers for the Summary Table'
    
    ws.Range("I1").Value = "Ticker"
    ws.Range("J1").Value = "Yearly Change"
    ws.Range("K1").Value = "Percent Change"
    ws.Range("L1").Value = "Total Stock Volume"
    
' Setup location for the data to be added to the summary table
    
    Dim Summary_Table_Row As Integer
    Summary_Table_Row = 2
  
'Create a variable for the desired data range'
    
    Dim Last_Row As Variant
    Last_Row = ws.Cells(Rows.Count, 1).End(xlUp).Row

'Create i to loop through the desired data range'
    
    For i = 2 To Last_Row

'Create a variable for the Ticker Symbols
    
    Dim Ticker_Sym As String

'Loop Through the Ticker Symbols checking if we are still within the same Ticker Symbol, if we are not...
    
    If ws.Cells(i + 1, 1).Value <> Cells(i, 1).Value Then

'Set the Ticker Symbol Value
    
    Ticker_Sym = ws.Cells(i, 1).Value
    
'Add the Ticker Symbols to the Summary Table
    
    ws.Range("I" & Summary_Table_Row).Value = Ticker_Sym
    
' Create a variable for the Starting Stock Price
    
    Dim Start_Price As Variant
    
'Create a variable for the Ending Stock Price
    
    Dim End_Price As Variant
    
' Create a variable for the Yearly Stock Price Change
    
    Dim Yearly_Change As Variant
    
' Set the Starting Stock Price Value
    
    Start_Price = ws.Cells(i, 3).Value
    
' Set the Ending Stock Price Value
    
    End_Price = ws.Cells(i, 6).Value
    
'Calculate the Yearly Change
    
    Yearly_Change = End_Price - Start_Price
    
'Add the Yearly Stock Price Change to the Summary Table
    
    ws.Range("J" & Summary_Table_Row).Value = Yearly_Change
    
'Color Code Yearly Change Column
    
    If (Yearly_Change > 0) Then
    ws.Range("J" & Summary_Table_Row).Interior.ColorIndex = 4

    ElseIf (Yearly_Price_Change <= 0) Then
    ws.Range("J" & Summary_Table_Row).Interior.ColorIndex = 3

    End If
   
'Create a variable for the Yearly Percent Change from the opening price at the start of the year to the closing price at the end year.
    
    Dim Percent_Change As Variant
    
'Calculate the Yearly Percent Change Adjusting if the opening price was zero
    
    If Start_Price <> 0 Then
    Percent_Change = (Yearly_Change / Start_Price)
    End If
    
    Percent_Change = FormatPercent(Percent_Change, [2])
    
'Add thePercent Change to the Summary Table
    
    ws.Range("K" & Summary_Table_Row).Value = Percent_Change
    
' Create a variable for the Total Stock Volume and set initial value to zero
    
    Dim Total_Volume As Variant
    Total_Volume = 0
    
'Calculate the Total Stock Volume
    
    Total_Volume = Total_Volume + ws.Cells(i, 7).Value
    
'Add the Total Stock Volume to the Summary Table
    
     ws.Range("L" & Summary_Table_Row).Value = Total_Volume
    
' Add one to the summary table row
    
    Summary_Table_Row = Summary_Table_Row + 1

    End If

'Create Headers for Calculated Values Table

    ws.Range("P2").Value = "Greatest % Increase"
    ws.Range("P3").Value = "Greatest % Decrease"
    ws.Range("P4").Value = "Greatest Total Volume"
    ws.Range("Q1").Value = "Ticker"
    ws.Range("R1").Value = "Value"
    
'Calculate the Greatest Percentage Increase

    If (Percent_Change > Max_Percent) Then
    Max_Percent = Percent_Change
    Max_Percent_Ticker = Ticker_Sym
    End If

'Calculate the Greatest Percentage Decrease

    If (Percent_Change < Min_Percent) Then
    Min_Percent = Percent_Change
    Min_Percent_Ticker = Ticker_Sym
    End If
    
'Calculate the Greatest Total Volume
    
    If (Total_Volume > Max_Volume) Then
    Max_Volume = Total_Volume
    Max_Volume_Ticker_Sym = Ticker_Sym
    
    End If

'Add the Values with Ticker Symbol to the Calculated Values Table
    
    ws.Range("Q2").Value = Max_Percent_Ticker
    ws.Range("R2").Value = Max_Percent
    ws.Range("Q3").Value = Min_Ticker_Sym
    ws.Range("R3").Value = Min_Percent
    ws.Range("Q4").Value = Max_Volume_Ticker_Sym
    ws.Range("R4").Value = Max_Volume
    
    Next i

'Adjust column widths for legibility
    
    ws.Columns("I:R").AutoFit

Next ws

End Sub
