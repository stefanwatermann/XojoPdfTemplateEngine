#tag Class
Protected Class PdfFont
	#tag Method, Flags = &h0
		Shared Function FromString(fontDef as string) As PdfFont
		  Var f As New PdfFont
		  f.Name = fontDef.NthField(",", 1).Trim
		  f.FontName = fontDef.NthField(",", 2).Trim
		  f.Size = fontDef.NthField(",", 3).ToInteger
		  f.DrawingColor = Color.FromString(fontDef.NthField(",", 4))
		  
		  If fontDef.CountFields(",") >= 5 Then
		    f.Bold = Boolean.FromString(fontDef.NthField(",", 5).Trim)
		  End
		  
		  If fontDef.CountFields(",") >= 6 Then
		    f.Italic = Boolean.FromString(fontDef.NthField(",", 6).Trim)
		  End
		  
		  If fontDef.CountFields(",") = 7 Then
		    f.Underlined = Boolean.FromString(fontDef.NthField(",", 7).Trim)
		  End
		  
		  Return f
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  Return "FontDef:" + Self.Name + "," + Self.FontName + "," + Str(Self.Size) + "," + Self.DrawingColor.ToString + "," + str(Self.Bold) + "," + str(Self.Italic) + "," + str(Self.Underlined)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Bold As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		DrawingColor As Color
	#tag EndProperty

	#tag Property, Flags = &h0
		FontName As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Italic As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		Name As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Size As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Underlined As Boolean
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
			Name="DrawingColor"
			Visible=false
			Group="Behavior"
			InitialValue="&c000000"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontName"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="Bold"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Italic"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Underlined"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
