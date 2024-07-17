// ignore_for_file: unused_import, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_final_fields, unused_field, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDF Text Extractor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PdfTextExtractorPage(),
    );
  }
}

class PdfTextExtractorPage extends StatefulWidget {
  @override
  _PdfTextExtractorPageState createState() => _PdfTextExtractorPageState();
}

class _PdfTextExtractorPageState extends State<PdfTextExtractorPage> {
  File? _selectedPdf;
  String _apiResponse = '';
  TextEditingController _textEditingController = TextEditingController();

  Future<void> _pickPDF() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
  );

  if (result != null) {
    PlatformFile file = result.files.single;
    setState(() {
      _selectedPdf = File(file.path!);
    });
  } else {
    // User canceled the picker
    print('User canceled PDF selection');
  }
}


  Future<void> _sendPDFToAPI() async {
    if (_selectedPdf != null) {
      try {
        // Create multipart request
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('https://pdf-text-extractor.p.rapidapi.com/extract_text'),
        );
        request.headers.addAll({
          'X-RapidAPI-Key': 'fadcf34a45msha230b8b4582534cp108ea7jsnfce6466f421a',
          'X-RapidAPI-Host': 'pdf-text-extractor.p.rapidapi.com',
        });
        request.files.add(await http.MultipartFile.fromPath('file', _selectedPdf!.path));

        // Send request
        var response = await request.send();

        // Get response
        var responseBody = await response.stream.bytesToString();

        setState(() {
          _apiResponse = responseBody;
        });
      } catch (e) {
        print('Error sending PDF to API: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Text Extractor'),
      ),
      body: Center(
        child: Padding(
          padding:const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _pickPDF,
                child: const Text('Select PDF'),
              ),
              const SizedBox(height: 20),
              _selectedPdf != null
                  ? ElevatedButton(
                      onPressed: _sendPDFToAPI,
                      child: const Text('Extract Text'),
                    )
                  : const SizedBox(),
               const SizedBox(height: 20),
              _apiResponse.isNotEmpty
                  ? Expanded(
                      child: SingleChildScrollView(
                        child: Text(_apiResponse),
                      ),
                    )
                  :  const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
