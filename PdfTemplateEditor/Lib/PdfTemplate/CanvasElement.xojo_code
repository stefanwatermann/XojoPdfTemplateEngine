#tag Class
Protected Class CanvasElement
	#tag Method, Flags = &h0
		Sub Constructor(xmm as integer, ymm as integer, wmm as integer, h as integer)
		  Self.Xmm = xmm
		  Self.Ymm = ymm
		  Self.WidthMm = wmm
		  Self.Heigth = h
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetBounds() As Rect
		  return pBounds
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  return ""
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Heigth As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mWidthPx As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mXpx As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mYpx As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected pBounds As Rect
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return PdfTemplate.PdfService.PxToMm(mWidthPx)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mWidthPx = PdfTemplate.PdfService.MmToPx(Value)
			End Set
		#tag EndSetter
		WidthMm As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mWidthPx
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mWidthPx = value
			End Set
		#tag EndSetter
		WidthPx As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return PdfTemplate.PdfService.PxToMm(mXpx)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mXpx = PdfTemplate.PdfService.MmToPx(Value)
			End Set
		#tag EndSetter
		Xmm As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mXpx
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mXpx = value
			End Set
		#tag EndSetter
		Xpx As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return PdfTemplate.PdfService.PxToMm(mYpx)
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mYpx = PdfTemplate.PdfService.MmToPx(value)
			End Set
		#tag EndSetter
		Ymm As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mYpx
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mYpx = value
			End Set
		#tag EndSetter
		Ypx As Integer
	#tag EndComputedProperty


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
			Name="Heigth"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Ymm"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Xmm"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Xpx"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Ypx"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="WidthPx"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="WidthMm"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
