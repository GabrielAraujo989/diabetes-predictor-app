// lib/pages/home_page.dart

import 'package:flutter/material.dart';
import 'package:test_diabetic/themes.dart'; // Importação correta
import 'package:test_diabetic/pages/questionnaire_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App Diabetes Predictor"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Descubra suas chances de desenvolver diabetes!",
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: AppColors.textColor, // Cor preta
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              "Este app faz perguntas rápidas e analisa suas respostas para prever suas chances de desenvolver diabetes.",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textColor, // Cor preta
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const QuestionnairePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                textStyle: AppTextStyles.buttonText, // Texto branco
                minimumSize: const Size(double.infinity, 50), // Largura total
              ),
              child: const Text(
                "INICIAR",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
