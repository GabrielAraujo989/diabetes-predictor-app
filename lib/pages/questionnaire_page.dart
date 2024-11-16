// lib/questionnaire_page.dart

import 'package:flutter/material.dart';
import 'package:test_diabetic/themes.dart'; // Importação correta

class QuestionnairePage extends StatefulWidget {
  const QuestionnairePage({super.key});

  @override
  _QuestionnairePageState createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  int _questionIndex = 0;

  // Definição das questões com seus respectivos tipos
  final List<Map<String, dynamic>> questions = [
    {
      "question": "Você tem pressão alta ?",
      "type": "boolean",
    },
    {
      "question": "Você tem alto colesterol ?",
      "type": "boolean",
    },
    {
      "question": "Você já mediu seu colesterol nos últimos 5 anos ?",
      "type": "boolean",
    },
    {
      "question": "Qual o seu IMC (Índice de massa corporal) ?",
      "type": "number_imc",
    },
    {
      "question": "Você já fumou pelo menos 100 cigarros em toda a sua vida ?",
      "type": "boolean",
    },
    {
      "question": "Você já foi informado de que teve um derrame ?",
      "type": "boolean",
    },
    {
      "question": "Você tem doença arterial coronariana (DAC) ou teve ataque cardiáco (AC) ?",
      "type": "boolean",
    },
    {
      "question": "Você praticou atividades físicas nos últimos 30 dias (exceto no trabalho)?",
      "type": "boolean",
    },
    {
      "question": "Você consome frutas pelo menos uma vez por dia?",
      "type": "boolean",
    },
    {
      "question": "Você consome vegetais pelo menos uma vez por dia?",
      "type": "boolean",
    },
    {
      "question": "Você consome álcool em excesso (homens: mais de 14 bebidas por semana, mulheres: mais de 7 bebidas por semana)?",
      "type": "boolean",
    },
    {
      "question": "Como você avaliaria sua saúde geral ? (Escala de 1 a 5, onde 1 = Excelente e 5 = Ruim)",
      "type": "scale",
    },
    {
      "question": "Quantos dias nos últimos 30 dias sua saúde mental não esteve boa ?",
      "type": "number",
    },
    {
      "question": "Quantos dias nos últimos 30 dias sua saúde física não esteve boa ?",
      "type": "number",
    },
    {
      "question": "Você tem dificuldade em andar ou subir escadas?",
      "type": "boolean",
    },
    {
      "question": "Qual o seu sexo ?",
      "type": "boolean_sex",
    },
    {
      "question": "Qual a faixa da sua idade ?",
      "type": "choose",
    },
  ];

  // Armazenar respostas como inteiros: Sim=1, Não=0 e outros números correspondentes
  final List<int> answersResponses = [];

