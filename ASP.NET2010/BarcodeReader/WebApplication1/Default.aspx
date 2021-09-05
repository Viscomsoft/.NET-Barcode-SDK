<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication1.Default" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Read Barcode from Image or PDF File</title>
  
 <link rel="stylesheet" href="//code.jquery.com/ui/1.11.0/themes/smoothness/jquery-ui.css">
 <script src="//code.jquery.com/jquery-1.10.2.js"></script>
 <script src="//code.jquery.com/ui/1.11.0/jquery-ui.js"></script>


  <style>
        body{
            font-family: arial;
            display: flex;
            justify-content: center;
        }
        
        #container{
            min-width: 36%;
            max-width: 36%;
            word-wrap: break-word;
        }
        
        #logo{
            font-size: 3em;
        }
        
        #file{
            width: 0.1px;
            height: 0.1px;
            opacity: 0;
            overflow: hidden;
        }
        
        #file-name{
            font-size: 13px;
        }
        
        #console-div{
            overflow: auto;
            max-height: 16rem;
            font-family: "Courier New", Courier, monospace;
        }
        
        #upload-file{
            display: block;
            border: 1px solid clear;
        }
        
        #url-file{
            display: none;
        }
        
        #input-type{
            border: 1px solid black;
            border-radius: 5px;
            padding: 5px;
            width: 100%;
        }
        
        
        .input-div {
            margin-top: 2%;
        }
        
        .box{
            margin-top: 10px;
        }
        
         .short-text-box{
            border: 1px solid black;
            border-radius: 5px;
            padding: 5px;
            width: 10%;
            width: calc(10% - 2px);
        }
         .browse-text-box{
            border: 1px solid black;
            border-radius: 5px;
            padding: 5px;
            width: 80%;
            width: calc(80% - 10px);
        }
        .text-box{
            border: 1px solid black;
            border-radius: 5px;
            padding: 5px;
            width: 98%;
            width: calc(100% - 10px);
        }
        text-box-disable
        {
            background: #dddddd;
            border: 1px solid black;
            border-radius: 5px;
            padding: 5px;
            width: 98%;
            width: calc(100% - 10px);
        }
        .invalid{
            
            border: 2px solid red ! important;
        }
        
        .btn
        {
            padding: 5px;
            border: 2px solid grey;
            border-radius: 5px;
            background-color: rgb(230,230,230);
            font-size: 14px;
        }
        .disabled {
              pointer-events: none;  /**<-----------*/
            opacity: 0.2;
        }
        .btn:hover{
            border: 2px solid black;
            border-radius: 5px;
            background-color: rgba(0,0,0,0);
            cursor: pointer;
        }
        
       .switch {
            position: relative;
            display: inline-block;
        }
       .switch-input {
            display: none;
        }
        .switch-label {
            display: block;
            width: 48px;
          height: 24px;
          text-indent: -150%;
          clip: rect(0 0 0 0);
          color: transparent;
          user-select: none;
        }
        .switch-label::before,
        .switch-label::after {
          content: "";
          display: block;
          position: absolute;
          cursor: pointer;
        }
        .switch-label::before {
          width: 100%;
          height: 100%;
          background-color: #dedede;
          border-radius: 9999em;
          -webkit-transition: background-color 0.25s ease;
          transition: background-color 0.25s ease;
        }
        .switch-label::after {
          top: 0;
          left: 0;
          width: 24px;
          height: 24px;
          border-radius: 50%;
          background-color: #fff;
          box-shadow: 0 0 2px rgba(0, 0, 0, 0.45);
          -webkit-transition: left 0.25s ease;
          transition: left 0.25s ease;
        }
        .switch-input:checked + .switch-label::before {
          background-color: #89c12d;
        }
        .switch-input:checked + .switch-label::after {
          left: 24px;
        }
    </style>

    <script type="text/javascript">
        var files;

        $(document).ready(function () {

           
          $("#btnUpload").click(UploadFiles);
          $("#file").change(OnChange);
          $("#btnReadBarCodePage").attr("disabled", "disabled");
          $("#btnReadBarCodePage").click(ReadBarcodePage);

              
          document.getElementById('btnUpload').disabled = true;
          document.getElementById('TxtZoneLeft').disabled = true;
          document.getElementById('TxtZoneTop').disabled = true;
          document.getElementById('TxtZoneWidth').disabled = true;
          document.getElementById('TxtZoneHeight').disabled = true;



        });

          $(function () {

       
       
        

          $("#dialog-upload" ).dialog({
               autoOpen: false, 
               modal: true,
               buttons: {
                  OK: function() {$(this).dialog("close");}
               },
            });


          $("#dialog-createdpdf" ).dialog({
               autoOpen: false, 
              width: 500,
               modal: true,
               buttons: {
                  OK: function() {$(this).dialog("close");}
               },
            });


     });


    

        function OnChange(evt) {

     
            files = evt.target.files;
        
           document.getElementById("file-name").value = files[0].name;

            document.getElementById('btnUpload').disabled = false;


        }

        function ReadBarcodePage() {

         

            document.getElementById('btnReadBarCodePage').disabled = true;
 

            var bScanWithoutRotation = document.getElementById("chkScanNoRotation").checked;
          

            var bScan45 = document.getElementById("chkScan45").checked;
          

            var bScan45counter = document.getElementById("chkScan45counter").checked;
          


            var bScanWith90DegreeRotation = document.getElementById("chkScan90").checked;
          

            var bScanMultipleBarcode = document.getElementById("chkScanMultipleBarcode").checked;
          
            var bMoreAccuracy = document.getElementById("chkMoreAccuracy").checked;
           
            var obj = {};
            obj.strInputPDFFile1 = files[0].name;
          
          
            obj.iPageNo =  $("#TxtPageNo").val();
         
            
            obj.bScanWithoutRotation = bScanWithoutRotation;
            obj.bScanWith45DegreeClockwiseRotation = bScan45;
            obj.bScanWith45DegreeCounterClockwiseRotation = bScan45counter;
            obj.bScanWith90DegreeRotation = bScanWith90DegreeRotation;
            obj.bScanMultipleBarcode = bScanMultipleBarcode;
            obj.bMoreAccuracy = bMoreAccuracy;
            obj.iScanWithCustomRotation =  $("#TxtCustomRotation").val();
            obj.iZoneLeft =  $("#TxtZoneLeft").val();
            obj.iZoneTop =  $("#TxtZoneTop").val();
            obj.iZoneWidth =  $("#TxtZoneWidth").val();
            obj.iZoneHeight =  $("#TxtZoneHeight").val();
          


            $.ajax({
                type: 'POST',
                url: '/Default.aspx/ProcessReadBarCodePage',
                data: JSON.stringify(obj),
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (results) {
                 
                   var link = results.d ;
                   $("#dialog-createdpdf").html(link).dialog("open");
                   $("#btnReadBarCodePage").removeAttr("disabled");
                  },
                error: function () { 
                 alert('error');  
                 $("#btnReadBarCodePage").removeAttr("disabled");
                  }
            });
            
        }

          function chkBarcodeReadFullPageClick(cb) {
          if(cb.checked)
          {
      
            
          document.getElementById('TxtZoneLeft').disabled = true;
          document.getElementById('TxtZoneTop').disabled = true;
          document.getElementById('TxtZoneWidth').disabled = true;
          document.getElementById('TxtZoneHeight').disabled = true;

             $("#TxtZoneLeft").val(0);
             $("#TxtZoneTop").val(0);
             $("#TxtZoneWidth").val(0);
             $("#TxtZoneHeight").val(0);

          }
          else
          {
              document.getElementById('TxtZoneLeft').disabled = false;
              document.getElementById('TxtZoneTop').disabled = false;
              document.getElementById('TxtZoneWidth').disabled =false;
              document.getElementById('TxtZoneHeight').disabled = false;
         
          }
        }


        function UploadFiles() {
        
        
            if(files.length!=1)
            {
                alert("Please select image or pdf file");
                return;
            }

           
            var selectedFileName1 = files[0].name;
        


            var data = new FormData();
            for (var i = 0; i < files.length; i++) {
                data.append(files[i].name, files[i]);
            }

             $("#btnUpload").attr("disabled", "disabled");

            $.ajax({
                type: "POST",
                url: "UploadFiles.ashx",
                contentType: false,
                processData: false,
                data: data,
                success: function (result) {
                     $("#dialog-upload").dialog("open");
                    
                         document.getElementById('btnReadBarCodePage').disabled = false;
                },
                error: function () {
                    alert("There was error uploading files!");
                }
            });

           
        }

    </script>
