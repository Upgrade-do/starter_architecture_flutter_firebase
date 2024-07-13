import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starter_architecture_flutter_firebase/src/theme/colors_palette.dart';
import 'package:starter_architecture_flutter_firebase/src/theme/text_styles.dart';

class AppTheme {
  static ColorsPalette lightColorsPalette = ColorsPalette.light;
  static ColorsPalette darkColorsPalette = ColorsPalette.dark;

  static TextStyles textStyles =
      TextStyles.fromColorsPalette(lightColorsPalette);

  static ColorScheme lightColorScheme = ThemeData().colorScheme.copyWith(
        primary: lightColorsPalette.primary,
        onPrimary: lightColorsPalette.white,
        primaryContainer: lightColorsPalette.primary40,
        onPrimaryContainer: lightColorsPalette.black,
        secondary: lightColorsPalette.secondary,
        onSecondary: lightColorsPalette.white,
        secondaryContainer: lightColorsPalette.secondary40,
        onSecondaryContainer: lightColorsPalette.black,
        tertiary: lightColorsPalette.tertiary,
        onTertiary: lightColorsPalette.white,
        tertiaryContainer: lightColorsPalette.ternary20,
        onTertiaryContainer: lightColorsPalette.black,
        error: lightColorsPalette.negativeAction,
        onError: lightColorsPalette.white,
        errorContainer: lightColorsPalette.negativeActionSoft,
        onErrorContainer: lightColorsPalette.black,
        background: lightColorsPalette.neutral1,
        onBackground: lightColorsPalette.neutral9,
        surface: lightColorsPalette.white,
        onSurface: lightColorsPalette.neutral9,
        surfaceVariant: lightColorsPalette.neutral4,
        onSurfaceVariant: lightColorsPalette.neutral7,
        surfaceTint: lightColorsPalette.primary,
        outline: lightColorsPalette.neutral6,
        shadow: lightColorsPalette.black,
        inversePrimary: lightColorsPalette.primary70,
        inverseSurface: lightColorsPalette.neutral9,
        onInverseSurface: lightColorsPalette.neutral1,
        // inverseBackground: colorsPalette.darkBG,
        brightness: Brightness.light,
      );

  static ColorScheme darkColorScheme = ThemeData().colorScheme.copyWith(
        primary: darkColorsPalette.primary,
        onPrimary: darkColorsPalette.black,
        primaryContainer: darkColorsPalette.primary40,
        onPrimaryContainer: darkColorsPalette.white,
        secondary: darkColorsPalette.secondary,
        onSecondary: darkColorsPalette.black,
        secondaryContainer: darkColorsPalette.secondary40,
        onSecondaryContainer: darkColorsPalette.white,
        tertiary: darkColorsPalette.tertiary,
        onTertiary: darkColorsPalette.black,
        tertiaryContainer: darkColorsPalette.ternary20,
        onTertiaryContainer: darkColorsPalette.white,
        error: darkColorsPalette.negativeAction,
        onError: darkColorsPalette.black,
        errorContainer: darkColorsPalette.negativeActionSoft,
        onErrorContainer: darkColorsPalette.white,
        background: darkColorsPalette.neutral1,
        onBackground: darkColorsPalette.neutral9,
        surface: darkColorsPalette.darkBG,
        onSurface: darkColorsPalette.neutral9,
        surfaceVariant: darkColorsPalette.neutral4,
        onSurfaceVariant: darkColorsPalette.neutral7,
        surfaceTint: darkColorsPalette.primary,
        outline: darkColorsPalette.neutral6,
        shadow: darkColorsPalette.black,
        inversePrimary: darkColorsPalette.primary70,
        inverseSurface: darkColorsPalette.neutral9,
        onInverseSurface: darkColorsPalette.neutral1,
        brightness: Brightness.dark,
      );
  static ThemeData getLight() => ThemeData(
        useMaterial3: true,
        cupertinoOverrideTheme: CupertinoThemeData(
          primaryColor: lightColorsPalette.primary,
        ),
        primaryColor: lightColorsPalette.white,
        focusColor: lightColorsPalette.secondary,
        colorScheme: lightColorScheme,
        textTheme: TextTheme(
          displayLarge: textStyles.displayLarge,
          displayMedium: textStyles.displayMedium,
          displaySmall: textStyles.displaySmall,
          headlineLarge: textStyles.headlineLarge,
          headlineMedium: textStyles.headlineMedium,
          headlineSmall: textStyles.headlineSmall,
          titleLarge: textStyles.titleLarge,
          titleMedium: textStyles.titleMedium,
          titleSmall: textStyles.titleSmall,
          bodyLarge: textStyles.bodyLarge,
          bodyMedium: textStyles.bodyMedium,
          bodySmall: textStyles.bodySmall,
          labelLarge: textStyles.labelLarge,
          labelMedium: textStyles.labelMedium,
          labelSmall: textStyles.labelSmall,
          // button: textStyles.textButton,
          // caption: textStyles.labelMedium, // Added for completeness
          // overline: textStyles.labelSmall, // Added for completeness
        ),
      );
  static ThemeData getDark() => ThemeData(
        useMaterial3: true,
        cupertinoOverrideTheme: CupertinoThemeData(
          primaryColor: darkColorsPalette.primary,
        ),
        primaryColor: darkColorsPalette.white,
        focusColor: darkColorsPalette.secondary,
        colorScheme: darkColorScheme,
        textTheme: TextTheme(
          displayLarge: textStyles.displayLarge,
          displayMedium: textStyles.displayMedium,
          displaySmall: textStyles.displaySmall,
          headlineLarge: textStyles.headlineLarge,
          headlineMedium: textStyles.headlineMedium,
          headlineSmall: textStyles.headlineSmall,
          titleLarge: textStyles.titleLarge,
          titleMedium: textStyles.titleMedium,
          titleSmall: textStyles.titleSmall,
          bodyLarge: textStyles.bodyLarge,
          bodyMedium: textStyles.bodyMedium,
          bodySmall: textStyles.bodySmall,
          labelLarge: textStyles.labelLarge,
          labelMedium: textStyles.labelMedium,
          labelSmall: textStyles.labelSmall,
        ),
      );
}

class CustomAppTheme {
  CustomAppTheme({required this.colorsPalette}) {
    textStyles = TextStyles.fromColorsPalette(colorsPalette);
  }
  ColorsPalette colorsPalette;
  late TextStyles textStyles;
}

final appThemeProvider = Provider<CustomAppTheme>(
  (ref) => CustomAppTheme(
    colorsPalette: ColorsPalette.light,
  ),
);
