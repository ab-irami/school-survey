import 'package:school_survey/utils/exports.dart';

extension ContextExtension on BuildContext {
  /// Sizes
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;

  /// Colors
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get backgroundColor => Theme.of(this).colorScheme.surface;
  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;

  /// TextStyles
  TextStyle? get displayMedium => Theme.of(this).textTheme.displayMedium;
  TextStyle? get displayLarge => Theme.of(this).textTheme.displayLarge;
  TextStyle? get displaySmall => Theme.of(this).textTheme.displaySmall;
  TextStyle? get bodySmall => Theme.of(this).textTheme.bodySmall;
  TextStyle? get bodyMedium => Theme.of(this).textTheme.bodyMedium;
  TextStyle? get bodyLarge => Theme.of(this).textTheme.bodyLarge;
  TextStyle? get titleSmall => Theme.of(this).textTheme.titleSmall;
  TextStyle? get titleMedium => Theme.of(this).textTheme.titleMedium;
  TextStyle? get titleLarge => Theme.of(this).textTheme.titleLarge;
  TextStyle? get titleTextStyle => Theme.of(this).appBarTheme.titleTextStyle;

  bool get keyBoardVisibility => MediaQuery.of(this).viewInsets.bottom != 0;

  String? get currentRoute => ModalRoute.of(this)?.settings.name;

  void hideKeyboard() {
    FocusScope.of(this).requestFocus(FocusNode());
  }

  void closeSnack() {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
  }

  showSnack(
    String message, {
    Color? color,
    double? fontSize,
    bool? isError,
    String? actionLabel,
    void Function()? action,
    bool? actionEnabled,
    bool? isPinned,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: titleMedium?.copyWith(
            color: AppColors.kWhite,
            fontSize: fontSize ?? 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        action:
            actionEnabled ?? false
                ? SnackBarAction(
                  label: actionLabel ?? 'Retry',
                  onPressed: action ?? () {},
                  backgroundColor: AppColors.kWhite,
                  textColor: AppColors.kGreen,
                )
                : null,
        duration:
            isPinned ?? false
                ? const Duration(days: 1)
                : const Duration(seconds: 3),
        backgroundColor:
            (isError ?? false) ? Colors.redAccent : color ?? AppColors.kGreen,
      ),
    );
  }
}

extension BooleanExtension on bool {
  bool get isTrue => this == true;
  bool get isFalse => this == false;
}

extension BooleanExtensionOnNullable on bool? {
  bool get isTrue => this == true;
  bool get isFalse => this == false;
}
