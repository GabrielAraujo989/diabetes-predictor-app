import 'package:flutter/material.dart';
import 'resultquestion_page.dart';

class QuestionnairePage extends StatefulWidget {
  const QuestionnairePage({super.key});

  @override
  _QuestionnairePageState createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  int _questionIndex = 0;
  List<String> questions = [
    "Você tem histórico familiar de diabetes?",
    "Você se exercita regularmente?",
    "Você tem uma dieta balanceada?",
  ];

  List<String> answers = ["Não", "Talvez", "Sim"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Questionário"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LinearProgressIndicator(
              value: (_questionIndex + 1) / questions.length,
            ),
            const SizedBox(height: 20),
            Text(
              questions[_questionIndex],
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Column(
              children: answers.map((answer) {
                return ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (_questionIndex < questions.length - 1) {
                        _questionIndex++;
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ResultQuestionPage()),
                        );
                      }
                    });
                  },
                  child: Text(answer),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
