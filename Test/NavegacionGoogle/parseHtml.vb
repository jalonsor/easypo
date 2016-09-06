''http://www.freevbcode.com/ShowCode.asp?ID=8701

Option Explicit
Public Sub GetAllTags(sHtml As String, ByRef sArray() As String)
	Dim Pos1 As Long
	Dim Pos2 As Long
	Dim ub As Long
	ReDim sArray(0)

	Do
	Pos1 = InStr(Pos2 + 1, sHtml, "<")
	Pos2 = InStr(Pos1 + 1, sHtml, ">")
			If (Pos1 < 1) Or (Pos2 < 1) Then Exit Do
			ub = UBound(sArray)
			sArray(ub) = Mid$(sHtml, Pos1, Pos2 - Pos1 + 1)
			ReDim Preserve sArray(ub + 1)
	Loop
	If ub > 0 Then ReDim Preserve sArray(ub)
End Sub

Public Function GetTagType(Tag As String) As String
	Dim Pos As Integer

	If Tag = vbNullString Then Exit Function

	Pos = InStr(1, Tag, " ")
	If Pos < 1 Then Pos = Len(Tag)
	GetTagType = LCase$(Mid$(Tag, 2, Pos - 2))
End Function

Public Function GetTagAttrValue(Tag, Attr As String) As String '//<a href=> href is the attr
	Dim Pos As Long
	Dim Pos2 As Long
	Dim Sep As String

	Attr = " " & Attr '//An atribute is always prefixed with a space
	Pos = InStr(1, LCase$(Tag), LCase$(Attr))

	If Pos < 1 Then Exit Function '// ATTR NOT FOUND___
	Pos = Pos + Len(Attr) '//Move forward to the end of attr

	Do
		Sep = Mid$(Tag, Pos, 1)
		Pos = Pos + 1
	Loop While (Sep = " ") Or (Sep = "=")

	Select Case Sep
		Case "'"
		Pos2 = InStr(Pos + 1, Tag, "'")
		If Pos2 = 0 Then Exit Function
		GetTagAttrValue = Mid$(Tag, Pos, Pos2 - Pos)
		
		Case Chr(34)
		Pos2 = InStr(Pos + 1, Tag, Chr(34))
		If Pos2 = 0 Then Exit Function
		GetTagAttrValue = Mid$(Tag, Pos, Pos2 - Pos)
		
		Case Else 'sep is " ", or ">"
		Pos2 = InStr(Pos + 1, Tag, " ")
		If Pos2 < 1 Then Pos2 = Len(Tag) - 1 '//if no space is found, the end='>', thats always on  the end so len is faster
		GetTagAttrValue = Mid$(Tag, Pos - 1, Pos2 - Pos + 1)
		
	End Select
End Function

Private Sub Form_Load()
    MsgBox GetTagAttrValue("<h1 align='center'>", "align")
    MsgBox GetTagType("<h1 align='center'>")
End Sub