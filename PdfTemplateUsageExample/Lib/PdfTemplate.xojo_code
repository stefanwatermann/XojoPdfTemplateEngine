#tag Module
 Attributes ( "@Guid" = "27DECCB5-0ABE-4BFD-A853-3643EDF20F17", "@Version" = "1.0.1", "@Copyright" = "(c)2025 Stefan Watermann", "@Description" = "PDF Dateien auf Basis von PDF Templates erzeugen." ) Protected Module PdfTemplate
	#tag Method, Flags = &h1
		Protected Sub ExampleHowToCreatePdf()
		  // create dictionary with variables to be replaced
		  Var varsDict As New Dictionary
		  varsDict.Value("CustomerName") = "Stefan"
		  varsDict.Value("InvoiceNr") = "2025/001-34"
		  varsDict.Value("OrderDate") = DateTime.Now
		  
		  // load template file
		  Var pdfSvc As New PdfService
		  pdfSvc.Load(New FolderItem("template-file.ptf"))
		  
		  // render PDF
		  Var helper As New PdfHelper
		  helper.CreateA4PdfDoc
		  helper.DrawElements(pdfSvc.CanvasElements, varsDict)
		  
		  // output pdf
		  Var f As FolderItem = SpecialFolder.Temporary.Child("tmp.pdf")
		  File.WriteAllBytes(f, helper.PdfDoc.ToData)
		End Sub
	#tag EndMethod


	#tag Note, Name = History
		v1.0.1 - 2025-11-11
		-------------------
		Fix wrong parsing of comma for text-fields
		Example method "ExampleHowToCreatePdf" added
	#tag EndNote

	#tag Note, Name = How To Use
		1) Create a template file using this PDFTemplateDesigner (or a text editor)
		      Template may contain variable-names starting with % (e.g. %CustomerName)
		
		2) Copy the PdfTemplate module into a XOJO Project (Web or Desktop)
		
		3) Create a Dictionary containing the variable-names and the desired values.
		
		4) Write code to render the PDF based on the template file created (see ExampleHowToCreatePdf)
	#tag EndNote

	#tag Note, Name = Readme
		PDF Template Engine
		----------------------
		
		(c) 2025 by Stefan Watermann, Watermann IT Germany
		
		This library contains classes to render PDF documents based on a text-template.
		The template defines what to be rendered into the PDF document at what positon.
		
		
		Know limitations:
		- Size of PDF page is fixed to DIN A4
		- Image aspect ratio may be rendered wrong 
	#tag EndNote


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
