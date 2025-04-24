import 'package:flutter/material.dart';

// --- Color Palette ---
const Color primaryColor = Color(
  0xFF17405E,
); // Main dark blue from login/buttons
const Color secondaryColor = Color(
  0xFF4A90E2,
); // Example secondary - adjust if needed
const Color scaffoldBackgroundColor = Color(
  0xFFF9FAFB,
); // Common light grey background
const Color cardBackgroundColor = Colors.white; // Background for cards, dialogs
const Color errorColor = Color(0xFFD32F2F); // Standard error red
const Color successColor = Color(0xFF28a745); // Success green from dialog
const Color whatsappColor = Color(0xFF25D366); // WhatsApp green from dialog

// Text Colors
const Color darkTextColor = Color(
  0xFF1F2937,
); // Darkest text (headlines, titles)
const Color mediumTextColor = Color(
  0xFF6B7280,
); // Medium grey text (labels, subtitles)
const Color lightTextColor = Color(
  0xFF374151,
); // Standard body text (on light backgrounds)
const Color lightBorderColor = Color(0xFFD1D5DB); // Input borders, dividers
const Color shadowColor = Color(0x1A000000); // Subtle shadow color

// --- Border Radius ---
const double kDefaultBorderRadius = 8.0; // For buttons, inputs
const double kCardBorderRadius = 12.0; // For cards
const double kDialogBorderRadius = 16.0; // For dialogs

// --- Text Theme ---
// Using common font sizes. Adjust base sizes if needed.
const TextTheme kTextTheme = TextTheme(
  // Display styles (Large titles, rarely used)
  // displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.w400, color: darkTextColor, letterSpacing: -0.25),
  // displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.w400, color: darkTextColor),
  // displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.w400, color: darkTextColor),

  // Headline styles (Sections, prominent titles)
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
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: darkTextColor,
  ), // Used in Login Title
  // Title styles (AppBars, Cards, Dialogs)
  titleLarge: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: darkTextColor,
  ), // AppBar, Dialog Titles
  titleMedium: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: darkTextColor,
  ), // Card Titles, Dashboard Items
  titleSmall: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: darkTextColor,
  ),

  // Body styles (Main content text)
  bodyLarge: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: lightTextColor,
  ), // Input text, larger body
  bodyMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: lightTextColor,
  ), // Default body, input text, dialog messages
  bodySmall: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: mediumTextColor,
  ), // Labels, captions, subtitles
  // Label styles (Buttons, specific labels)
  labelLarge: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
  ), // Button text
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

