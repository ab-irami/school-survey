import 'package:school_survey/utils/exports.dart';

class CustomFormField extends StatefulWidget {
  const CustomFormField({
    super.key,
    this.enabled = true,
    this.obscuringText = false,
    required this.keyboardType,
    required this.hintText,
    this.initialValue,
    this.validator,
    this.onTap,
    this.controller,
    this.onChanged,
    this.readOnly,
  });

  final bool? enabled;
  final bool? obscuringText;
  final TextInputType keyboardType;
  final String hintText;
  final String? initialValue;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final bool? readOnly;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      readOnly: widget.readOnly ?? false,
      onChanged: widget.onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enabled: widget.enabled,
      cursorColor: AppColors.kGrey,
      cursorWidth: 2,
      obscureText: widget.obscuringText == true && !isPasswordVisible,
      obscuringCharacter: "*",
      showCursor: true,
      keyboardType: widget.keyboardType,
      initialValue: widget.initialValue,
      onTap: widget.onTap,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon:
            widget.obscuringText == true
                ? IconButton(
                  padding: EdgeInsets.zero,
                  color: Colors.grey,
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                )
                : null,
      ),
      validator: widget.validator,
      style: context.bodyMedium?.copyWith(
        color: AppColors.kGrey,
        letterSpacing: 2,
      ),
    );
  }
}
