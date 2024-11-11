// lib/themes.dart

import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF6200EA);
  static const Color secondaryColor = Color(0xFF03DAC6);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color textColor = Color(0xFF000000);
  static const Color errorColor = Color(0xFFB00020);
  static const Color whiteColor = Color(0xFFFFFFFF); // Adicionado
}

class AppTextStyles {
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
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: AppColors.whiteColor, // Ajustado para branco
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
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor, // Cor de fundo ajustada
          textStyle: AppTextStyles.buttonText, // Texto branco
        ),
      ),
      appBarTheme: const AppBarTheme(
        titleTextStyle: AppTextStyles.displayMedium, // Texto branco
        iconTheme: IconThemeData(color: AppColors.whiteColor), // Ícones brancos
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: const Color.fromARGB(255, 255, 255, 255),
        secondary: AppColors.secondaryColor,
        error: AppColors.errorColor,
      ),
    );
  }
}
