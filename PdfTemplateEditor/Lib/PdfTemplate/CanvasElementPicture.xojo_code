#tag Class
Protected Class CanvasElementPicture
Inherits CanvasElement
Implements PdfTemplate.ICanvasElement
	#tag Method, Flags = &h0
		Sub Constructor()
		  Self.Pic = Nil
		  Self.WidthMm = 100
		  Self.Xmm = 10
		  Self.Ymm = 10
		  Init
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(xmm as integer, ymm as integer, wmm as integer, pic as Picture)
		  Self.Xmm = xmm
		  Self.Ymm = ymm
		  Self.WidthMm= wmm
		  Self.Pic = pic
		  Init
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Draw(g as Graphics)
		  Self.Init
		  g.DrawPicture(self.Pic, Self.Xpx, Self.Ypx, self.WidthPx, self.Heigth, 0, 0, self.Pic.Width, self.pic.Height)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Shared Function FromString(s as string) As CanvasElementPicture
		  Var e As New CanvasElementPicture
		  e.Xmm = s.NthField(",", 1).Trim.ToInteger
		  e.Ymm = s.NthField(",", 2).Trim.ToInteger
		  e.WidthMm = s.NthField(",", 3).Trim.ToInteger
		  e.Pic = Picture.FromData(DecodeBase64(s.NthField(",", 4).Trim))
		  Return e
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Init()
		  If Self.Pic <> Nil Then
		    Self.Heigth = Self.Pic.Height * self.WidthPx / Self.Pic.Width
		  Else
		    Self.Heigth = 50
		  End
		  
		  Self.pBounds = New Rect(Self.Xpx, Self.Ypx - 1, Self.WidthPx, Self.Heigth)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  Var data As String = EncodeBase64(Self.Pic.ToData(Picture.Formats.JPEG, 80), 0)
		  Return "Picture:" + Str(Self.Xmm) + "," + Str(Self.Ymm) + "," + Str(Self.WidthMm) + "," + data
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Pic As Picture
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
			Name="Pic"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Picture"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
