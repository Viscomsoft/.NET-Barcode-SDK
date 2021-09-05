using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.IO;

using System.Drawing;
using System.Drawing.Imaging;
using ViscomBarcodeWrapper;



namespace WebApplication1
{
    public partial class Default : System.Web.UI.Page
    {
        [WebMethod]
        
        public static string ProcessReadBarCodePage(string strInputPDFFile1, int iPageNo, bool bScanWithoutRotation, bool bScanWith45DegreeClockwiseRotation, bool bScanWith45DegreeCounterClockwiseRotation, bool bScanWith90DegreeRotation, bool bScanMultipleBarcode, bool bMoreAccuracy, double iScanWithCustomRotation, int iZoneLeft, int iZoneTop, int iZoneWidth, int iZoneHeight)
        {


          
            string strInputFileExt =strInputPDFFile1.Substring(strInputPDFFile1.Length - 3);

            strInputFileExt.ToLower();

            var myUniqueFileName = string.Format(@"{0}.pdf", Guid.NewGuid());


       
            string stroutpath = HttpContext.Current.Server.MapPath("~/output/" + myUniqueFileName);

            string strinputpath1 = HttpContext.Current.Server.MapPath("~/uploads/" + strInputPDFFile1);

            BarcodeReader reader= new BarcodeReader();
            reader.ScanWithoutRotation = bScanWithoutRotation;
            reader.ScanWith45DegreeClockwiseRotation = bScanWith45DegreeClockwiseRotation;
            reader.ScanWith45DegreeCounterClockwiseRotation = bScanWith45DegreeCounterClockwiseRotation;
            reader.ScanWith90DegreeRotation = bScanWith90DegreeRotation;

            if (iScanWithCustomRotation != 0)
            {
                reader.ScanWithCustomRotation = true;
                reader.CustomRotation = iScanWithCustomRotation;
            }
            else
                reader.ScanWithCustomRotation = false;


            reader.TryHard = bMoreAccuracy;
            reader.ScanMultiple = bScanMultipleBarcode;

         

            int iMyWidth=0;
            int iMyHeight=0;
            Bitmap bitmap;

            if (strInputFileExt == "pdf")
            {
                int iPageCount=reader.GetPDFPageCount(strinputpath1);

                if (iPageNo > iPageCount)
                    iPageNo = iPageCount;

                bool bResult=reader.GetPDFPage(strinputpath1, iPageNo, out iMyWidth, out iMyHeight);

                if (!bResult)
                    return "Get Page Error";

                int iScaledWidth = (int)(iMyWidth * 2.5);
                int iScaledHeight = (int)(iMyHeight * 2.5);

                bitmap = new Bitmap(iScaledWidth, iScaledHeight);

                bool bresult =reader.GetPDFBitmap(strinputpath1, iPageNo, bitmap);

                if (!bresult)
                    return "Get PDF BItmap error";

            }
            else
            {
                try
                {
                    bitmap = new Bitmap(strinputpath1);
                }
                catch (Exception ex)
                {
                    return "Error! Cannot read the image.";
                }

            }

            int x = 0;
            int y = 0;
            int width=0;
            int height=0;

            if (iZoneLeft == 0 && iZoneTop == 0 && iZoneWidth == 0 && iZoneHeight == 0)
            {
                width = bitmap.Width;
                height = bitmap.Height;
            }
            else
            {
                x = iZoneLeft;
                y = iZoneTop;
                width = iZoneWidth;
                height = iZoneHeight;
            }

             
            
            if (width == 0)
            {
                return "Error! Cannot read the image.";

            }
           


            int count = reader.ReadBarcodeImage(bitmap, x, y, width, height);
            string text = "" + count + " codes found<br><br>";
          
            for (int i = 0; i < count; i++)
            {
                text += reader.GetBarCodeType(i) + " value:" + reader.GetBarCodeValue(i) + "<br>";
            }

            bitmap.Dispose();

            return text;
            
            
    }
       

        protected void Page_Load(object sender, EventArgs e)
        {

        }

       
    }
}