  // Controladores para campos de entrada
  double _currentScaleValue = 3;
  TextEditingController _numberController = TextEditingController();

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Verificar se todas as questões foram respondidas
    bool isLastQuestion = _questionIndex == questions.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Questionário"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          // Centralizar o conteúdo horizontalmente
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              // Limita o tamanho do widget para evitar que ele ocupe toda a tela
              constraints: BoxConstraints(
                maxWidth: 600, // Tamanho máximo para o conteúdo
              ),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Alinhar verticalmente ao centro
                crossAxisAlignment: CrossAxisAlignment
                    .center, // Alinhar horizontalmente ao centro
                children: [
                  LinearProgressIndicator(
                    value: (_questionIndex + 1) / questions.length,
                    backgroundColor: AppColors.secondaryColor,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    questions[_questionIndex]["question"],
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.textColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  // Renderizar resposta baseada no tipo da questão
                  _buildAnswerWidget(questions[_questionIndex]["type"]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget para renderizar respostas baseadas no tipo da questão
  Widget _buildAnswerWidget(String type) {
    switch (type) {
      case "boolean":
        return Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0), // Margem vertical
              child: ElevatedButton(
                onPressed: () => _handleBooleanAnswer("Sim"),
                style: ElevatedButton.styleFrom(
                  textStyle: AppTextStyles.buttonText, // Texto branco
                  minimumSize: const Size(double.infinity, 50), // Largura total
                ),
                child: const Text("Sim"),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0), // Margem vertical
              child: ElevatedButton(
                onPressed: () => _handleBooleanAnswer("Não"),
                style: ElevatedButton.styleFrom(
                  textStyle: AppTextStyles.buttonText, // Texto branco
                  minimumSize: const Size(double.infinity, 50), // Largura total
                ),
                child: const Text("Não"),
              ),
            ),
          ],
        );
      case "boolean_sex":
        return Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: () => _handleBooleanSexAnswer("M"),
                style: ElevatedButton.styleFrom(
                  textStyle: AppTextStyles.buttonText,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text("M"),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: () => _handleBooleanSexAnswer("F"),
                style: ElevatedButton.styleFrom(
                  textStyle: AppTextStyles.buttonText,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text("F"),
              ),
            ),
          ],
        );
      case "scale":
        return Column(
          children: [
            Text(
              _currentScaleValue.round().toString(),
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textColor, // Cor preta
              ),
            ),
            Slider(
              value: _currentScaleValue,
              min: 1,
              max: 5,
              divisions: 4,
              label: _currentScaleValue.round().toString(),
              activeColor: AppColors.primaryColor,
              inactiveColor: AppColors.secondaryColor,
              onChanged: (double value) {
                setState(() {
                  _currentScaleValue = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: () => _handleScaleAnswer(_currentScaleValue.round()),
              style: ElevatedButton.styleFrom(
                textStyle: AppTextStyles.buttonText, // Texto branco
                minimumSize: const Size(double.infinity, 50), // Largura total
              ),
              child: const Text("Próximo"),
            ),
          ],
        );
      case "number":
        return Column(
          children: [
            TextField(
              controller: _numberController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.black), // Texto preto
              decoration: const InputDecoration(
                labelText: "Digite o número de dias (0 a 30)",
                border: OutlineInputBorder(),
                labelStyle:
                    TextStyle(color: Colors.black), // Texto do label preto
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _handleNumberAnswer(),
              style: ElevatedButton.styleFrom(
                textStyle: AppTextStyles.buttonText, // Texto branco
                minimumSize: const Size(double.infinity, 50), // Largura total
              ),
              child: const Text("Próximo"),
            ),
          ],
        );
      case "number_imc":
        return Column(
          children: [
            TextField(
              controller: _numberController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.black), // Texto preto
              decoration: const InputDecoration(
                labelText: "Digite o número do seu IMC",
                border: OutlineInputBorder(),
                labelStyle:
                    TextStyle(color: Colors.black), // Texto do label preto
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _handleNumberImcAnswer(),
              style: ElevatedButton.styleFrom(
                textStyle: AppTextStyles.buttonText, // Texto branco
                minimumSize: const Size(double.infinity, 50), // Largura total
              ),
              child: const Text("Próximo"),
            ),
          ],
        );
      case "choose":
        return Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0), // Margem vertical
              child: ElevatedButton(
                onPressed: () => _handleChooseAnswer("18-24"),
                style: ElevatedButton.styleFrom(
                  textStyle: AppTextStyles.buttonText, // Texto branco
                  minimumSize: const Size(double.infinity, 50), // Largura total
                ),
                child: const Text("18-24"),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0), // Margem vertical
              child: ElevatedButton(
                onPressed: () => _handleChooseAnswer("25-29"),
                style: ElevatedButton.styleFrom(
                  textStyle: AppTextStyles.buttonText, // Texto branco
                  minimumSize: const Size(double.infinity, 50), // Largura total
                ),
                child: const Text("25-29"),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0), // Margem vertical
              child: ElevatedButton(
                onPressed: () => _handleChooseAnswer("30-34"),
                style: ElevatedButton.styleFrom(
                  textStyle: AppTextStyles.buttonText, // Texto branco
                  minimumSize: const Size(double.infinity, 50), // Largura total
                ),
                child: const Text("30-34"),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0), // Margem vertical
              child: ElevatedButton(
                onPressed: () => _handleChooseAnswer("35-39"),
                style: ElevatedButton.styleFrom(
                  textStyle: AppTextStyles.buttonText, // Texto branco
                  minimumSize: const Size(double.infinity, 50), // Largura total
                ),
                child: const Text("35-39"),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0), // Margem vertical
              child: ElevatedButton(
                onPressed: () => _handleChooseAnswer("40-44"),
                style: ElevatedButton.styleFrom(
                  textStyle: AppTextStyles.buttonText, // Texto branco
                  minimumSize: const Size(double.infinity, 50), // Largura total
                ),
                child: const Text("40-44"),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0), // Margem vertical
              child: ElevatedButton(
                onPressed: () => _handleChooseAnswer("45-49"),
                style: ElevatedButton.styleFrom(
                  textStyle: AppTextStyles.buttonText, // Texto branco
                  minimumSize: const Size(double.infinity, 50), // Largura total
                ),
                child: const Text("45-49"),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0), // Margem vertical
              child: ElevatedButton(
                onPressed: () => _handleChooseAnswer("50-54"),
                style: ElevatedButton.styleFrom(
                  textStyle: AppTextStyles.buttonText, // Texto branco
                  minimumSize: const Size(double.infinity, 50), // Largura total
                ),
                child: const Text("50-54"),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0), // Margem vertical
              child: ElevatedButton(
                onPressed: () => _handleChooseAnswer("55-59"),
                style: ElevatedButton.styleFrom(
                  textStyle: AppTextStyles.buttonText, // Texto branco
                  minimumSize: const Size(double.infinity, 50), // Largura total
                ),
                child: const Text("55-59"),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0), // Margem vertical
              child: ElevatedButton(
                onPressed: () => _handleChooseAnswer("60-64"),
                style: ElevatedButton.styleFrom(
                  textStyle: AppTextStyles.buttonText, // Texto branco
                  minimumSize: const Size(double.infinity, 50), // Largura total
                ),
                child: const Text("60-64"),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0), // Margem vertical
              child: ElevatedButton(
                onPressed: () => _handleChooseAnswer("65-69"),
                style: ElevatedButton.styleFrom(
                  textStyle: AppTextStyles.buttonText, // Texto branco
                  minimumSize: const Size(double.infinity, 50), // Largura total
                ),
                child: const Text("65-69"),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0), // Margem vertical
              child: ElevatedButton(
                onPressed: () => _handleChooseAnswer("70-74"),
                style: ElevatedButton.styleFrom(
                  textStyle: AppTextStyles.buttonText, // Texto branco
                  minimumSize: const Size(double.infinity, 50), // Largura total
                ),
                child: const Text("70-74"),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0), // Margem vertical
              child: ElevatedButton(
                onPressed: () => _handleChooseAnswer("75-79"),
                style: ElevatedButton.styleFrom(
                  textStyle: AppTextStyles.buttonText, // Texto branco
                  minimumSize: const Size(double.infinity, 50), // Largura total
                ),
                child: const Text("75-79"),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0), // Margem vertical
              child: ElevatedButton(
                onPressed: () => _handleChooseAnswer("80+"),
                style: ElevatedButton.styleFrom(
                  textStyle: AppTextStyles.buttonText, // Texto branco
                  minimumSize: const Size(double.infinity, 50), // Largura total
                ),
                child: const Text("80+"),
              ),
            ),
          ],
        );
      default:
        return SizedBox.shrink();
    }
  }

  // Função para lidar com respostas booleanas
  void _handleBooleanAnswer(String answer) {
    // Converter "Sim" para 1 e "Não" para 0 e armazenar
    int numericAnswer = (answer == "Sim") ? 1 : 0;
    answersResponses.add(numericAnswer);

    if (_questionIndex < questions.length - 1) {
      setState(() {
        _questionIndex++;
      });
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/result',
        (route) => false,
        arguments: answersResponses,
      );
    }
  }

  // Função para lidar com resposta booleana de sexo
  void _handleBooleanSexAnswer(String answer) {
    int numericAnswer = (answer == "M") ? 1 : 0;
    answersResponses.add(numericAnswer);

    if (_questionIndex < questions.length - 1) {
      setState(() {
        _questionIndex++;
      });
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/result',
        (route) => false,
        arguments: answersResponses,
      );
    }
  }

  // Função para lidar com respostas de escala
  void _handleScaleAnswer(int answer) {
    // Armazenar resposta (1 a 5)
    answersResponses.add(answer);

    if (_questionIndex < questions.length - 1) {
      setState(() {
        _questionIndex++;
        _currentScaleValue = 3; // Resetar o valor da escala
      });
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/result',
        (route) => false,
        arguments: answersResponses,
      );
    }
  }

  // Função para lidar com respostas numéricas
  void _handleNumberAnswer() {
    String input = _numberController.text;
    int? number = int.tryParse(input);

    if (number == null || number < 0 || number > 30) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Por favor, insira um número válido de 0 a 30.',
            style: TextStyle(color: Colors.black), // Texto preto
          ),
          backgroundColor: Colors.white, // Fundo claro para contraste
        ),
      );
      return;
    }

    // Armazenar resposta (0 a 30)
    answersResponses.add(number);

    _numberController.clear(); // Limpar o campo de entrada

    if (_questionIndex < questions.length - 1) {
      setState(() {
        _questionIndex++;
      });
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/result',
        (route) => false,
        arguments: answersResponses,
      );
    }
  }

  // Função para lidar com resposta numérica de IMC
  void _handleNumberImcAnswer() {
    String input = _numberController.text;
    int? number = int.tryParse(input);

    if (number == null || number < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Por favor, insira um número válido.',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
      );
      return;
    }

    answersResponses.add(number);

    _numberController.clear();

    if (_questionIndex < questions.length - 1) {
      setState(() {
        _questionIndex++;
      });
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/result',
        (route) => false,
        arguments: answersResponses,
      );
    }
  }

  // Função para lidar com respostas de escolha
  void _handleChooseAnswer(String answer) {
    int numericAnswer = 0;
    switch(answer) {
      case "18-24":
        numericAnswer = 1;
      case "25-29":
        numericAnswer = 2;
      case "30-34":
        numericAnswer = 3;
      case "35-39":
        numericAnswer = 4;
      case "40-44":
        numericAnswer = 5;
      case "45-49":
        numericAnswer = 6;
      case "50-54":
        numericAnswer = 7;
      case "55-59":
        numericAnswer = 8;
      case "60-64":
        numericAnswer = 9;
      case "65-69":
        numericAnswer = 10;
      case "70-74":
        numericAnswer = 11;
      case "75-79":
        numericAnswer = 12;
      case "80+":
        numericAnswer = 13;
    }
    
    answersResponses.add(numericAnswer);

    if (_questionIndex < questions.length - 1) {
      setState(() {
        _questionIndex++;
      });
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/result',
        (route) => false,
        arguments: answersResponses,
      );
    }
  }
}
