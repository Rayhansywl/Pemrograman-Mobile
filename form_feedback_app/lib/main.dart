import 'package:flutter/material.dart';
import 'pages/feedback_form_page.dart';

void main() {
  runApp(FormFeedbackApp());
}

class FormFeedbackApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Feedback App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: FeedbackFormPage(),
    );
  }
}
