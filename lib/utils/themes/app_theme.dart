import 'package:school_survey/utils/exports.dart';

class AppThemes {
  static ThemeData get theme => ThemeData(
    primaryColor: AppColors.kGreen,
    useMaterial3: true,
    fontFamily: 'Urbanist',
    splashColor: Colors.transparent,
    progressIndicatorTheme: ProgressIndicatorThemeData(color: AppColors.kGreen),
    appBarTheme: appBarTheme,
    inputDecorationTheme: inputDecorationTheme,
    colorScheme: ColorScheme.light(primary: AppColors.kGreen),
  );

  static AppBarTheme get appBarTheme => AppBarTheme(
    elevation: 0,
    centerTitle: false,
    titleSpacing: 0,
    iconTheme: const IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      color: AppColors.kBlack,
      fontWeight: FontWeight.bold,
      fontSize: 18,
      fontFamily: 'Urbanist',
    ),
  );

  static TextSelectionThemeData get textSelectionTheme =>
      TextSelectionThemeData(cursorColor: AppColors.kGreen);

  static InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
    hintStyle: TextStyle(
      fontSize: 12,
      color: AppColors.kLightGrey7,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
    ),
    filled: true,
    fillColor: AppColors.kWhite2,
    labelStyle: TextStyle(
      fontSize: 12,
      color: AppColors.kGrey,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
    ),
    errorStyle: const TextStyle(
      fontSize: 12,
      color: Colors.redAccent,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide.none,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: Colors.redAccent),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide.none,
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide.none,
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: Colors.redAccent),
    ),
  );
}
