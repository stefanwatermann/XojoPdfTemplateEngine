# XojoPdfTemplateEngine (Lib/PdfTemplate)

Classes to render PDF files from a text based template file (.ptf). The template defines what to be rendered into the PDF document at what position.

This project is an approach to separate the design of a PDF file from code instead of writing it completely in XOJO code.

Known limitations:
- Size of PDF page is fixed to DIN A4
- Only one PDF page can be designed and generated
- Aspect ratio of pictures may be rendered wrong

Example of a .ptf file
```shell
### Raster-based PDF template ###
# One command per line, # indicated comment.

### File Version ###
FileVersion: 1.0

### Raster Size ###
GridSizeMm: 2

### Font Definitions ###
# FontDef: <Name:String>, <FontName:String>, <Size:number>[, <FontColor:Color>, <Bold:bool>, <Italic:bool>, <Underline:bool>]
FontDef:N0,Arial,11,&h00000000,False,False,False
FontDef:F0,Arial,9,&h00797979,False,False,False
FontDef:T1,Arial,18,&h00000000,False,False,False

### Content ###
# Text: <FontDef:String>, <X:int>, <Y:int>, <Alignment:Alignment>, <"Content">
# Image: <X:int>, <Y:int>, <Width:int>, <JPEG Data Base64 encoded>
# Line: <X:int>, <Y:int>, <Width:int>, <Size:int>, <Drawingcolor:Color>
Text:T1,26,60,,"Invoice"
Text:N0,160,68,,"%OrderDate"
Text:N0,138,62,,"Invoice Nr.:"
Text:N0,160,62,,"%InvoiceNr"
Line:20,48,180,1,&h00919191
Text:F0,26,243,,"Kind regards"
Text:N0,26,71,,"%CustomerName"
Line:20,240,180,1,&h00919191
```

## Project PdfTemplateEditor
A visual editor to create and edit PDF template files (.ptf). A .ptf file is a simple text file containing instructions for the PdfTemplate engine how to render a PDF file.

Know limitations:
- Scrolling of canvas not implemented
- Font definition not user-friendly

Editor window

<img width="782" height="741" alt="image" src="https://github.com/user-attachments/assets/cac3a9a0-c063-46c0-847c-2d9ef0fbba16" />

Rendered PDF file

<img width="820" height="722" alt="image" src="https://github.com/user-attachments/assets/87c1577d-1247-4961-898d-388eaad30e31" />

## Project PdfTemplateUsageExample

A simple example Web Project to demonstrate how to render a PDF file based on a .ptf template and using variables.

(c) 2025 by Stefan Watermann, Watermann IT Germany
