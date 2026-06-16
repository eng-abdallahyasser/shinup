import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ── Events ──────────────────────────────────────────────────────────────────

sealed class LocaleEvent extends Equatable {
  const LocaleEvent();

  @override
  List<Object?> get props => [];
}

final class ChangeLocale extends LocaleEvent {
  final Locale locale;
  const ChangeLocale(this.locale);

  @override
  List<Object?> get props => [locale];
}

// ── State ───────────────────────────────────────────────────────────────────

class LocaleState extends Equatable {
  final Locale locale;
  const LocaleState(this.locale);

  @override
  List<Object?> get props => [locale];
}

// ── Cubit ───────────────────────────────────────────────────────────────────

class LocaleCubit extends Cubit<LocaleState> {
  final SharedPreferences _prefs;

  LocaleCubit(this._prefs)
      : super(LocaleState(
          Locale(_prefs.getString('locale') ?? 'ar'),
        ));

  void setLocale(Locale locale) {
    _prefs.setString('locale', locale.languageCode);
    emit(LocaleState(locale));
  }
}
