import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:printing/printing.dart';

class printreport extends StatelessWidget {
  final String name;
  final String id;
  final String date;
  final String report;
  final List diseace;
  printreport(
      {Key? key,
      required this.name,
      required this.report,
      required this.id,
      required this.date,
      required this.diseace})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PdfPreview(
        build: (format) => _generatePdf(format),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document();

    Future<pw.Font> infont() async {
      final ByteData fontData = await rootBundle.load('assets/fonts/hh.ttf');
      return pw.Font.ttf(fontData.buffer.asByteData());
    }

    final arfont = await infont();
    // final font = await fontFromAssetBundle(
    //     'assets\fonts\Cairo-VariableFont_slnt,wght.ttf');
    //final font = await PdfGoogleFonts.nunitoExtraLight();
    //final image = await imageFromAssetBundle('images/logo.png');

    pdf.addPage(
      pw.Page(
        textDirection: pw.TextDirection.rtl,
        theme: pw.ThemeData.withFont(
          base: arfont,
          //fontFallback: [font],
        ),
        //pageFormat: format,
        pageFormat: PdfPageFormat.a5,
        build: (context) {
          return pw.Column(
            children: [
              //pw.Image(image),

              pw.Container(
                alignment: pw.Alignment.centerLeft,
                width: double.infinity,
                child: pw.Text(
                  'Dr: Mohamed',
                  style: pw.TextStyle(fontSize: 25),
                ),
              ),
              pw.Container(
                height: 3,
                width: double.infinity,
              ),
              pw.Container(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Text('Name: $name',
                      style: pw.TextStyle(
                        fontSize: 12,
                      ))),
              //child: pw.Text('الاسم: $name', style: GoogleFonts.cairo(fontSize: 20, color: PdfColors.black))),

              pw.Container(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Text('Id: $id', style: pw.TextStyle(fontSize: 12))),
              pw.Container(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Text('Date Report: $date',
                      style: pw.TextStyle(fontSize: 12))),
              pw.Divider(indent: 2),
              pw.Text('Diseace',
                  style: pw.TextStyle(
                    fontSize: 15,
                    fontWeight: pw.FontWeight.bold,
                  )),
              pw.Container(
                child: pw.ListView.builder(
                    itemCount: diseace.length,
                    itemBuilder: (context, i) {
                      return pw.Container(
                          margin: pw.EdgeInsets.all(12),
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Text(
                            '${diseace[i].namedisease}',
                            style: pw.TextStyle(fontSize: 12),
                          ));
                    }),
              ),
              pw.Text('Report',
                  style: pw.TextStyle(
                    fontSize: 15,
                    fontWeight: pw.FontWeight.bold,
                  )),
              pw.Container(
                  padding: pw.EdgeInsets.only(right: 12),
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Text('$report', style: pw.TextStyle(fontSize: 12))),

              pw.Expanded(
                child: pw.Container(),
              ),

              pw.Divider(indent: 2),
              pw.Container(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Text('Phone: 011347.......',
                      style: pw.TextStyle(fontSize: 12))),

              //pw.Flexible(child: pw.FlutterLogo())
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
