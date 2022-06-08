// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Send SMS`
  String get sendSMS {
    return Intl.message(
      'Send SMS',
      name: 'sendSMS',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Create customer`
  String get createCustomer {
    return Intl.message(
      'Create customer',
      name: 'createCustomer',
      desc: '',
      args: [],
    );
  }

  /// `Edit customer`
  String get editCustomer {
    return Intl.message(
      'Edit customer',
      name: 'editCustomer',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Car plates`
  String get carPlates {
    return Intl.message(
      'Car plates',
      name: 'carPlates',
      desc: '',
      args: [],
    );
  }

  /// `Last ITP`
  String get lastITP {
    return Intl.message(
      'Last ITP',
      name: 'lastITP',
      desc: '',
      args: [],
    );
  }

  /// `Next ITP`
  String get nextITP {
    return Intl.message(
      'Next ITP',
      name: 'nextITP',
      desc: '',
      args: [],
    );
  }

  /// `6 months`
  String get sixMonths {
    return Intl.message(
      '6 months',
      name: 'sixMonths',
      desc: '',
      args: [],
    );
  }

  /// `1 year`
  String get oneYear {
    return Intl.message(
      '1 year',
      name: 'oneYear',
      desc: '',
      args: [],
    );
  }

  /// `2 years`
  String get twoYears {
    return Intl.message(
      '2 years',
      name: 'twoYears',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Wrong format`
  String get wrongFormat {
    return Intl.message(
      'Wrong format',
      name: 'wrongFormat',
      desc: '',
      args: [],
    );
  }

  /// `Sent SMS {SMS}`
  String snackBarMsg(Object SMS) {
    return Intl.message(
      'Sent SMS $SMS',
      name: 'snackBarMsg',
      desc: '',
      args: [SMS],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ro'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
