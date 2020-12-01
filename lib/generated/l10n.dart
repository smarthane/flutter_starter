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
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `FlutterStarter`
  String get appName {
    return Intl.message(
      'FlutterStarter',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Font`
  String get switchFont {
    return Intl.message(
      'Font',
      name: 'switchFont',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get switchLanguage {
    return Intl.message(
      'Language',
      name: 'switchLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get switchTheme {
    return Intl.message(
      'Theme',
      name: 'switchTheme',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get switchDarkMode {
    return Intl.message(
      'Dark Mode',
      name: 'switchDarkMode',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get appSetting {
    return Intl.message(
      'Setting',
      name: 'appSetting',
      desc: '',
      args: [],
    );
  }

  /// `Version Update`
  String get versionUpdate {
    return Intl.message(
      'Version Update',
      name: 'versionUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Auto`
  String get autoBySystem {
    return Intl.message(
      'Auto',
      name: 'autoBySystem',
      desc: '',
      args: [],
    );
  }

  /// `System`
  String get fontSystem {
    return Intl.message(
      'System',
      name: 'fontSystem',
      desc: '',
      args: [],
    );
  }

  /// `Happy`
  String get fontHappy {
    return Intl.message(
      'Happy',
      name: 'fontHappy',
      desc: '',
      args: [],
    );
  }

  /// `Butter`
  String get fontButter {
    return Intl.message(
      'Butter',
      name: 'fontButter',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get actionConfirm {
    return Intl.message(
      'Confirm',
      name: 'actionConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get actionCancel {
    return Intl.message(
      'Cancel',
      name: 'actionCancel',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get splashSkip {
    return Intl.message(
      'Skip',
      name: 'splashSkip',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Nothing Found`
  String get viewStateMessageEmpty {
    return Intl.message(
      'Nothing Found',
      name: 'viewStateMessageEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Not sign in yet`
  String get viewStateMessageUnAuth {
    return Intl.message(
      'Not sign in yet',
      name: 'viewStateMessageUnAuth',
      desc: '',
      args: [],
    );
  }

  /// `Refresh`
  String get viewStateButtonRefresh {
    return Intl.message(
      'Refresh',
      name: 'viewStateButtonRefresh',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get viewStateButtonRetry {
    return Intl.message(
      'Retry',
      name: 'viewStateButtonRetry',
      desc: '',
      args: [],
    );
  }

  /// `Load Failed`
  String get viewStateButtonError {
    return Intl.message(
      'Load Failed',
      name: 'viewStateButtonError',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get viewStateButtonLogin {
    return Intl.message(
      'Sign In',
      name: 'viewStateButtonLogin',
      desc: '',
      args: [],
    );
  }

  /// `release to enter second floor`
  String get refreshTwoLevel {
    return Intl.message(
      'release to enter second floor',
      name: 'refreshTwoLevel',
      desc: '',
      args: [],
    );
  }

  /// `Press back again to exit the app`
  String get tAndroidClickBackExitAppTip {
    return Intl.message(
      'Press back again to exit the app',
      name: 'tAndroidClickBackExitAppTip',
      desc: '',
      args: [],
    );
  }

  /// `not empty`
  String get fieldNotNull {
    return Intl.message(
      'not empty',
      name: 'fieldNotNull',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get userName {
    return Intl.message(
      'Username',
      name: 'userName',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get toSignUp {
    return Intl.message(
      'Sign Up',
      name: 'toSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get rePassword {
    return Intl.message(
      'Confirm Password',
      name: 'rePassword',
      desc: '',
      args: [],
    );
  }

  /// `The two passwords differ`
  String get twoPwdDifferent {
    return Intl.message(
      'The two passwords differ',
      name: 'twoPwdDifferent',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get toSignIn {
    return Intl.message(
      'Sign In',
      name: 'toSignIn',
      desc: '',
      args: [],
    );
  }

  /// `logout`
  String get logout {
    return Intl.message(
      'logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `No Account ? `
  String get noAccount {
    return Intl.message(
      'No Account ? ',
      name: 'noAccount',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get signIn3thd {
    return Intl.message(
      'More',
      name: 'signIn3thd',
      desc: '',
      args: [],
    );
  }

  /// `Ready to go, please wait!`
  String get waitInHope {
    return Intl.message(
      'Ready to go, please wait!',
      name: 'waitInHope',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get tabHome {
    return Intl.message(
      'Home',
      name: 'tabHome',
      desc: '',
      args: [],
    );
  }

  /// `Project`
  String get tabProject {
    return Intl.message(
      'Project',
      name: 'tabProject',
      desc: '',
      args: [],
    );
  }

  /// `Legend`
  String get tabLegend {
    return Intl.message(
      'Legend',
      name: 'tabLegend',
      desc: '',
      args: [],
    );
  }

  /// `Structure`
  String get tabStructure {
    return Intl.message(
      'Structure',
      name: 'tabStructure',
      desc: '',
      args: [],
    );
  }

  /// `Open Browser`
  String get openBrowser {
    return Intl.message(
      'Open Browser',
      name: 'openBrowser',
      desc: '',
      args: [],
    );
  }

  /// `refresh`
  String get refresh {
    return Intl.message(
      'refresh',
      name: 'refresh',
      desc: '',
      args: [],
    );
  }

  /// `Demos`
  String get demos {
    return Intl.message(
      'Demos',
      name: 'demos',
      desc: '',
      args: [],
    );
  }

  /// `Rate`
  String get rate {
    return Intl.message(
      'Rate',
      name: 'rate',
      desc: '',
      args: [],
    );
  }

  /// `FeedBack`
  String get feedback {
    return Intl.message(
      'FeedBack',
      name: 'feedback',
      desc: '',
      args: [],
    );
  }

  /// `About Me`
  String get aboutme {
    return Intl.message(
      'About Me',
      name: 'aboutme',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}