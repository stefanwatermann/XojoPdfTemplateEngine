#tag Class
Protected Class PdfHelper
	#tag Method, Flags = &h1
		Protected Sub AddLine(mmX as integer, mmY as integer, mmW as Integer)
		  PdfDoc.Graphics.DrawLine(Mm2PixelX(mmX), Mm2PixelY(mmY), Mm2PixelX(mmX + mmW), Mm2PixelY(mmY))
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AddText(mmX as integer, mmY as integer, mmW as integer, t as string, alignRight as boolean = false)
		  If alignRight Then
		    Var w As Double = PdfDoc.Graphics.TextWidth(t)
		    PdfDoc.Graphics.DrawText(t, Mm2PixelX(mmX) - w, Mm2PixelY(mmY), Mm2PixelX(mmW))
		  Else
		    PdfDoc.Graphics.DrawText(t, Mm2PixelX(mmX), Mm2PixelY(mmY), Mm2PixelX(mmW))
		  End
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AddTextLines(mmX as integer, mmY as integer, lines() as string)
		  Var lh As Integer = 0
		  For Each line As String In lines
		    PdfDoc.Graphics.DrawText(line, Mm2PixelX(mmX), Mm2PixelY(mmY) + lh)
		    lh = lh + LineHeight
		  Next
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AddTextLines(mmX as integer, mmY as integer, ParamArray lines as string)
		  Var s() As String
		  For Each line As String In lines
		    s.add(line)
		  Next
		  AddTextLines(mmx, mmy, s)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AddTextLines(mmX as integer, mmY as integer, lines as variant)
		  Var s() As String
		  Var l() As String = lines
		  For Each line As String In l
		    s.add(line)
		  Next
		  AddTextLines(mmx, mmy, s)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub CreateA4PdfDoc()
		  Self.mPdfDoc = New PDFDocument(PDFDocument.PageSizes.A4)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DrawElements(elems() as PdfTemplate.CanvasElement, params as Dictionary = nil)
		  Var g As PDFGraphics = Self.PdfDoc.Graphics
		  
		  // Elemente
		  For Each e As CanvasElement In elems
		    
		    // Element Text
		    If e IsA CanvasElementText Then
		      Var te As CanvasElementText = CanvasElementText(e)
		      g.DrawingColor = te.FontDef.DrawingColor
		      g.FontSize = te.FontDef.Size
		      g.FontName = te.FontDef.FontName
		      g.Bold = te.FontDef.Bold
		      g.Italic = te.FontDef.Italic
		      g.Underline = te.FontDef.Underlined
		      g.DrawText(ReplaceVariables(te.Text, params), Mm2PixelX(te.Xmm), Mm2PixelY(te.Ymm) + g.FontSize)
		    End
		    
		    // Element Line
		    If e IsA CanvasElementLine Then
		      Var te As CanvasElementLine = CanvasElementLine(e)
		      g.DrawingColor = te.DrawingColor
		      g.PenSize = te.Size
		      g.DrawLine(Mm2PixelX(te.Xmm), Mm2PixelX(te.Ymm), Mm2PixelX(te.Xmm + te.WidthMm), Mm2PixelX(te.Ymm))
		    End
		    
		    // Element Picture
		    If e IsA CanvasElementPicture Then
		      Var te As CanvasElementPicture = CanvasElementPicture(e)
		      g.DrawPicture(te.Pic, Mm2PixelX(te.Xmm), Mm2PixelX(te.Ymm), Mm2PixelX(te.WidthMm), Mm2PixelX(PdfService.PxToMm(te.Heigth)), 0, 0, te.Pic.Width, te.pic.Height)
		    End
		    
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub DrawGrid()
		  Var g As PDFGraphics = PdfDoc.Graphics
		  
		  Var mmDist As Integer = Self.GridSizeMm
		  Var mmX As Integer = mmDist
		  Var mmY As Integer = mmDist
		  
		  g.DrawingColor = &cA9A9A900
		  g.LineDash = Array(3.0, 3.0)
		  g.PenSize = 0.5
		  g.FontSize = 6
		  
		  // vertical
		  While Mm2PixelX(mmX) < g.Width
		    g.DrawText(Str(mmX), Mm2PixelX(mmX), 20)
		    g.DrawLine(Mm2PixelX(mmX), 0, Mm2PixelX(mmx), g.Height)
		    mmX = mmX + mmDist
		  Wend
		  
		  // horizontal
		  While Mm2PixelY(mmY) < g.Height
		    g.DrawText(Str(mmY), 20, Mm2PixelX(mmY))
		    g.DrawLine(0, Mm2PixelY(mmY), g.Width, Mm2PixelY(mmY))
		    mmY = mmY + mmDist
		  Wend
		  
		  // rest line style
		  g.DrawingColor = Color.Black
		  g.LineDash = Nil
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Mm2PixelX(mm as integer) As integer
		  return mm * PdfDoc.PageWidth / kPageWidthMm
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Mm2PixelY(mm as integer) As integer
		  return mm * PdfDoc.PageHeight / kPageHeightMm
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ReplaceVariables(t as string, params as Dictionary) As String
		  If params <> Nil Then
		    For Each key As String In params.Keys
		      t = t.ReplaceAll("%" + key, params.Value(key).StringValue)
		    Next
		  End
		  
		  Return t
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetColor(c as Color)
		  PdfDoc.Graphics.DrawingColor = c
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub SetFontSize(size as integer)
		  PdfDoc.Graphics.FontSize = size
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected CaptionFontSize As Integer = 20
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected DefaultColor As Color = &c000000
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected DefaultFontSize As Integer = 12
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected GridSizeMm As Integer = 5
	#tag EndProperty

	#tag ComputedProperty, Flags = &h1
		#tag Getter
			Get
			  return PdfDoc.Graphics.FontSize * 1.1
			End Get
		#tag EndGetter
		Protected LineHeight As Integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mPdfDoc As PDFDocument
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mPdfDoc
			End Get
		#tag EndGetter
		PdfDoc As PDFDocument
	#tag EndComputedProperty


	#tag Constant, Name = kPageHeightMm, Type = Double, Dynamic = False, Default = \"298", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kPageWidthMm, Type = Double, Dynamic = False, Default = \"213", Scope = Private
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
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