</head>
<body style="">
  
 <div id="container">
        <div id="logo" class="box">
            <span>Read Barcode</span>
        </div>
        <br/>
        
        <div class="input-div">
            
            <div id="input-box">
                
                  <div class="box">
                  
                        <input id="file-name" class="browse-text-box" type="text" value="" />
                        <input id="file" type="file"/>
                        <label id="browse" for="file" class="btn">Browse...</label>
                        
                    </div>


                <div class="input-div box">
                <input id="btnUpload" class="btn" type="button" value="Upload" />
                </div>

                 <div id="Div1" class="box">
                    <span>CW = clockwise, CCW = counterclockwise </span>
                    <br/>
                 </div>

               <div class="box">
                <span>Scan without rotation:</span>
                  <div class="switch">
                    <input id="chkScanNoRotation" type="checkbox" class="switch-input" Checked="True" />
                    <label for="chkScanNoRotation" class="switch-label"></label>
                  </div>

                  <span>Scan with 45 degree CW:</span>
                  <div class="switch">
                    <input id="chkScan45" type="checkbox" class="switch-input" Checked="True" />
                    <label for="chkScan45" class="switch-label"></label>
                  </div>

                <br/>
              </div>
                <br/>

              <div class="box">
                <span> Scan with 90 degree:</span>
                  <div class="switch">
                    <input id="chkScan90" type="checkbox" class="switch-input" Checked="True" />
                    <label for="chkScan90" class="switch-label"></label>
                  </div>

                  <span>Scan with 45 degree CCW</span>
                  <div class="switch">
                    <input id="chkScan45counter" type="checkbox" class="switch-input" Checked="True" />
                    <label for="chkScan45counter" class="switch-label"></label>
                  </div>

                <br/>
              </div>
                <br/>

                
              <div class="box">
                <span> Scan Multiple Barcode:</span>
                  <div class="switch">
                    <input id="chkScanMultipleBarcode" type="checkbox" class="switch-input" Checked="True" />
                    <label for="chkScanMultipleBarcode" class="switch-label"></label>
                  </div>

                  <span>Scan More Accuracy</span>
                  <div class="switch">
                    <input id="chkMoreAccuracy" type="checkbox" class="switch-input" Checked="True" />
                    <label for="chkMoreAccuracy" class="switch-label"></label>
                  </div>

                <br/>
              </div>
                <br/>
                 <div class="box">
                <span> Read Barcode Full Page:</span>
                  <div class="switch">
                    <input id="chkReadBarcodeFullPage" type="checkbox" class="switch-input"  Checked="True" onclick='chkBarcodeReadFullPageClick(this);' />
                    <label for="chkReadBarcodeFullPage" class="switch-label"></label>
                  </div>

                <br/>
              </div>
               
                <div id="url-file" class="box">
                    <span>Convert from URL:</span>
                    <input id="url" class="text-box" type="text"/>
                </div>
                <br/>
            </div>
            <div class="box">
                <span>Read Barcode By Zone:</span>
               
                <br/>
            </div>
            <div class="box">
                <span>Left:</span>
                <input id="TxtZoneLeft"class="short-text-box" type="text" value="0" />
                <span>Top:</span>
                <input id="TxtZoneTop" class="short-text-box" type="text" value="0" />
                <span>Width:</span>
                <input id="TxtZoneWidth" class="short-text-box" type="text" value="0" />
                 <span>Height:</span>
                <input id="TxtZoneHeight" class="short-text-box" type="text" value="0" />
                <br/>
            </div>
            <div class="box">
                <span>Custom Rotation:</span>
                <input id="TxtCustomRotation" class="text-box" type="text" value="0" />
                <br/>
            </div>

            <div class="box">
                <span>Page Number:</span>
                <input id="TxtPageNo" class="text-box" type="text" value="1" />
                <br/>
            </div>
        </div>
        <div class="input-div box">
       
            <input id="btnReadBarCodePage" class="btn" type="button" value="Read Barcode" />
        </div>
        <br/>
        <div id="console-div" ></div>
    </div>


  

<div id = "dialog-createdpdf" title = "BarCode"></div>

<div id = "dialog-upload" title = "Upload">File Uploaded Successfully!</div>

</body>
</html>


