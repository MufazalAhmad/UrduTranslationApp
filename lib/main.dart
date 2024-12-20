import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              'Create Pdf',
            ),
            ElevatedButton(
              onPressed: () {
                createPdfWithUrduText(context);
              },
              child: const Text('Generate PDF'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> createPdfWithUrduText(context) async {
    final pdf = pw.Document();
    final font = await rootBundle
        .load("assets/fonts/aasar/Aasar-Unicode-Aasar-Unicode.ttf");

    final ttf = pw.Font.ttf(font);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.roll80,
        build: (_) => pw.Directionality(
            textDirection: pw.TextDirection.rtl,
            child: pw.Text(
              'ہیلو دنیا!',
              // textDirection: pw.TextDirection.ltr,
              style: pw.TextStyle(font: ttf, fontSize: 40),
            )),
      ),
    );
    final Uint8List pdfBytes = await pdf.save();

    Printing.layoutPdf(onLayout: (PdfPageFormat format) => pdfBytes);
  }
}
