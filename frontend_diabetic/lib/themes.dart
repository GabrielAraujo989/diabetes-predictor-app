// lib/themes.dart

import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color.fromARGB(255, 5, 132, 229);
  static const Color secondaryColor = Color.fromARGB(255, 6, 177, 160);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color textColor2 = Color(0xFF000000);
  static const Color errorColor = Color(0xFFB00020);
  static const Color whiteColor = Color(0xFFFFFFFF); // Adicionado
  static const Color textColor =
      Colors.white; // Defina a cor conforme necessário
}

class AppTextStyles {
  static const TextStyle titleText = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 16,
    color: Colors.black,
    // Outros atributos de estilo conforme necessário
  );

  static const TextStyle subtitleText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static const TextStyle displayLarge = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: AppColors.whiteColor, // Ajustado para branco
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16.0,
    color: AppColors.textColor,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14.0,
    color: AppColors.textColor,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static const TextStyle buttonText2 = TextStyle(
    fontSize: 14,
    color: Colors.black,
  );
}

class AppThemes {
  static ThemeData getThemeData() {
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      textTheme: const TextTheme(
        displayLarge: AppTextStyles.displayLarge,
        displayMedium: AppTextStyles.displayMedium,
        bodyLarge: AppTextStyles.bodyLarge,
        bodyMedium: AppTextStyles.bodyMedium,
        titleMedium: AppTextStyles.subtitleText,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor, // Cor de fundo ajustada
          textStyle: AppTextStyles.buttonText, // Texto branco
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.black,
          textStyle: AppTextStyles.bodyText,
        ),
      ),
      appBarTheme: const AppBarTheme(
        titleTextStyle: AppTextStyles.displayMedium, // Texto branco
        iconTheme: IconThemeData(color: AppColors.whiteColor), // Ícones brancos
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: AppColors.primaryColor,
        secondary: AppColors.secondaryColor,
        error: AppColors.errorColor,
      ),
    );
  }
}
