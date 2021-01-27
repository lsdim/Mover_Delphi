Dim Maildb 
Dim MailDoc
Dim Body 
Dim Session 


If WScript.Arguments.Count < 5 Then
   WScript.Echo "!!Ïîìèëêà!! ÍÅ ÂÊÀÇÀÍI ÎÁÎÂ'ßÇÊÎÂI ÀÐÃÓÌÅÍÒÈ."
   WScript.Quit 
End If




Dim strRecipients
Dim strCopyTORecipients
Dim strPassword
Dim  strDatabasePath

strPassword = WScript.Arguments(0)
strDatabasePath =  WScript.Arguments(1)
strRecipients = WScript.Arguments(4)
mask = WScript.Arguments(5)

Dim strDirectoryFilePath 

strDirectoryFilePath =  WScript.Arguments(2)

Dim Path
Path = WScript.Arguments(2)
   
   
Dim fso, folder, files, NewsFile,sFolder
  
  Set fso = CreateObject("Scripting.FileSystemObject")
  sFolder = Path
  If sFolder = "" Then
      Wscript.Echo "No Folder parameter was passed"
      Wscript.Quit
  End If
  
  Set folder = fso.GetFolder(sFolder)
  Set files = folder.Files



	Set Session = CreateObject("Lotus.NotesSession")


	Call Session.Initialize(strPassword)


	Set Maildb = Session.GETDATABASE("VOLYN_POSTLN/VOLYN_POST/Ukrpost/UA", strDatabasePath)
		If Not Maildb.IsOpen = True Then
	Call Maildb.Open
		End If



	Set MailDoc = Maildb.CREATEDOCUMENT
	Call MailDoc.ReplaceItemValue("Form", "Memo")

	Call MailDoc.ReplaceItemValue("SendTo",strRecipients)
	Call MailDoc.ReplaceItemValue("Subject", "Íàêëàäí³ ìàðáàçà")
	Set Body = MailDoc.CREATERICHTEXTITEM("Body")
	Call Body.APPENDTEXT("Ïðèêð³ëåíí³ ôàéëè")



  For each folderIdx In files

if instr(folderIdx.name, mask) and (maildoc.size+folderIdx.size)<2500000 then


	Call Body.ADDNEWLINE(2)

	Call Body.EMBEDOBJECT(1454, "",  Path & "\" & folderIdx.name, "Attachment")

 If WScript.Arguments(3) = "1" Then
	folderIdx.delete
 end if


end if
  Next
	
	If MailDoc.HasEmbedded then

	MailDoc.SAVEMESSAGEONSEND = True
	Call MailDoc.ReplaceItemValue("PostedDate", Now())
	Call MailDoc.SEND(False)

	end if


Set Maildb = Nothing
Set MailDoc = Nothing
Set Body = Nothing
Set Session = Nothing


'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''