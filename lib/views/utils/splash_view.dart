import 'package:school_survey/utils/exports.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed(AppRouter.SIGNIN);
    });

    return Scaffold(
      backgroundColor: AppColors.kLightGreen,
      body: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          SliverFillRemaining(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Let\'s Survey',
                  style: context.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: context.width * 0.05),
                SizedBox(
                  height: context.width * 0.5,
                  width: context.width * 0.5,
                  child: Image.asset(Assets.images.surveySplashPNG),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
