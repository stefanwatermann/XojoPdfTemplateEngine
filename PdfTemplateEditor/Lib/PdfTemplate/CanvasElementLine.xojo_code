#tag Class
Protected Class CanvasElementLine
Inherits CanvasElement
Implements PdfTemplate.ICanvasElement
	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.Size = 1
		  Self.DrawingColor = Color.Black
		  Self.WidthMm = 100
		  Self.Xmm = 10
		  Self.Ymm = 10
		  Init
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(xmm as integer, ymm as integer, wmm as integer, size as integer = 1, c as Color = &c000000)
		  Self.Xmm = xmm
		  Self.Ymm = ymm
		  Self.WidthMm= wmm
		  Self.DrawingColor = c
		  Self.Size = size
		  Init
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Draw(g as Graphics)
		  Self.Init
		  g.DrawingColor = Self.DrawingColor
		  g.PenSize = Self.Size
		  g.DrawLine(Self.Xpx, Self.Ypx, Self.Xpx + Self.WidthPx, Self.Ypx)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromString(s as string) As CanvasElementLine
		  Var e As New CanvasElementLine
		  e.Xmm = s.NthField(",", 1).Trim.ToInteger
		  e.Ymm = s.NthField(",", 2).Trim.ToInteger
		  e.WidthMm = s.NthField(",", 3).Trim.ToInteger
		  e.Size = s.NthField(",", 4).Trim.ToInteger
		  e.DrawingColor = Color.FromString(s.NthField(",", 5))
		  Return e
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Init()
		  Self.Heigth = Self.Size
		  Self.pBounds = New Rect(Self.Xpx, Self.Ypx - 1, Self.WidthPx + Self.Size, Self.Heigth + 2)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  return "Line:" + str(Self.Xmm) + "," + str(Self.Ymm) + "," + str(Self.WidthMm) + "," + str(Self.Size) + "," + Self.DrawingColor.ToString
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		DrawingColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		Size As Integer
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
			Name="Size"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DrawingColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
