import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class SystemState extends Equatable {
  const SystemState();

  @override
  List<Object?> get props => [];
}

// SYSTEM INITIAL
class SystemInitial extends SystemState {
  const SystemInitial();

  @override
  List<Object?> get props => [];
}

// THEME STATE
class ChangeThemeSuccess extends SystemState {
  final bool isDarkTheme;

  const ChangeThemeSuccess({required this.isDarkTheme});

  @override
  List<Object?> get props => [isDarkTheme];
}

// THEME STATE
class ChangeLanguageSuccess extends SystemState {
  final Locale locale;

  const ChangeLanguageSuccess({required this.locale});

  @override
  List<Object?> get props => [locale];
}
