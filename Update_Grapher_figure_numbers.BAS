'' Update_Grapher_figure_numbers.BAS - Update the Figure number to match Figure Number in Filename
'  Visual Basis script, used by the Grapher's "Scripter" interpreter.
'
'' Written by Miles McCammon (c) 2021-2022 for Stetson Engineers
'
'  What this does is:
'  1) open up existing Grapher files (.grf), 
'  2) detects the file name of the script (with the correct figure number),
'  3) modifies the text corresponding to the Figure number (see USGAGE in git project)
'  4) saves the .grf project
'
'  Exporting results to images or other file format is left to other scripts.
'
' Please note GRAPHER's Object Manager counts starting at 1, and 
' counts from the bottom up


' This is for changing the figure number
Function Update_figure_number(directory As String, short_filename As String, Grapher As Object) As Integer
	Set file = Grapher.Documents.Open(directory & short_filename )

	Set  file_figure = Mid(short_filename, 9, 4)
	Debug.Print file_figure


	Debug.Print short_filename & ": Change to FIGURE " & file_figure

	Dim file_info As String
	file_info = file.FullName & " " & Month(Date) & "/" & Day(Date) & "/" & Year(Date)

	'Get the figure number text
	'Shape number is counted from the bottom

	'Define object pointer
	Set FormatItems = file.Shapes.Item(1)
	'Define object pointer
	Set FigureNumber = FormatItems.Shapes.Item(5)

	FigureNumber.text = "FIGURE "& file_figure

	file.Close()
End Function

' Iterate through folder, and run actions
Sub UpdateFolder(folderPath As String, Grapher As Object)
   Dim filename As String
   
   If Right(folderPath, 1) <> "\" Then folderPath = folderPath + "\"    
    filename = Dir(folderPath & "*.grf")
    Do While filename <> ""

		Update_figure_number(folderPath,filename, Grapher)
        filename = Dir
    Loop

End Sub


Sub Main
	Debug.Clear
	Debug.Print "Update Figure numbers text in Grapher files to match filenames."
	Debug.Print "Script written by Miles McCammon for Stetson Engineers (c) 2021-2022."
	Debug.Print "Run on " & Month(Date) &"/"& Day(Date) &"/"& Year(Date)

	'Create Grapher as an Object
	Dim Grapher As Object

	'Start Grapher
	Set Grapher = CreateObject("Grapher.Application")

	' Hide Grapher while operating
	' Leaving application visible will rapidly open/close items
	Grapher.Visible = False


	Dim spreadsheet_dir
	Set wshell = CreateObject("WScript.Shell")
	Debug.Print wshell.CurrentDirectory
	spreadsheet_dir = wshell.CurrentDirectory
	
	Call UpdateFolder(spreadsheet_dir , Grapher)
	
	' Otherwise you have to close it through Windows Task Manager
	Grapher.Visible = True	
End Sub
