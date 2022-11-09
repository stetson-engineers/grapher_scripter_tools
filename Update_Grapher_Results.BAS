'' Update_Grapher_Results.BAS - (Re)generate PDFs for Grapher files in this directory
'  Visual Basis script, used by the Grapher's "Scripter" interpreter.
'
'' Written by Miles McCammon (c) 2014-2022 for Stetson Engineers
'
'	What this does is open up existing Grapher files (.grf), and exports a png copy (.png) of them
'	in the same directory.
'
'	For called out 11x17 graphs it puts the current Month and Year, and then exports a 11x17 .pdf copy.
'
'	This is in Visual Basic (for Grapher's "Scripter" function). There probably are more elegant ways to do this.
'
'
''	Note: Array_size should be 1 less than the number of elements in the array

' This is the function for exporting .png files
' Function Export_eps_png(directory As String, short_filename As String, Grapher As Object) As Integer
	' Set file = Grapher.Documents.Open(directory & short_filename)
	' ' & ".grf")
	
	' Debug.Print short_filename & ": Exporting to PNG format"
	
	' short_filename = Left(short_filename, Len(short_filename) - 4)
	
	' 'Export objects to specified file
	' file.Export(directory & short_filename &".png",False, "ColorDepth=32;ColorReductionMethod=5;ExportImageFormatBGR24=1;ExportImageFormatBGRA32=1;ExportImageFormatIndexed1=1;ExportImageFormatIndexed4=1;ExportImageFormatIndexed8=1;HDPI=300;Height=1044;KeepAspect=1;VDPI=300;Width=1890")
	
	' 'EPS file - note size is different than for the pumping files
	' 'file.Export(directory & short_filename &".eps",False,"ColorDepth=24;ColorReductionMethod=5;ExportImageFormatBGR24=1;HDPI=182;Height=633;KeepAspect=1;PreviewColor=1;PreviewSize=1;PreviewType=2;VDPI=182;Width=1146")
	' 'Export objects to specified file
	' file.Close()
' End Function


' This is for adding the Date and Exporting the 8.5x11 vector PDF (Portrait Letter size) figures
Function Export_8p5x11_pdf_with_date(directory As String, short_filename As String, Grapher As Object) As Integer
	Set file = Grapher.Documents.Open(directory & short_filename )

	Debug.Print short_filename & ": Exporting to PDF"

	Dim file_info As String
	file_info = file.FullName & " " & Month(Date) & "/" & Day(Date) & "/" & Year(Date)

	' Un-comment the following to automatically add the update information to the
	' Resulting file as a text object
	' Create a text object (this is to go along with the path information)
	
	' Set exp_date = file.Shapes.AddText(0.5,7.890, Replace$(file_info,"\","/"), "Path Info")
	' Note: For some unknown reason the '\' character seems not to work here

	' exp_date.Font.face = "Arial"
	' exp_date.Font.color = grfColorBlack
	' exp_date.Font.Opacity = 100
	' exp_date.Font.size = 6
	' exp_date.Font.Bold = False
	' exp_date.Font.Italic = False
	' exp_date.Font.StrikeThrough = False
	' exp_date.Font.Underline = False
	' exp_date.Font.Justification = grfAlignCenter
	' exp_date.Font.HAlign = 1
	' exp_date.Font.VAlign = 1

	file.Export2(directory & Left(short_filename,Len(short_filename)-4) &".pdf",False,"ExportImageFormatBGR24=1;FileLLX=0;FileLLY=0;FileURX=8.5;FileURY=11;MaxBitmapSizeInMB=10;PageLLX=0;PageLLY=0;PageURX=8.5;PageURY=11;SaveScalingInfo=0;ScalingSource=1",False,"pdfv")

'	exp_date.Delete

	file.Close()
End Function


' Iterate through folder, and run actions
Sub UpdateFolder(folderPath As String, Grapher As Object)
   Dim filename As String
   
   If Right(folderPath, 1) <> "\" Then folderPath = folderPath + "\"
    
    
    filename = Dir(folderPath & "*.grf")
    Do While filename <> ""
		' Call Export_eps_png(folderPath,filename, Grapher)
		Export_8p5x11_pdf_with_date(folderPath,filename, Grapher)        
        filename = Dir
    Loop
End Sub


Sub Main
	Debug.Clear
	Debug.Print "Script written by Miles McCammon for Stetson Engineers (c) 2014-2022."
	Debug.Print "Run on " & Month(Date) &"/"& Day(Date) &"/"& Year(Date)

	'Create Grapher as an Object
	Dim Grapher As Object

	'Start Grapher
	Set Grapher = CreateObject("Grapher.Application")

	Grapher.Visible = False

	Dim vaMyArray
	Dim directory
	Dim iii As Long

	Dim spreadsheet_dir
	
	Set wshell = CreateObject("WScript.Shell")
	Debug.Print wshell.CurrentDirectory
	spreadsheet_dir = wshell.CurrentDirectory
	
	
	Call UpdateFolder(spreadsheet_dir , Grapher)
	
	' Leave Grapher visible, so that it is easy to close
	' Otherwise you have to close it through Windows Task Manager
	Grapher.Visible = True
	
End Sub
