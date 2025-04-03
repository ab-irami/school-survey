import 'package:school_survey/utils/exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await SharedPrefs.instance.init();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School Survey',
      initialRoute: AppRouter.SPLASH,
      onGenerateRoute: AppRouter.instance.generateRoute,
      debugShowCheckedModeBanner: false,
      theme: AppThemes.theme,
    );
  }
}
