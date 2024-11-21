// lib/main_navigation.dart

import 'package:flutter/material.dart';
import 'package:test_diabetic/themes.dart';
import 'package:test_diabetic/pages/home_page.dart';
import 'package:test_diabetic/pages/questionnaire_page.dart';
import 'package:test_diabetic/pages/satisfactionsurvey_page.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  // Lista das páginas correspondentes a cada aba (sem ResultQuestionPage)
  static const List<Widget> _pages = <Widget>[
    HomePage(),
    QuestionnairePage(),
    SatisfactionSurveyPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Exibe a página selecionada
      body: _pages[_selectedIndex],
      // BottomNavigationBar com 3 itens agora
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            label: 'Questionário',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feedback),
            label: 'Satisfação',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primaryColor, // Cor dos itens selecionados
        unselectedItemColor:
            AppColors.secondaryColor, // Cor dos itens não selecionados
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // Necessário para mais de 3 itens
      ),
    );
  }
}
