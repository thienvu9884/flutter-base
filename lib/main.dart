import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/app_localization.dart';
import 'package:flutter_base/blocs/main_bloc.dart';
import 'package:flutter_base/blocs/system/system_bloc.dart';
import 'package:flutter_base/blocs/system/system_event.dart';
import 'package:flutter_base/blocs/system/system_state.dart';
import 'package:flutter_base/screens/main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: MainBloc.allBlocs(),
      child: const CoreApp(),
    );
  }
}

class CoreApp extends StatefulWidget {
  const CoreApp({Key? key}) : super(key: key);

  @override
  _CoreAppState createState() => _CoreAppState();
}

class _CoreAppState extends State<CoreApp> {
  // Dark mode
  bool _isDarkMode = false;

  // Language flag
  Locale locale = const Locale('en', 'US');

  @override
  void initState() {
    BlocProvider.of<SystemBloc>(context).add(const RequestChangeLanguage(
        languageCd: Language.en, isStartLoad: true));
    BlocProvider.of<SystemBloc>(context).add(
        const RequestChangeThemeEvent(isDarkTheme: true, isStartLoad: true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SystemBloc, SystemState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
          darkTheme: ThemeData(
              brightness: Brightness.dark, backgroundColor: Colors.black),
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          locale: locale,
          localizationsDelegates: const [
            DefaultCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            AppLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
          home: const MainScreen(),
        );
      },
      listener: (context, state) {
        if (state is ChangeThemeSuccess) {
          _isDarkMode = state.isDarkTheme;
        } else if (state is ChangeLanguageSuccess) {
          locale = state.locale;
        }
      },
    );
  }
}
