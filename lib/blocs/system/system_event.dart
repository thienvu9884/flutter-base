import 'package:equatable/equatable.dart';
import 'package:flutter_base/app_localization.dart';

abstract class SystemEvent extends Equatable {
  const SystemEvent();

  @override
  List<Object?> get props => [];
}

// THEME EVENT
class RequestChangeThemeEvent extends SystemEvent {
  final bool isDarkTheme;
  final bool isStartLoad;

  const RequestChangeThemeEvent(
      {required this.isDarkTheme, this.isStartLoad = false});

  @override
  List<Object?> get props => [isDarkTheme, isStartLoad];
}

// LANGUAGE EVENT
class RequestChangeLanguage extends SystemEvent {
  final bool isStartLoad;
  final Language languageCd;

  const RequestChangeLanguage(
      {required this.languageCd, this.isStartLoad = false});

  @override
  List<Object?> get props => [languageCd, isStartLoad];
}
