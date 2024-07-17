// ignore_for_file: avoid_print, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_declarations

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String extractedText = '';

  Future<void> extractTextFromPDF(File pdfFile) async {
    final url = 'http://localhost:3000/extract-text';
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('pdf', pdfFile.path));

    var response = await request.send();
    if (response.statusCode == 200) {
      extractedText = await response.stream.bytesToString();
      setState(() {});
    } else {
      print('Failed to extract text from PDF');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Text Extractor'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                // Show file picker to select a PDF file
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['pdf'],
                );

                if (result != null) {
                  File pdfFile = File(result.files.single.path!);
                  await extractTextFromPDF(pdfFile);
                } else {
                   print('No file selected');
                }
              },
              child:const  Text('Select PDF File'),
            ),
            const SizedBox(height: 20),
            if (extractedText.isNotEmpty)
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    extractedText,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
