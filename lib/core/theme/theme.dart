import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF17405E);
const Color secondaryColor = Color(0xFF4A90E2);
const Color scaffoldBackgroundColor = Color(0xFFF9FAFB);
const Color cardBackgroundColor = Colors.white;
const Color errorColor = Color(0xFFD32F2F);
const Color successColor = Color(0xFF28a745);
const Color whatsappColor = Color(0xFF25D366);
const Color darkTextColor = Color(0xFF1F2937);
const Color mediumTextColor = Color(0xFF6B7280);
const Color lightTextColor = Color(0xFF374151);
const Color lightBorderColor = Color(0xFFD1D5DB);
const Color shadowColor = Color(0x1A000000);
const Color subtleBorderColor = Color(0xFFE2E8F0);
const double kDefaultBorderRadius = 8.0;
const double kCardBorderRadius = 12.0;
const double kDialogBorderRadius = 16.0;

TextTheme kTextTheme = TextTheme(
  headlineLarge: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: darkTextColor,
  ),
  headlineMedium: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: darkTextColor,
  ),
  headlineSmall: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: darkTextColor,
  ),

  titleLarge: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: darkTextColor,
  ),
  titleMedium: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: darkTextColor,
  ),
  titleSmall: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: darkTextColor,
  ),

  bodyLarge: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: lightTextColor,
  ),
  bodyMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: lightTextColor,
  ),
  bodySmall: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: lightTextColor,
  ),

  labelLarge: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
  ),
  labelMedium: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  ),
  labelSmall: TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  ),
);

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,

  colorScheme: const ColorScheme.light(
    primary: primaryColor,
    secondary: secondaryColor,
    surface: cardBackgroundColor,
    error: errorColor,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: darkTextColor,
    onError: Colors.white,
    surfaceTint: Colors.transparent,
  ),

  textTheme: kTextTheme,

  scaffoldBackgroundColor: scaffoldBackgroundColor,

  appBarTheme: AppBarTheme(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    elevation: 0,
    scrolledUnderElevation: 1,
    iconTheme: const IconThemeData(color: Colors.white),
    actionsIconTheme: const IconThemeData(color: Colors.white),
    centerTitle: false,
    titleTextStyle: kTextTheme.titleLarge?.copyWith(color: Colors.white),
  ),

  cardTheme: CardThemeData(
    color: cardBackgroundColor,
    elevation: 1.0,
    shadowColor: shadowColor.withOpacity(0.10),
    margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: lightBorderColor, width: 1.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: lightBorderColor, width: 1.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: primaryColor, width: 2.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: errorColor, width: 1.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(color: errorColor, width: 2.0),
    ),
    labelStyle: kTextTheme.bodySmall?.copyWith(
      color: mediumTextColor,
      fontWeight: FontWeight.w400,
    ),
    hintStyle: kTextTheme.bodyMedium?.copyWith(
      color: mediumTextColor.withOpacity(0.7),
      fontWeight: FontWeight.w400,
    ),
    floatingLabelStyle: kTextTheme.bodySmall?.copyWith(
      color: primaryColor,
      fontWeight: FontWeight.w500,
    ),
    isDense: true,
    floatingLabelBehavior: FloatingLabelBehavior.auto,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      textStyle: kTextTheme.labelLarge?.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      minimumSize: const Size.fromHeight(52),
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: primaryColor,
      side: const BorderSide(color: primaryColor, width: 1.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kDefaultBorderRadius),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      textStyle: kTextTheme.labelLarge?.copyWith(color: primaryColor),
      minimumSize: const Size(64, 44),
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      textStyle: kTextTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
      minimumSize: const Size(64, 40),
    ),
  ),

  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return primaryColor;
      }
      return null;
    }),
    checkColor: WidgetStateProperty.all(Colors.white),
    side: BorderSide(color: mediumTextColor, width: 1.5),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),

  dialogTheme: DialogThemeData(
    backgroundColor: cardBackgroundColor,
    elevation: 4.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(kDialogBorderRadius),
    ),
    titleTextStyle: kTextTheme.titleLarge,
    contentTextStyle: kTextTheme.bodyMedium,
  ),

  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    elevation: 4,
    shape: CircleBorder(),
  ),

  listTileTheme: ListTileThemeData(
    iconColor: mediumTextColor,
    titleTextStyle: kTextTheme.bodyLarge,
    subtitleTextStyle: kTextTheme.bodySmall?.copyWith(color: mediumTextColor),
    dense: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
  ),

  dividerTheme: const DividerThemeData(
    color: lightBorderColor,
    space: 1,
    thickness: 1,
  ),
);

final ButtonStyle kTextButtonErrorStyle = TextButton.styleFrom(
  foregroundColor: errorColor,
  textStyle: kTextTheme.labelLarge?.copyWith(
    color: errorColor,
    fontWeight: FontWeight.w500,
  ),
);

final ButtonStyle kElevatedButtonSuccessStyle = ElevatedButton.styleFrom(
  backgroundColor: successColor,
  foregroundColor: Colors.white,
  textStyle: kTextTheme.labelLarge?.copyWith(color: Colors.white),
);

final InputDecoration kUnderlinedInputDecoration = InputDecoration(
  border: const UnderlineInputBorder(
    borderSide: BorderSide(color: lightBorderColor),
  ),
  enabledBorder: const UnderlineInputBorder(
    borderSide: BorderSide(color: lightBorderColor),
  ),
  focusedBorder: const UnderlineInputBorder(
    borderSide: BorderSide(color: primaryColor, width: 2),
  ),
  errorBorder: const UnderlineInputBorder(
    borderSide: BorderSide(color: errorColor),
  ),
  focusedErrorBorder: const UnderlineInputBorder(
    borderSide: BorderSide(color: errorColor, width: 2),
  ),
  filled: false,
  fillColor: Colors.transparent,
  contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
);
final InputDecoration koutlineInputDecoration = InputDecoration(
  border: const OutlineInputBorder(
    borderSide: BorderSide(color: lightBorderColor),
  ),
  enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: lightBorderColor),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: primaryColor, width: 2),
  ),
  errorBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: errorColor),
  ),
  focusedErrorBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: errorColor, width: 2),
  ),
  filled: false,
  fillColor: Colors.transparent,
  contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
);

final InputDecoration kAddItemDialogInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(kDefaultBorderRadius),
    borderSide: BorderSide.none,
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(kDefaultBorderRadius),
    borderSide: BorderSide.none,
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(kDefaultBorderRadius),

    borderSide: BorderSide.none,
  ),
);
