// lib/pages/resultquestion_page.dart

import 'package:flutter/material.dart';
import 'package:frontend_diabetic/pages/satisfactionsurvey_page.dart';
import 'package:frontend_diabetic/themes.dart';
import 'package:frontend_diabetic/main_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:frontend_diabetic/models/result.dart';

class ResultQuestionPage extends StatefulWidget {
  const ResultQuestionPage({super.key});

  @override
  _ResultQuestionPageState createState() => _ResultQuestionPageState();
}

class _ResultQuestionPageState extends State<ResultQuestionPage> {
  List<Result> _results = [];

  @override
  void initState() {
    super.initState();
    _loadResults();
  }

  Future<void> _loadResults() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> resultsJson = prefs.getStringList('results') ?? [];

    List<Result> loadedResults = resultsJson.map((resultString) {
      return Result.fromJsonString(resultString);
    }).toList();

    setState(() {
      _results = loadedResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultados do Questionário'),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
      ),
      body: _results.isEmpty
          ? const Center(
              child: Text(
                'Nenhum resultado encontrado.',
                style: AppTextStyles.bodyText,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: _results.length,
                itemBuilder: (context, index) {
                  Result result = _results[index];
                  bool isLowRisk = result.recomendacao.contains('Baixo');
                  IconData icon = isLowRisk
                      ? Icons.sentiment_satisfied
                      : Icons.sentiment_dissatisfied;
                  Color iconColor = isLowRisk ? Colors.green : Colors.red;

                  // Formatar a data e hora para melhor visualização
                  DateTime parsedDate = DateTime.parse(result.timestamp);
                  String formattedDate =
                      '${parsedDate.day.toString().padLeft(2, '0')}/${parsedDate.month.toString().padLeft(2, '0')}/${parsedDate.year} ${parsedDate.hour.toString().padLeft(2, '0')}:${parsedDate.minute.toString().padLeft(2, '0')}';

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 4,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      leading: Icon(
                        icon,
                        color: iconColor,
                        size: 40,
                      ),
                      title: Text(
                        result.recomendacao,
                        style: AppTextStyles.bodyText.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        formattedDate,
                        style: AppTextStyles.bodyText.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        _showResultDetails(context, result);
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }

  void _showResultDetails(BuildContext context, Result result) {
    showDialog(
      context: context,
      barrierDismissible: false, // Evita fechar o diálogo ao tocar fora
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: const Text(
            'Detalhes da Consulta',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recomendação:',
                  style: AppTextStyles.bodyText
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  result.recomendacao,
                  style: AppTextStyles.bodyText,
                ),
                const SizedBox(height: 15),
                Text(
                  'Respostas:',
                  style: AppTextStyles.bodyText
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                ...result.responses.asMap().entries.map((entry) {
                  int index = entry.key + 1;
                  String response = entry.value;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Text(
                      '$index. $response',
                      style: AppTextStyles.bodyText,
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const MainNavigation()),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                textStyle: AppTextStyles.buttonText,
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                minimumSize: const Size(120, 45),
              ),
              child: const Text(
                'Voltar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
