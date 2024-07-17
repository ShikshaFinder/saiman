// ignore_for_file: prefer_const_constructors, camel_case_types, non_constant_identifier_names, unnecessary_string_interpolations, sized_box_for_whitespace, unused_label, unused_field, avoid_print

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:testing_features/gemini_integration.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'gemini answers to speech',
    home: gemini(),
  ));
}

class gemini extends StatefulWidget {
  const gemini({super.key});

  @override
  State<gemini> createState() => _geminiState();
}

class _geminiState extends State<gemini> {
  TextEditingController text_controller = TextEditingController();
  var islistening = false;
  String result_text = "";
  RxString result = ''.obs;
  File? _selectedPdf;
  String _apiResponse = '';
  FlutterTts tts = FlutterTts();
  SpeechToText speech_to_text = SpeechToText();

  Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _selectedPdf = File(result.files.single.path!);
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
          'X-RapidAPI-Key':
              'fadcf34a45msha230b8b4582534cp108ea7jsnfce6466f421a',
          'X-RapidAPI-Host': 'pdf-text-extractor.p.rapidapi.com',
        });
        request.files
            .add(await http.MultipartFile.fromPath('file', _selectedPdf!.path));

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

  Future<dynamic> speak(String text) async {
    await tts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          title: Text('Gemini features'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
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
              // Text('$_apiResponse',
              //     style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              Text(
                '$result_text',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              FloatingActionButton(
                onPressed: () async {
                  if (!islistening) {
                    var available = await speech_to_text.initialize();

                    if (available) {
                      setState(() {
                        islistening = true;
                        speech_to_text.listen(
                          onResult: (result) {
                            setState(() {
                              result_text = result.recognizedWords;
                            });
                          },
                        );
                        onDone:
                        (result) async {

                          // result.value = await gemini_api.getgeminidata(
                          //     _apiResponse, result_text);
                        };
                      });
                    }
                  } else {
                    speech_to_text.stop();
                    setState(() {
                      islistening = false;
                    });
                    result.value = await gemini_api.getgeminidata(
                        _apiResponse, result_text);
                  }
                  if (islistening == false) {
                    speak(result.value);
                  }
                },
                tooltip: 'tap to start listening',
                child: islistening ? Icon(Icons.pause_circle) : Icon(Icons.mic),
              ),
              Obx(() => Text(
                    '$result',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        ));
  }
}
