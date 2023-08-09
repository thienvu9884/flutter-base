import 'package:flutter/cupertino.dart';
import 'package:flutter_base/app_localization.dart';
import 'package:flutter_base/blocs/system/system_event.dart';
import 'package:flutter_base/blocs/system/system_state.dart';
import 'package:flutter_base/shared_pref_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SystemBloc extends Bloc<SystemEvent, SystemState> {
  SystemBloc() : super(const SystemInitial()) {
    // THEME EVENT
    on<RequestChangeThemeEvent>(
        (event, emit) => _handleChangeTheme(event, emit));
    // LANGUAGE EVENT
    on<RequestChangeLanguage>((event, emit) => _handleChangeLanguage(event, emit));
  }

  // Handle change theme
  _handleChangeTheme(RequestChangeThemeEvent event, Emitter emit) async {
    final pref = await SharedPreferencesService.instance;
    bool isDarkMode = false;
    if (event.isStartLoad) {
      isDarkMode = pref.isDarkMode;
    } else {
      isDarkMode = event.isDarkTheme;
      pref.setTheme(event.isDarkTheme);
    }
    emit(ChangeThemeSuccess(isDarkTheme: isDarkMode));
  }

  // Handle change language
  _handleChangeLanguage(RequestChangeLanguage event, Emitter emit) async {
    final pref = await SharedPreferencesService.instance;
    Locale locale;
    if (event.isStartLoad) {
      if (pref.languageCode.isEmpty) {
        locale = const Locale('en', 'US');
        await pref.setLanguage(locale.languageCode);
      } else {
        locale = Locale(pref.languageCode);
      }
    } else {
      locale = Locale(event.languageCd == Language.en ? 'en' : 'vi');
      pref.setLanguage(locale.languageCode);
    }

    // emit locale to app
    emit(ChangeLanguageSuccess(locale: locale));
  }
}
