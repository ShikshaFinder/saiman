// ignore_for_file: prefer_const_constructors, camel_case_types, non_constant_identifier_names, unnecessary_string_interpolations, sized_box_for_whitespace, unused_label

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:get/get.dart';
import 'gemini_integration.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'gemini_test_model answers to speech',
    home: gemini_test_model(),
  ));
}

class gemini_test_model extends StatefulWidget {
  const gemini_test_model({super.key});

  @override
  State<gemini_test_model> createState() => _gemini_test_modelState();
}

class _gemini_test_modelState extends State<gemini_test_model> {
  TextEditingController text_controller = TextEditingController();
  void getanswer() async {}
  var islistening = false;
  String text = "";
  RxString result = ''.obs;
  String paper = "";
  SpeechToText speech_to_text = SpeechToText();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        appBar: AppBar(
          title: Text('gemini_test_model features'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                '$text',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: FloatingActionButton(
                  onPressed: () async {
                    if (!islistening) {
                      var available = await speech_to_text.initialize();
                
                      if (available) {
                        setState(() {
                          islistening = true;
                          speech_to_text.listen(
                            onResult: (result) {
                              setState(() {
                                text = result.recognizedWords;
                              });
                            },
                          );
                          onDone:
                          (result) async {
                            // Get answer from gemini_test_model API
                            result.value = await gemini_api.getgeminidata("",text);
                          };
                        });
                      }
                    } else {
                      speech_to_text.stop();
                      setState(() {
                        islistening = false;
                      });
                    }
                    result.value = await gemini_api.getgeminidata("",text);
                  },
                  // tooltip: 'tap to start listening',
                  child: islistening ? Icon(Icons.pause_circle) : Icon(Icons.mic),
                ),
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