// --- Main App Theme Data ---
final ThemeData appTheme = ThemeData(
  useMaterial3: true, // Enable Material 3 features
  brightness: Brightness.light,

  // --- Color Scheme ---
  colorScheme: const ColorScheme.light(
    primary: primaryColor,
    secondary: secondaryColor,
    surface: cardBackgroundColor, // Overall background
    error: errorColor,
    onPrimary: Colors.white, // Text/icons on primary color
    onSecondary: Colors.white, // Text/icons on secondary color
    onSurface: darkTextColor, // Text/icons on background color
    onError: Colors.white, // Text/icons on error color
    surfaceTint:
        Colors.transparent, // Keep surface color, no tint overlay in M3
  ),

  // --- Typography ---
  textTheme: kTextTheme,

  // --- Component Themes ---
  scaffoldBackgroundColor: primaryColor,

  appBarTheme: AppBarTheme(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white, // Affects Icons and Title color implicitly
    elevation: 0,
    scrolledUnderElevation:
        1, // Slight elevation when content scrolls under AppBar
    iconTheme: const IconThemeData(color: Colors.white),
    actionsIconTheme: const IconThemeData(color: Colors.white),
    centerTitle: false,
    titleTextStyle: kTextTheme.titleLarge?.copyWith(
      color: Colors.white,
    ), // Explicit style for title
  ),

  cardTheme: CardTheme(
    color: cardBackgroundColor,
    elevation: 2.0,
    shadowColor: shadowColor,
    margin: const EdgeInsets.symmetric(
      vertical: 6.0,
      horizontal: 4.0,
    ), // Default card margin
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(kCardBorderRadius),
    ),
  ),

  // Default Input Style (Outlined)
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 12,
    ), // Adjusted padding
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(kDefaultBorderRadius),
      borderSide: const BorderSide(color: lightBorderColor, width: 1.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(kDefaultBorderRadius),
      borderSide: const BorderSide(color: lightBorderColor, width: 1.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(kDefaultBorderRadius),
      borderSide: const BorderSide(color: primaryColor, width: 2.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(kDefaultBorderRadius),
      borderSide: const BorderSide(color: errorColor, width: 1.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(kDefaultBorderRadius),
      borderSide: const BorderSide(color: errorColor, width: 2.0),
    ),
    labelStyle: kTextTheme.bodySmall?.copyWith(
      color: mediumTextColor,
    ), // Style for label when floating
    hintStyle: kTextTheme.bodyMedium?.copyWith(
      color: mediumTextColor.withOpacity(0.7),
    ),
    floatingLabelStyle: kTextTheme.bodySmall?.copyWith(
      color: primaryColor,
    ), // Style for label when focused/floating
    isDense: true,
    floatingLabelBehavior:
        FloatingLabelBehavior.auto, // Label floats on focus/text entry
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kDefaultBorderRadius),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 12,
      ), // Adjusted padding
      textStyle: kTextTheme.labelLarge?.copyWith(
        color: Colors.white,
      ), // Ensure text color is white
      minimumSize: const Size(64, 44), // M3 minimums
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: primaryColor,
      side: const BorderSide(color: primaryColor, width: 1.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kDefaultBorderRadius),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 12,
      ), // Adjusted padding
      textStyle: kTextTheme.labelLarge?.copyWith(
        color: primaryColor,
      ), // Ensure text color matches foreground
      minimumSize: const Size(64, 44), // M3 minimums
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      textStyle: kTextTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ), // Make text buttons bold by default
      minimumSize: const Size(64, 40), // M3 minimums
    ),
  ),

  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return primaryColor; // Color when checked
      }
      return null; // Default uses outline color
    }),
    checkColor: WidgetStateProperty.all(Colors.white), // Color of the checkmark
    side: BorderSide(
      color: mediumTextColor,
      width: 1.5,
    ), // Border color when unchecked
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ), // Slightly rounded
  ),

  dialogTheme: DialogTheme(
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
    shape: CircleBorder(), // Default FAB shape
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
    space: 1, // Default space (height for horizontal)
    thickness: 1,
  ),

  // Define custom theme extensions if needed for specific component styles
  // extensions: <ThemeExtension<dynamic>>[
  //   // Example: CustomDashboardTheme(...)
  // ],
);

// --- Specific Style Overrides (Can be defined here or used inline with .copyWith) ---

// Style for the red cancel button (TextButton)
final ButtonStyle kTextButtonErrorStyle = TextButton.styleFrom(
  foregroundColor: errorColor,
  textStyle: kTextTheme.labelLarge?.copyWith(
    color: errorColor,
    fontWeight: FontWeight.w500,
  ),
);

// Style for the green WhatsApp button (ElevatedButton)
final ButtonStyle kElevatedButtonSuccessStyle = ElevatedButton.styleFrom(
  backgroundColor:
      successColor, // Or whatsappColor if specifically for WhatsApp
  foregroundColor: Colors.white,
  textStyle: kTextTheme.labelLarge?.copyWith(color: Colors.white),
);

// Input decoration for underlined fields (used in Login/New Order)
final InputDecoration kUnderlinedInputDecoration = InputDecoration(
  // Inherit most properties from theme, override border and padding
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
  filled: false, // Underlined fields are typically not filled
  fillColor: Colors.transparent,
  contentPadding: const EdgeInsets.symmetric(
    vertical: 8.0,
    horizontal: 4.0,
  ), // Specific padding for underline
);
final InputDecoration koutlineInputDecoration = InputDecoration(
  // Inherit most properties from theme, override border and padding
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
  filled: false, // Underlined fields are typically not filled
  fillColor: Colors.transparent,
  contentPadding: const EdgeInsets.symmetric(
    vertical: 8.0,
    horizontal: 4.0,
  ), // Specific padding for underline
);

// Style for Add Item Dialog input fields (Elevated Outline)
final InputDecoration kAddItemDialogInputDecoration = InputDecoration(
  // Inherit from theme, override fill/border/padding
  filled: true,
  fillColor: Colors.white, // Explicit white fill
  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(
      kDefaultBorderRadius,
    ), // Use default radius
    borderSide: BorderSide.none, // No border, relies on elevation
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(kDefaultBorderRadius),
    borderSide: BorderSide.none,
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(kDefaultBorderRadius),
    // Add a subtle border on focus if desired, e.g.,
    // borderSide: BorderSide(color: primaryColor.withOpacity(0.5), width: 1.0),
    borderSide: BorderSide.none, // Or keep none
  ),
  // Ensure elevation is handled by the wrapping Material widget
);
