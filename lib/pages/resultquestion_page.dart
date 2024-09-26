import 'package:flutter/material.dart';

class ResultQuestionPage extends StatelessWidget {
  const ResultQuestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    int riskLevel = 3; // Exemplo de valor processado (de 1 a 5)

    String getRecommendation(int riskLevel) {
      switch (riskLevel) {
        case 1:
          return "Seu risco de diabetes é muito baixo. Continue com seus hábitos saudáveis!";
        case 2:
          return "Seu risco de diabetes é baixo. Mantenha-se ativo!";
        case 3:
          return "Seu risco de diabetes é moderado. Considere revisar sua dieta e atividades físicas.";
        case 4:
          return "Seu risco de diabetes é alto. Procure um profissional de saúde.";
        case 5:
          return "Seu risco de diabetes é muito alto. Consulte seu médico imediatamente!";
        default:
          return "Risco desconhecido.";
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Resultado"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Seu nível de risco: $riskLevel",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              getRecommendation(riskLevel),
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Voltar ao Início"),
            ),
          ],
        ),
      ),
    );
  }
}
