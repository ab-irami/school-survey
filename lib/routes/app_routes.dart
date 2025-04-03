import 'package:school_survey/utils/exports.dart';

class AppRouter {
  AppRouter._();

  static const HOME = 'home';
  static const SIGNIN = 'sign-in';
  static const SPLASH = 'splash';
  static const SIGNUP = 'sign-up';
  static const ADDSURVEY = 'add-survey';
  static const SURVEYCOMMENCEMENT = 'survey-commencement';
  static const FORGOTPASSWORD = 'forgot-password';

  static final AppRouter instance = AppRouter._();

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SPLASH:
        return MaterialPageRoute(
          builder: (context) => const SplashView(),
          settings: settings,
        );
      case SIGNIN:
        return MaterialPageRoute(
          builder: (context) => SignInView(),
          settings: settings,
        );
      case HOME:
        return MaterialPageRoute(
          builder: (context) => const HomeView(),
          settings: settings,
        );
      case SIGNUP:
        return MaterialPageRoute(
          builder: (context) => SignUpView(),
          settings: settings,
        );
      case ADDSURVEY:
        return MaterialPageRoute(
          builder: (context) => AddSurveyView(),
          settings: settings,
        );
      case SURVEYCOMMENCEMENT:
        return MaterialPageRoute(
          builder: (context) => const SurveyCommencementView(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const HomeView(),
          settings: settings,
        );
    }
  }
}
