Set fso=CreateObject("Scripting.FileSystemObject")
'Set oArgs = WScript.Arguments
Set objShell = CreateObject("Wscript.Shell")

objShell.Run "gvim.bat "&fso.GetFolder(".").Path&"/"&fso.GetBaseName(fso.GetFolder(".").Path)&".exvim"

