// lib/loading_screen.dart

import 'package:flutter/material.dart';
import 'package:test_diabetic/main_navigation.dart'; // Importar MainNavigation
import 'package:test_diabetic/themes.dart'; // Importação correta do themes.dart

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToMain();
  }

  void _navigateToMain() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainNavigation()),
    );
    // Alternativamente, você pode usar Navigator.pushNamed se definir rotas
    // Navigator.pushReplacementNamed(context, '/main');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.local_hospital,
              size: 100.0,
              color: AppColors.primaryColor,
            ),
            const SizedBox(height: 20),
            Text(
              "Diabetes Detector",
              style: AppTextStyles.displayMedium.copyWith(
                  color: const Color.fromARGB(
                      255, 0, 0, 0)), // Definir a cor do texto como preto
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
