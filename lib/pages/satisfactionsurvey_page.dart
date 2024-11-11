// lib/pages/satisfactionsurvey_page.dart

import 'package:flutter/material.dart';
import 'package:test_diabetic/themes.dart'; // Importação correta

class SatisfactionSurveyPage extends StatefulWidget {
  const SatisfactionSurveyPage({super.key});

  @override
  SatisfactionSurveyPageState createState() => SatisfactionSurveyPageState();
}

class SatisfactionSurveyPageState extends State<SatisfactionSurveyPage> {
  final _formKey = GlobalKey<FormState>();
  String _satisfaction = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pesquisa de Satisfação"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                "Como você avalia nosso app?",
                style: AppTextStyles.displayMedium, // Texto branco
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _satisfaction.isEmpty ? null : _satisfaction,
                decoration: const InputDecoration(
                  labelText: "Selecione uma opção",
                  border: OutlineInputBorder(),
                ),
                items: <String>[
                  'Muito Satisfeito',
                  'Satisfeito',
                  'Neutro',
                  'Insatisfeito',
                  'Muito Insatisfeito'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: AppTextStyles.bodyLarge, // Texto preto
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _satisfaction = newValue ?? '';
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, selecione uma opção';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Lógica para enviar a pesquisa
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Pesquisa enviada com sucesso!')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  textStyle: AppTextStyles.buttonText, // Texto branco
                  minimumSize: const Size(double.infinity, 50), // Largura total
                ),
                child: const Text("Enviar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
