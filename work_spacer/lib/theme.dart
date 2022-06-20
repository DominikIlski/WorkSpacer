import 'package:flutter/material.dart';

ThemeData prepareLightTheme() {
  final baseTheme = ThemeData.light();

  return baseTheme.copyWith(
    colorScheme: _lightColorScheme,
    textTheme: TextTheme(
      subtitle1: baseTheme.textTheme.subtitle1?.copyWith(
        fontFamily: 'Lato',
        color: _lightColorScheme.onBackground,
      ),
      headline6: baseTheme.textTheme.headline6?.copyWith(
        fontFamily: 'Lato',
        fontWeight: FontWeight.bold,
        color: _lightColorScheme.onBackground,
      ),
      bodyText1: baseTheme.textTheme.bodyText1?.copyWith(
        fontFamily: 'Lato',
        color: _lightColorScheme.onSurfaceVariant,
      ),
    ),
    appBarTheme: baseTheme.appBarTheme.copyWith(
      elevation: 0,
      backgroundColor: _lightColorScheme.background,
      foregroundColor: _lightColorScheme.onBackground,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: _lightColorScheme.background,
    ),
    scaffoldBackgroundColor: _lightColorScheme.background,
    cardTheme: baseTheme.cardTheme.copyWith(
      color: _lightColorScheme.background,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    listTileTheme: ListTileThemeData(
      iconColor: _lightColorScheme.onPrimaryContainer,
      textColor: _lightColorScheme.onPrimaryContainer,
      selectedColor: _lightColorScheme.onPrimary,
      tileColor: _lightColorScheme.primaryContainer,
      selectedTileColor: _lightColorScheme.primary,
      contentPadding: const EdgeInsets.all(24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    dividerTheme: DividerThemeData(
      space: 0,
      color: _lightColorScheme.outline,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(
            fontFamily: 'Lato',
            fontSize: 16,
          ),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(
            fontFamily: 'Lato',
            fontSize: 16,
          ),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}

ThemeData prepareDarkTheme() {
  final baseTheme = ThemeData.dark();

  return baseTheme.copyWith(
    colorScheme: _darkColorScheme,
    textTheme: TextTheme(
      subtitle1: baseTheme.textTheme.subtitle1?.copyWith(
        fontFamily: 'Lato',
        color: _darkColorScheme.onBackground,
      ),
      headline6: baseTheme.textTheme.headline6?.copyWith(
        fontFamily: 'Lato',
        fontWeight: FontWeight.bold,
        color: _darkColorScheme.onBackground,
      ),
      bodyText1: baseTheme.textTheme.bodyText1?.copyWith(
        fontFamily: 'Lato',
        color: _darkColorScheme.onSurfaceVariant,
      ),
    ),
    appBarTheme: baseTheme.appBarTheme.copyWith(
      elevation: 0,
      backgroundColor: _darkColorScheme.background,
      foregroundColor: _darkColorScheme.onBackground,
    ),
    scaffoldBackgroundColor: _darkColorScheme.background,
    cardTheme: baseTheme.cardTheme.copyWith(
      color: _darkColorScheme.surfaceVariant,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    listTileTheme: ListTileThemeData(
      iconColor: _darkColorScheme.onPrimaryContainer,
      textColor: _darkColorScheme.onPrimaryContainer,
      selectedColor: _darkColorScheme.onPrimary,
      tileColor: _darkColorScheme.primaryContainer,
      selectedTileColor: _darkColorScheme.primary,
      contentPadding: const EdgeInsets.all(24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    dividerTheme: DividerThemeData(
      space: 0,
      color: _darkColorScheme.outline,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(
            fontFamily: 'Lato',
            fontSize: 16,
          ),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(
            fontFamily: 'Lato',
            fontSize: 16,
          ),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 12),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}

const _lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF0061A4),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFD1E4FF),
  onPrimaryContainer: Color(0xFF001D36),
  secondary: Color(0xFF535F70),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFD7E3F7),
  onSecondaryContainer: Color(0xFF101C2B),
  tertiary: Color(0xFF6B5778),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFF2DAFF),
  onTertiaryContainer: Color(0xFF251431),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFDFCFF),
  onBackground: Color(0xFF1A1C1E),
  surface: Color(0xFFFDFCFF),
  onSurface: Color(0xFF1A1C1E),
  surfaceVariant: Color(0xFFDFE2EB),
  onSurfaceVariant: Color(0xFF43474E),
  outline: Color(0xFF73777F),
  onInverseSurface: Color(0xFFF1F0F4),
  inverseSurface: Color(0xFF2F3033),
  inversePrimary: Color(0xFF9ECAFF),
  shadow: Color(0xFF000000),
);

const _darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF9ECAFF),
  onPrimary: Color(0xFF003258),
  primaryContainer: Color(0xFF00497D),
  onPrimaryContainer: Color(0xFFD1E4FF),
  secondary: Color(0xFFBBC7DB),
  onSecondary: Color(0xFF253140),
  secondaryContainer: Color(0xFF3B4858),
  onSecondaryContainer: Color(0xFFD7E3F7),
  tertiary: Color(0xFFD6BEE4),
  onTertiary: Color(0xFF3B2948),
  tertiaryContainer: Color(0xFF523F5F),
  onTertiaryContainer: Color(0xFFF2DAFF),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF1A1C1E),
  onBackground: Color(0xFFE2E2E6),
  surface: Color(0xFF1A1C1E),
  onSurface: Color(0xFFE2E2E6),
  surfaceVariant: Color(0xFF43474E),
  onSurfaceVariant: Color(0xFFC3C7CF),
  outline: Color(0xFF8D9199),
  onInverseSurface: Color(0xFF1A1C1E),
  inverseSurface: Color(0xFFE2E2E6),
  inversePrimary: Color(0xFF0061A4),
  shadow: Color(0xFF000000),
);
