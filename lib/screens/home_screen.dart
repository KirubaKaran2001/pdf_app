import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf_app/constants/text_constants.dart';
import 'package:printing/printing.dart';

class PdfViewer extends StatefulWidget {
  const PdfViewer({super.key});

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  FilePickerResult? result;
  @override
  void initState() {
    super.initState();
    pdfView();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pdf viewer'),
        ),
        body: Center(
          child: ElevatedButton(
            child: const Text('Open File'),
            onPressed: () {},
          ),
        ),
      ),
    );
  }

  pdfView() async {
    final netImage = await networkImage(
        'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/QR_code_for_mobile_English_Wikipedia.svg/1200px-QR_code_for_mobile_English_Wikipedia.svg.png');

    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text('ABC'),
                ],
              ),
              pw.SizedBox(
                height: 20,
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Name : Kirubakaran,\nAge : 20,\nPlace : Gudalur.'),
                  pw.Container(
                    height: 100,
                    width: 100,
                    child: pw.BarcodeWidget(
                      color: PdfColor.fromHex("#000000"),
                      barcode: pw.Barcode.qrCode(),
                      data: "https://stackoverflow.com/questions/61920331/how-can-i-generate-qr-code-and-show-it-on-a-pdf-page-in-flutter",
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.black),
                tableWidth: pw.TableWidth.max,
                defaultColumnWidth: const pw.IntrinsicColumnWidth(),
                children: [
                  pw.TableRow(
                    children: [
                      pw.Text('A'),
                      pw.Text('B'),
                      pw.Text('C'),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text('kk'),
                      pw.Text('Ck'),
                      pw.Text('CP'),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text('AA'),
                      pw.Text('BD'),
                      pw.Text('CE'),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text('AD'),
                      pw.Text('BE'),
                      pw.Text('CQ'),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(
                height: 50,
              ),
              pw.Footer(
                title: pw.Text(
                    '*********************Thank You**************************'),
              ),
            ],
          );
        },
      ),
    );
    final file = File('details.pdf');
    await file.writeAsBytes(await pdf.save());
  }
}
