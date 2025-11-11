#tag Module
 Attributes ( "@Guid" = "8718C324-863E-4ADC-95CA-EBCCD7FE6717", "@Version" = "1.0", "@Copyright" = "(c)2025 Stefan Watermann", "@Description" = "MessageDialog Wrapper" ) Protected Module MessageAskBox
	#tag Method, Flags = &h0
		Function Show(caption as string, message as string, icon as MessageDialog.IconTypes) As Integer
		  Var d As New MessageDialog                
		  d.IconType = icon 
		  d.ActionButton.Caption = caption
		  d.CancelButton.Visible = True        
		  d.Message = message
		  
		  Var b As MessageDialogButton  = d.ShowModal
		  
		  Select Case b  
		    
		  Case d.ActionButton
		    Return 1
		    
		  Else
		    Return 0
		    
		  End Select
		  
		End Function
	#tag EndMethod


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
	#tag EndViewBehavior
End Module
#tag EndModule
