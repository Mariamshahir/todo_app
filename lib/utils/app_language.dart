import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension AppLocalizationsLanguage on BuildContext{
  AppLocalizations get getLocalizations{
    return AppLocalizations.of(this)!;
  }
}
