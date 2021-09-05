using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using ViscomBarcodeWrapper;

namespace WindowsFormsApplication1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string strFile = textBox1.Text;

            if (strFile == "")
            {
                MessageBox.Show("Please select image or pdf file first");
                return;
            }
            BarcodeReader reader = new BarcodeReader();
            reader.ScanWithoutRotation = true;
            reader.ScanWith45DegreeClockwiseRotation = true;
            reader.ScanWith45DegreeCounterClockwiseRotation = true;
            reader.ScanWith90DegreeRotation = true;
            reader.TryHard = true;
            reader.ScanMultiple = true;

            
         
            string strType =strFile.Substring(strFile.Length-3,3);

            int count;
            if (strType.ToLower() == "pdf")
            {
                int iPageCount = reader.GetPDFPageCount(strFile);

                if (iPageCount == 0)
                {
                    MessageBox.Show("The PDF page cannot read");
                    return;
                }
                int iMyWidth = 0;
                int iMyHeight = 0;
                bool bResult = reader.GetPDFPage(strFile, 1, out iMyWidth, out iMyHeight);

                int iScaledWidth = (int)(iMyWidth * 2.5);
                int iScaledHeight = (int)(iMyHeight * 2.5);


                Bitmap bitmap = new Bitmap(iScaledWidth, iScaledHeight);
                int width = bitmap.Width;
                int height = bitmap.Height;
                bool bresult = reader.GetPDFBitmap(strFile, 1, bitmap);

                count = reader.ReadBarcodeImage(bitmap, 0, 0, width, height);

            }
            else
            {
                Bitmap bitmap = new Bitmap(strFile);

                int width = bitmap.Width;
                int height = bitmap.Height;
                count = reader.ReadBarcodeImage(bitmap, 0, 0, width, height);


            }
            /*
            int iScaledWidth = (int)(iMyWidth * 2.5);
            int iScaledHeight = (int)(iMyHeight * 2.5);

            Bitmap bitmap = new Bitmap(iScaledWidth, iScaledHeight);

            bool bresult = reader.GetPDFBitmap(strPDF, 1, bitmap);

            int width = bitmap.Width;
            int height = bitmap.Height;
            MessageBox.Show(width.ToString() + " " + height.ToString());
            */
            //Bitmap bitmap = new Bitmap("c:\\testvideo\\barcodetest.jpg");

            //int width = bitmap.Width;
            //int height = bitmap.Height;
   

           

            

            string text1 = "Total " + count.ToString() + " Barcode found" + "\r\n";

            for (int i = 0; i < count; i++)
            {
               
                text1 = text1 + reader.GetBarCodeType(i) + " value:" + reader.GetBarCodeValue(i) + "\r\n";
             
            }

            MessageBox.Show(text1);

        }

        private void button2_Click(object sender, EventArgs e)
        {
                this.openFileDialog1.Filter = "All Files (*.*)|*.*|PDF (*.pdf)|*.pdf|JPEG (*.jpg)|*.jpg|Bitmap (*.bmp)|*.bmp|TIF (*.tif)|*.tif|Gif (*.gif)|*.gif |PNG (*.png)|*.png";
                if (this.openFileDialog1.ShowDialog(this) == DialogResult.OK)
                {
                    textBox1.Text = openFileDialog1.FileName;
                }
        }
    }
}
