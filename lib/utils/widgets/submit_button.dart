import 'package:school_survey/utils/exports.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isDisabled = false,
    this.width,
    this.height,
    this.isFilledButton = true,
    this.color,
    this.textColor,
  });

  final double? height;
  final bool? isDisabled;
  final bool? isFilledButton;
  final VoidCallback onPressed;
  final String text;
  final double? width;
  final Color? color;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled.isTrue ? null : onPressed,
      child: Container(
        width: width ?? context.width * 0.9,
        height: height ?? context.height * 0.06,
        decoration: BoxDecoration(
          color:
              isFilledButton.isFalse
                  ? Colors.transparent
                  : isDisabled.isTrue
                  ? AppColors.kGrey
                  : color ?? AppColors.kGreen,
          border:
              isFilledButton.isTrue
                  ? null
                  : Border.all(color: AppColors.kGreen),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: context.titleMedium?.copyWith(
              color:
                  isFilledButton.isTrue
                      ? AppColors.kWhite
                      : textColor ?? AppColors.kGreen,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
