#tag Class
Protected Class PdfService
	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.InitPdfTemplate
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ElemsToStringArray() As string()
		  Var s() As String
		  
		  For Each elem As CanvasElement In CanvasElements
		    s.Add(elem.ToString)
		  Next
		  
		  Return s
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FontDefsToStringArray() As String()
		  Var s() As String
		  
		  For Each elem As PdfFont In FontDefs
		    s.Add(elem.ToString)
		  Next
		  
		  Return s
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetDefaultFonts() As PdfTemplate.PdfFont()
		  Var fonts() As PdfFont
		  
		  Var n0 As New PdfFont
		  n0.Name = "N0"
		  n0.FontName = "Arial"
		  n0.Size = 12
		  fonts.Add(n0)
		  
		  Var n1 As New PdfFont
		  n1.Name = "N1"
		  n1.FontName = "Arial"
		  n1.Size = 10
		  fonts.Add(n1)
		  
		  Var h1 As New PdfFont
		  h1.Name = "H1"
		  h1.FontName = "Arial"
		  h1.Size = 18
		  fonts.Add(h1)
		  
		  Var h2 As New PdfFont
		  h2.Name = "H2"
		  h2.FontName = "Arial"
		  h2.Size = 15
		  fonts.Add(h2)
		  
		  Return fonts
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function GetFontDef(name as string, fontDefs() as PdfTemplate.PdfFont) As PdfFont
		  Using PdfTemplate
		  
		  For Each fntDef As PdfFont In fontDefs
		    If fntDef.Name = name Then
		      Return fntDef
		    End
		  Next
		  return nil
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InitPdfTemplate()
		  CanvasElements.RemoveAll
		  FontDefs.RemoveAll
		  
		  For Each fnt As PdfFont In GetDefaultFonts()
		    FontDefs.Add(fnt)
		  next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Load(f as FolderItem)
		  FontDefs.RemoveAll
		  CanvasElements.RemoveAll
		  
		  Var lines() As String = File.ReadAllLines(f)
		  
		  For Each line As String In lines
		    If Not line.Trim.BeginsWith("#") And line.Trim.Length > 0 Then
		      
		      // GridSize
		      If line.Trim.Lowercase.BeginsWith("gridsizemm:") Then
		        GridSizeMm = line.NthField(":", 2).Trim.ToInteger
		      End
		      
		      // FontDef
		      If line.Trim.Lowercase.BeginsWith("fontdef:") Then
		        Var fd As PdfFont = PdfFont.FromString(line.NthField(":", 2).Trim)
		        FontDefs.Add(fd)
		      End
		      
		      // Text
		      If line.Trim.Lowercase.BeginsWith("text:") Then
		        Var e As CanvasElementText = CanvasElementText.FromString(line.Middle(line.IndexOf(":")+1).Trim, FontDefs)
		        CanvasElements.Add(e)
		      End
		      
		      // Line
		      If line.Trim.Lowercase.BeginsWith("line:") Then
		        Var e As CanvasElementLine = CanvasElementLine.FromString(line.Middle(line.IndexOf(":")+1).Trim)
		        CanvasElements.Add(e)
		      End
		      
		      // Picture
		      If line.Trim.Lowercase.BeginsWith("picture:") Then
		        Var e As CanvasElementPicture = CanvasElementPicture.FromString(line.Middle(line.IndexOf(":")+1).Trim)
		        CanvasElements.Add(e)
		      End
		      
		    End
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function MmToPx(mm as integer) As Integer
		  return Round(mm * 72 / 25.4)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function PxToMm(px as Integer) As Integer
		  return Round(px * 25.4 / 72)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveCanvasElement(elem as CanvasElement)
		  Var i As Integer = -1
		  For Each e As CanvasElement In CanvasElements
		    i = i + 1
		    If e = elem Then
		      Exit
		    End
		  Next
		  
		  If i >= 0 Then
		    CanvasElements.RemoveAt(i)
		  End
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RemoveFontDef(name as string)
		  Var i As Integer = -1
		  For Each fnt As PdfFont In FontDefs
		    i = i + 1
		    If fnt.Name = name Then
		      Exit
		    End
		  Next
		  
		  If i >= 0 Then
		    FontDefs.RemoveAt(i)
		  end
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Save(f as FolderItem)
		  Var lines() As String
		  
		  lines.Add("### Raster-based PDF template ###")
		  lines.Add("# One command per line, # indicated comment.")
		  lines.Add("")
		  
		  lines.Add("### File Version ###")
		  lines.Add("FileVersion: " + FileVersion)
		  lines.Add("")
		  
		  lines.Add("### Raster Size ###")
		  lines.Add("GridSizeMm: " + Str(GridSizeMm))
		  lines.Add("")
		  
		  lines.Add("### Font Definitions ###")
		  lines.Add("# FontDef: <Name:String>, <FontName:String>, <Size:number>[, <FontColor:Color>, <Bold:bool>, <Italic:bool>, <Underline:bool>]")
		  For Each s As String In FontDefsToStringArray
		    lines.Add(s)
		  Next
		  lines.Add("")
		  
		  lines.Add("### Content ###")
		  lines.Add("# Text: <FontDef:String>, <X:int>, <Y:int>, <Alignment:Alignment>, <""Content"">")
		  lines.Add("# Image: <X:int>, <Y:int>, <Width:int>, <JPEG Data Base64 encoded>")
		  lines.Add("# Line: <X:int>, <Y:int>, <Width:int>, <Size:int>, <Drawingcolor:Color>")
		  For Each s As String In ElemsToStringArray
		    lines.Add(s)
		  Next
		  lines.Add("")
		  
		  File.WriteAllLines(f, lines)
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		CanvasElements() As CanvasElement
	#tag EndProperty

	#tag Property, Flags = &h21
		Private FileVersion As String = "1.0"
	#tag EndProperty

	#tag Property, Flags = &h0
		FontDefs() As PdfFont
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mGridSizeMm
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mGridSizeMm = value
			End Set
		#tag EndSetter
		GridSizeMm As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return MmToPx(mGridSizeMm)
			End Get
		#tag EndGetter
		GridSizePx As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mGridSizeMm As Integer = 5
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="GridSizePx"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="GridSizeMm"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
