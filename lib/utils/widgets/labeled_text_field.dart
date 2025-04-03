import 'package:school_survey/utils/exports.dart';

class LabeledTextField extends StatelessWidget {
  final String label;
  final Widget textfield;
  final bool isRequired;

  const LabeledTextField({
    super.key,
    required this.label,
    required this.textfield,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: label,
                  style: DefaultTextStyle.of(context).style.copyWith(
                    color: DefaultTextStyle.of(context).style.color,
                    fontSize: 14,
                  ),
                ),
                TextSpan(
                  text: isRequired ? " *" : "",
                  style: DefaultTextStyle.of(context).style.copyWith(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: isRequired ? 15 : 0,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 5),
        textfield,
      ],
    );
  }
}
