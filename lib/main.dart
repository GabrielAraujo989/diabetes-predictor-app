// lib/main.dart

import 'package:flutter/material.dart';
import 'package:test_diabetic/pages/home_page.dart';
import 'package:test_diabetic/pages/questionnaire_page.dart';
import 'package:test_diabetic/pages/resultquestion_page.dart';
import 'package:test_diabetic/pages/satisfactionsurvey_page.dart';
import 'package:test_diabetic/pages/loading_screen.dart'; // Corrigido para a convenção de nomenclatura
import 'package:test_diabetic/main_navigation.dart'; // Corrigido para a convenção de nomenclatura
import 'package:test_diabetic/themes.dart'; // Importação correta do themes.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diabetes Detector',
      theme: AppThemes.getThemeData(),
      initialRoute: '/', // Definir a rota inicial como '/'
      routes: {
        '/': (context) => const LoadingScreen(),
        '/main': (context) => const MainNavigation(),
        '/home': (context) =>
            const MainNavigation(), // Rota '/home' aponta para MainNavigation
        '/questionnaire': (context) => const QuestionnairePage(),
        '/result': (context) => ResultQuestionPage(
              answersResponses:
                  ModalRoute.of(context)?.settings.arguments as List<int>? ??
                      [],
            ),
        '/satisfaction': (context) => const SatisfactionSurveyPage(),
      },
      debugShowCheckedModeBanner: false, // Remover o banner de debug
    );
  }
}
