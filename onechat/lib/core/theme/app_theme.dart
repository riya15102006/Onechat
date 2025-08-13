import 'package:flutter/material.dart';

class AppColors {
	static const Color neonPurple = Color(0xFF8A2BE2);
	static const Color neonPink = Color(0xFFFF2D95);
	static const Color darkBg = Color(0xFF0E0E12);
	static const Color card = Color(0xFF1A1B23);
	static const Color success = Color(0xFF00E5A8);
	static const Color warning = Color(0xFFFFC857);
	static const Color danger = Color(0xFFFF4D4D);
}

class AppTheme {
	static ThemeData get dark {
		final colorScheme = const ColorScheme.dark(
			primary: AppColors.neonPurple,
			secondary: AppColors.neonPink,
			background: AppColors.darkBg,
			surface: AppColors.card,
			tertiary: AppColors.success,
			error: AppColors.danger,
		);

		return ThemeData(
			colorScheme: colorScheme,
			useMaterial3: true,
			fontFamily: 'Roboto',
			scaffoldBackgroundColor: AppColors.darkBg,
			appBarTheme: const AppBarTheme(
				elevation: 0,
				backgroundColor: Colors.transparent,
				surfaceTintColor: Colors.transparent,
			),
			cardTheme: CardTheme(
				color: AppColors.card,
				shape: RoundedRectangleBorder(
					borderRadius: BorderRadius.circular(20),
				),
			),
			elevatedButtonTheme: ElevatedButtonThemeData(
				style: ElevatedButton.styleFrom(
					backgroundColor: AppColors.neonPurple,
					foregroundColor: Colors.white,
					shape: RoundedRectangleBorder(
						borderRadius: BorderRadius.circular(16),
					),
					padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
				),
			),
			inputDecorationTheme: InputDecorationTheme(
				filled: true,
				fillColor: AppColors.card,
				border: OutlineInputBorder(
					borderRadius: BorderRadius.circular(16),
					borderSide: BorderSide.none,
				),
			),
		);
	}

	static LinearGradient get neonGradient => const LinearGradient(
		colors: [AppColors.neonPurple, AppColors.neonPink],
		begin: Alignment.topLeft,
		end: Alignment.bottomRight,
	);
}