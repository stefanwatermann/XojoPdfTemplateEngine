#tag Class
Protected Class CanvasElementText
Inherits CanvasElement
Implements PdfTemplate.ICanvasElement
	#tag Method, Flags = &h0
		Sub Constructor()
		  Using PdfTemplate
		  
		  Var defaultFonts() As PdfFont = PdfTemplate.PdfService.GetDefaultFonts()
		  Self.FontDef = defaultFonts(0)
		  Self.Text = "Text"
		  Init()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(xmm as integer, ymm as integer, fontDef as PdfTemplate.PdfFont, text as string)
		  Using PdfTemplate
		  
		  Self.Xmm = xmm
		  Self.Ymm = ymm
		  Self.Text = Text
		  Self.FontDef = fontDef
		  
		  Init()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Draw(g as Graphics)
		  Self.Init
		  g.DrawingColor = Self.FontDef.DrawingColor
		  g.FontSize = Self.FontDef.Size
		  g.FontName = Self.FontDef.FontName
		  g.Bold = Self.FontDef.Bold 
		  g.Italic = Self.FontDef.Italic
		  g.Underline = self.FontDef.Underlined
		  g.DrawText(Self.Text, Self.Xpx, Self.Ypx + g.FontSize)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromString(s as string, fontDefs() as PdfFont) As CanvasElementText
		  Var e As New CanvasElementText
		  e.Text = s.Middle(s.IndexOf("""")).Trim("""").ReplaceAll(kEndOfLineMarker, EndOfLine)
		  
		  Var m As String = s.Left(s.Length - e.Text.Length)
		  
		  If m.CountFields(",") = 4 Then
		    e.FontDef = PdfTemplate.PdfService.GetFontDef(s.NthField(",", 1).Trim, fontDefs)
		    e.Xmm = s.NthField(",", 2).Trim.ToInteger
		    e.Ymm = s.NthField(",", 3).Trim.ToInteger
		  End
		  
		  If m.CountFields(",") = 5 Then
		    e.FontDef = PdfTemplate.PdfService.GetFontDef(s.NthField(",", 1).Trim, fontDefs)
		    e.Xmm = s.NthField(",", 2).Trim.ToInteger
		    e.Ymm = s.NthField(",", 3).Trim.ToInteger
		    e.Alignment = s.NthField(",", 4)
		  End
		  
		  Return e
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Init()
		  If Self.Text.Length > 0 Then
		    Var w As Integer = Self.Text.Length * Self.FontDef.Size * 0.5
		    Var h As Integer = Self.FontDef.Size * (Self.Text.CountFields(EndOfLine) + 1)
		    
		    Var p As New Picture(w,  h)
		    p.Graphics.FontName = Self.FontDef.FontName
		    p.Graphics.FontSize = Self.FontDef.Size
		    p.Graphics.FontUnit = FontUnits.Pixel
		    Var tw As Integer = p.Graphics.TextWidth(Self.Text) + 2
		    Var th As Integer = p.Graphics.TextHeight(Self.Text, tw)
		    
		    Self.WidthPx = tw
		    Self.Heigth = th 
		  End
		  
		  Self.pBounds = New Rect(Self.Xpx, Self.Ypx, Self.WidthPx, Self.Heigth)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  Return "Text:" + FontDef.Name + "," + Str(Xmm) + "," + Str(Ymm) + "," + Self.Alignment + ",""" + Self.Text.ReplaceAll(EndOfLine, kEndOfLineMarker) + """"
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Alignment As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mFontDef
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mFontDef = value
			  Init
			End Set
		#tag EndSetter
		FontDef As PdfTemplate.PdfFont
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mFontDef As PdfTemplate.PdfFont
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mText As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mText
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mText = value
			  Init
			End Set
		#tag EndSetter
		Text As String
	#tag EndComputedProperty


	#tag Constant, Name = kEndOfLineMarker, Type = String, Dynamic = False, Default = \"~#~", Scope = Protected
	#tag EndConstant


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
			Name="Text"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Alignment"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
