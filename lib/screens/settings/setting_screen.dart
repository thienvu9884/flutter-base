import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/app_localization.dart';
import 'package:flutter_base/blocs/system/system_bloc.dart';
import 'package:flutter_base/blocs/system/system_event.dart';
import 'package:flutter_base/common_styles.dart';
import 'package:flutter_base/shared_pref_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  // Theme flag
  bool _isDarkTheme = false;

  // Language flag
  bool _isDefaultLanguage = false;

  // Get locale from local
  _getSettingsLocal() async {
    final pref = await SharedPreferencesService.instance;
    _isDefaultLanguage = pref.languageCode == 'en';
    _isDarkTheme = pref.isDarkMode;
    setState(() {});
  }

  @override
  void initState() {
    _getSettingsLocal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('settings')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // THEME SWITCHER
            _buildThemeSwitcher(context),
            // LANGUAGES CHANGER
            _buildLanguageChanger(context)
          ],
        ),
      ),
    );
  }

  // Language changer
  _buildLanguageChanger(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: const Color(0xffE2E2E2), width: 1)),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Row(
          children: [
            Expanded(
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isDefaultLanguage = true;
                        BlocProvider.of<SystemBloc>(context).add(
                            const RequestChangeLanguage(
                                languageCd: Language.en));
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      color:
                          _isDefaultLanguage ? Colors.blue : Colors.transparent,
                      child: Column(
                        children: const [Text('EN')],
                      ),
                    ))),
            Expanded(
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isDefaultLanguage = false;
                      });
                      BlocProvider.of<SystemBloc>(context).add(
                          const RequestChangeLanguage(languageCd: Language.vi));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      color: !_isDefaultLanguage
                          ? Colors.blue
                          : Colors.transparent,
                      child: Column(
                        children: const [Text('VN')],
                      ),
                    ))),
          ],
        ),
      ),
    );
  }

  // Theme switcher UI
  _buildThemeSwitcher(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: const Color(0xffE2E2E2), width: 1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // THEME LABEL
          Text(
            'Dark Mode',
            style: CommonStyles.normalTextBlack(context),
          ),
          // THEME SWITCH
          CupertinoSwitch(
              value: _isDarkTheme,
              onChanged: (value) => setState(() {
                    _isDarkTheme = value;
                    BlocProvider.of<SystemBloc>(context).add(
                        RequestChangeThemeEvent(isDarkTheme: _isDarkTheme));
                  })),
        ],
      ),
    );
  }
}
