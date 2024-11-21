// lib/questionnaire_page.dart

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_diabetic/main_navigation.dart';
import 'package:frontend_diabetic/pages/home_page.dart';
import 'package:frontend_diabetic/pages/resultquestion_page.dart';
import 'package:frontend_diabetic/themes.dart'; // Importação correta
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend_diabetic/pages/resultquestion_page.dart' as rq;
import 'package:http/http.dart' as http;
import 'package:frontend_diabetic/models/result.dart';

class QuestionnairePage extends StatefulWidget {
  const QuestionnairePage({super.key});

  @override
  _QuestionnairePageState createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  int _questionIndex = 0;

  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  // Armazenar respostas como inteiros: Sim=1, Não=0 e outros números correspondentes
  final List<int> answersResponses = [];

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
      "question":
          "Você tem doença arterial coronariana (DAC) ou teve ataque cardíaco (AC) ?",
      "type": "boolean",
    },
    {
      "question":
          "Você praticou atividades físicas nos últimos 30 dias (exceto no trabalho)?",
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
      "question":
          "Você consome álcool em excesso (homens: mais de 14 bebidas por semana, mulheres: mais de 7 bebidas por semana)?",
      "type": "boolean",
    },
    {
      "question":
          "Como você avaliaria sua saúde geral ? (Escala de 1 a 5, onde 1 = Excelente e 5 = Ruim)",
      "type": "scale",
    },
    {
      "question":
          "Quantos dias nos últimos 30 dias sua saúde mental não esteve boa ?",
      "type": "number",
    },
    {
      "question":
          "Quantos dias nos últimos 30 dias sua saúde física não esteve boa ?",
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
      "question": "Qual a sua idade ?",
      "type": "number_Idade",
    },
  ];

  @override
  void dispose() {
    _numberController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _nextQuestion() {
    setState(() {
      _questionIndex++;
    });
  }

  void _previousQuestion() {
    if (_questionIndex > 0) {
      setState(() {
        _questionIndex--;
        answersResponses.removeLast();
      });
    }
  }

  void _handleBooleanSexAnswer(String sex) {
    int sexValue = sex == "M" ? 1 : 0;
    answersResponses.add(sexValue);
    _nextQuestion();
  }

  void _handleBooleanAnswer(int answer) {
    answersResponses.add(answer);
    _nextQuestion();
  }

  void _handleNumberAnswer() {
    int? number = int.tryParse(_numberController.text);
    if (number != null) {
      answersResponses.add(number);
      _numberController.clear();
      _nextQuestion();
    } else {
      _showErrorMessage("Por favor, insira um número válido.");
    }
  }

  void _handleScaleAnswer(int value) {
    answersResponses.add(value);
    _nextQuestion();
  }

  void _handleImcAnswer() {
    double? imc = double.tryParse(_numberController.text.replaceAll(',', '.'));
    if (imc != null) {
      int imcCategory = _getImcCategory(imc);
      answersResponses.add(imcCategory);
      _numberController.clear();
      _nextQuestion();
    } else {
      _showErrorMessage("Por favor, insira um IMC válido.");
    }
  }

  int _getImcCategory(double imc) {
    if (imc < 18.5)
      return 1;
    else if (imc >= 18.5 && imc <= 24.9)
      return 2;
    else if (imc >= 25 && imc <= 29.9)
      return 3;
    else if (imc >= 30)
      return 4;
    else
      return 0; // IMC inválido
  }

  // Função para lidar com a resposta da idade
  Future<void> _handleAgeAnswer() async {
    int? age = int.tryParse(_ageController.text);
    if (age != null && age >= 0 && age <= 100) {
      int ageGroupNumber = _getAgeGroupNumber(age);
      answersResponses.add(ageGroupNumber);
      _ageController.clear();

      // Enviar as respostas para a API
      String prediction = await sendRespostas(answersResponses);

      // Obter a recomendação baseada na previsão
      String recomendacao = getRecomendacao(prediction);

      // Obter a data e hora atual
      String timestamp = DateTime.now().toIso8601String();

      // Salvar as respostas, recomendação e timestamp
      await _saveResults(recomendacao, timestamp);

      // Mostrar o pop-up com a recomendação e resultados
      _showCompletionDialog();
    } else {
      _showErrorMessage("Por favor, digite sua idade.");
    }
  }

  int _getAgeGroupNumber(int age) {
    if (age >= 0 && age <= 17)
      return 0;
    else if (age >= 18 && age <= 24)
      return 1;
    else if (age >= 25 && age <= 29)
      return 2;
    else if (age >= 30 && age <= 34)
      return 3;
    else if (age >= 35 && age <= 39)
      return 4;
    else if (age >= 40 && age <= 44)
      return 5;
    else if (age >= 45 && age <= 49)
      return 6;
    else if (age >= 50 && age <= 54)
      return 7;
    else if (age >= 55 && age <= 59)
      return 8;
    else if (age >= 60 && age <= 64)
      return 9;
    else if (age >= 65 && age <= 69)
      return 10;
    else if (age >= 70 && age <= 74)
      return 11;
    else if (age >= 75 && age <= 79)
      return 12;
    else if (age >= 80 && age <= 100)
      return 13;
    else
      return 0; // Idade inválida
  }

  Future<void> _saveResults(String recomendacao, String timestamp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Recuperar a lista existente de resultados
    List<String> existingResults = prefs.getStringList('results') ?? [];

    // Criar um novo Result
    Result newResult = Result(
      timestamp: timestamp,
      recomendacao: recomendacao,
      responses: answersResponses.map((e) => e.toString()).toList(),
    );

    // Converter o Result para JSON string
    String newResultJson = newResult.toJsonString();

    // Adicionar o novo resultado à lista existente
    existingResults.add(newResultJson);

    // Salvar a lista atualizada de resultados
    await prefs.setStringList('results', existingResults);
  }

  Future<String> sendRespostas(List<int> respostas) async {
    final String url = 'https://e841-186-249-39-125.ngrok-free.app/predict';
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
        return 'Erro';
      }
    } catch (e) {
      return 'Erro';
    }
  }

  String getRecomendacao(String resultado) {
    switch (resultado) {
      case "sem diabetes":
        return "Seu nível de risco é **Baixo**.\n"
            "Continue mantendo hábitos saudáveis, como uma alimentação equilibrada, prática regular de exercícios físicos e controle do peso.";
      case "com diabetes":
        return "Seu nível de risco é **Alto**.\n"
            "Recomendamos consultar um profissional de saúde para orientação personalizada. "
            "Adotar uma rotina de monitoramento glicêmico, seguir uma dieta adequada e realizar atividades físicas podem ajudar a controlar a condição.";
      default:
        return "Nível de risco desconhecido.\n"
            "Pode ter ocorrido um problema de conexão com o sistema. Por favor, tente novamente mais tarde ou verifique sua conexão com a internet.";
    }
  }

  // Função para mostrar o pop-up de conclusão
  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Evita fechar o diálogo ao tocar fora
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Questionário Completo',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Cor do título para preto
            ),
          ),
          content: const Text(
            'Obrigado por completar o questionário!',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black, // Cor do texto para preto
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const ResultQuestionPage()),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                textStyle: AppTextStyles.buttonText,
                backgroundColor: AppColors.primaryColor,
                minimumSize: const Size(150, 50),
              ),
              child: const Text(
                'Ver Resultados',
                style: TextStyle(color: Colors.white),
              ),
            ),
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
                backgroundColor: AppColors.secondaryColor,
                minimumSize: const Size(150, 50),
              ),
              child: const Text(
                'Home',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  // Função para mostrar mensagem de erro
  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget _buildAnswerWidget(String answerType) {
    switch (answerType) {
      case "boolean":
        return Column(
          children: [
            ElevatedButton.icon(
              onPressed: () => _handleBooleanAnswer(1),
              icon: const Icon(Icons.check),
              label: const Text("Sim"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: AppColors.primaryColor, // Texto branco
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => _handleBooleanAnswer(0),
              icon: const Icon(Icons.close),
              label: const Text("Não"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: AppColors.secondaryColor, // Texto branco
              ),
            ),
          ],
        );
      case "boolean_sex":
        return Column(
          children: [
            ElevatedButton.icon(
              onPressed: () => _handleBooleanSexAnswer("M"),
              icon: const Icon(Icons.male),
              label: const Text("Masculino"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: AppColors.primaryColor, // Texto branco
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => _handleBooleanSexAnswer("F"),
              icon: const Icon(Icons.female),
              label: const Text("Feminino"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: AppColors.secondaryColor, // Texto branco
              ),
            ),
          ],
        );
      case "scale":
        return Column(
          children: List.generate(5, (index) {
            int value = index + 1;
            String label = _getHealthScaleLabel(value);
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: ElevatedButton.icon(
                onPressed: () => _handleScaleAnswer(value),
                icon: const Icon(
                  Icons.star,
                  color: Colors.white, // Ícone branco
                ),
                label: Text(label),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: value <= 2 ? Colors.green : Colors.red,
                  foregroundColor: Colors.white, // Texto branco
                ),
              ),
            );
          }),
        );
      case "number_imc":
        return Column(
          children: [
            TextField(
              controller: _numberController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: "Digite o seu IMC",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                ),
                labelStyle: const TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleImcAnswer,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: AppColors.primaryColor, // Texto branco
              ),
              child: const Text("Próximo"),
            ),
          ],
        );
      case "number_age":
      case "number_Idade":
      case "number":
        return Column(
          children: [
            TextField(
              controller: answerType == "number_Idade"
                  ? _ageController
                  : _numberController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: answerType == "number_Idade"
                    ? "Digite a sua idade (0 a 100)"
                    : "Digite um número",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                ),
                labelStyle: const TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: answerType == "number_Idade"
                  ? _handleAgeAnswer
                  : _handleNumberAnswer,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: AppColors.primaryColor, // Texto branco
              ),
              child: const Text("Próximo"),
            ),
          ],
        );
      default:
        return Container();
    }
  }

  String _getHealthScaleLabel(int value) {
    switch (value) {
      case 1:
        return "Excelente";
      case 2:
        return "Muito boa";
      case 3:
        return "Boa";
      case 4:
        return "Regular";
      case 5:
        return "Ruim";
      default:
        return "";
    }
  }

  Widget _buildProgressIndicator() {
    double progress = (_questionIndex + 1) / questions.length;
    return LinearProgressIndicator(
      value: progress,
      backgroundColor: Colors.grey[300],
      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_questionIndex >= questions.length) {
      // Nenhuma ação necessária aqui, já tratada no _handleAgeAnswer
      return Container();
    }

    String questionText = questions[_questionIndex]['question'];
    String answerType = questions[_questionIndex]['type'];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Questionário"),
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildProgressIndicator(),
            const SizedBox(height: 20),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      questionText,
                      style: AppTextStyles.titleText,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    _buildAnswerWidget(answerType),
                  ],
                ),
              ),
            ),
            if (_questionIndex > 0 && answerType != "boolean_sex")
              Align(
                alignment: Alignment.bottomLeft,
                child: TextButton.icon(
                  onPressed: _previousQuestion,
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  label: const Text(
                    "Voltar",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
