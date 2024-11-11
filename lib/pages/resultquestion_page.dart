// lib/resultquestion_page.dart

import 'package:flutter/material.dart';
import 'package:test_diabetic/themes.dart'; // Importação correta

class ResultQuestionPage extends StatelessWidget {
  final List<int> answersResponses;

  const ResultQuestionPage({Key? key, required this.answersResponses})
      : super(key: key);

  // Função para calcular o nível de risco com base nas respostas
  int calculateRiskLevel() {
    // Implementar lógica de cálculo do risco com base nas respostas
    // Exemplo simplificado:
    int total = answersResponses.fold(0, (sum, item) => sum + item);
    if (total < 10) {
      return 1; // Baixo risco
    } else if (total < 20) {
      return 2; // Médio risco
    } else {
      return 3; // Alto risco
    }
  }

  // Função para obter a recomendação com base no nível de risco
  String getRecommendation(int riskLevel) {
    switch (riskLevel) {
      case 1:
        return "Seu nível de risco é Baixo. Continue mantendo hábitos saudáveis.";
      case 2:
        return "Seu nível de risco é Médio. Considere adotar mais medidas preventivas.";
      case 3:
        return "Seu nível de risco é Alto. Recomendamos consultar um profissional de saúde.";
      default:
        return "Nível de risco desconhecido.";
    }
  }

  @override
  Widget build(BuildContext context) {
    // Receber os argumentos passados pela navegação
    final args = ModalRoute.of(context)!.settings.arguments;
    List<int> respostas = [];
    if (args is List<int>) {
      respostas = args;
    }

    int riskLevel = calculateRiskLevel();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Resultado"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Seu Nível de Risco",
              style: AppTextStyles.displayMedium.copyWith(
                color: AppColors.textColor, // Cor preta
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              getRecommendation(riskLevel),
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textColor, // Cor preta
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              "Suas Respostas:",
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textColor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            // Exibir a lista de respostas
            Expanded(
              child: ListView.builder(
                itemCount: respostas.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text('Q${index + 1}:'),
                    title: Text('${respostas[index]}'),
                  );
                },
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/home',
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                textStyle: AppTextStyles.buttonText, // Texto branco
                minimumSize: const Size(double.infinity, 50), // Largura total
              ),
              child: const Text("Voltar ao Início"),
            ),
          ],
        ),
      ),
    );
  }
}
