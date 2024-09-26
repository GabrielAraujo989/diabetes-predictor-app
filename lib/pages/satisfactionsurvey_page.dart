import 'package:flutter/material.dart';

class SatisfactionSurveyPage extends StatefulWidget {
  const SatisfactionSurveyPage({super.key});

  @override
  _SatisfactionSurveyPageState createState() => _SatisfactionSurveyPageState();
}

class _SatisfactionSurveyPageState extends State<SatisfactionSurveyPage> {
  double _satisfactionRating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pesquisa de Satisfação"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Como você avalia sua experiência com o app?",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Slider(
              value: _satisfactionRating,
              min: 0,
              max: 5,
              divisions: 5,
              label: _satisfactionRating.toString(),
              onChanged: (double value) {
                setState(() {
                  _satisfactionRating = value;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        "Obrigado pelo seu feedback! Sua nota: $_satisfactionRating"),
                  ),
                );
              },
              child: const Text("Enviar"),
            ),
          ],
        ),
      ),
    );
  }
}
