// lib/resultquestion_page.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:test_diabetic/themes.dart'; // Importação correta
import 'package:http/http.dart' as http;

class ResultQuestionPage extends StatelessWidget {
  final List<int> answersResponses;

  const ResultQuestionPage({Key? key, required this.answersResponses})
      : super(key: key);


  // Função para enviar as respostas para API
  Future<String> sendRespostas(List<int> respostas) async {
    final String url = 'https://0a09-186-249-39-125.ngrok-free.app/predict';
    debugPrint(respostas.toString());

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(respostas),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        String prediction = responseBody['prediction'];
        return prediction;
      } else {
        print('Erro na API: ${response.statusCode}');
        return 'Erro';
      }
    } catch (e) {
      print('Erro de conexão: $e');
      return 'Erro';
    }
  }

  String getRecomendacao(String resultado) {
    switch (resultado) {
      case "sem diabetes":
        return "Seu nível de risco é Baixo.\n Continue mantendo hábitos saudáveis.";
      case "com diabetes":
        return "Seu nível de risco é Alto.\n Recomendamos consultar um profissional de saúde.";
      default:
        return "Nível de risco desconhecido.";
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    List<int> respostas = [];
    if (args is List<int>) {
      respostas = args;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resultado"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: FutureBuilder<String>(
        future: sendRespostas(respostas),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            String prediction = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Nível de risco",
                    style: AppTextStyles.displayMedium.copyWith(
                      color: AppColors.textColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    getRecomendacao(prediction),
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.textColor,
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
                      textStyle: AppTextStyles.buttonText,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text("Voltar ao Início"),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Nenhum dado disponível'));
          }
        },
      ),
    );
  }
}
