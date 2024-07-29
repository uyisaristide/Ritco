import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ritco_app/main.dart';

class LanguageChangeDialog extends ConsumerStatefulWidget {
  @override
  _LanguageChangeDialogState createState() => _LanguageChangeDialogState();
}

class _LanguageChangeDialogState extends ConsumerState<LanguageChangeDialog> {
  late Locale _selectedLocale;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _selectedLocale = context.locale;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Change Language"),
      content: Column(crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('English'),
            leading: Radio<Locale>(
              value: const Locale('en', 'US'),
              groupValue: _selectedLocale,
              onChanged: (Locale? value) {
                // ref.read(localeProvider.notifier).state =
                //     const Locale('en', 'US');
                setState(() {
                  _selectedLocale = value!;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Kinyarwanda'),
            leading: Radio<Locale>(
              value: const Locale('fr', 'FR'),
              groupValue: _selectedLocale,
              onChanged: (Locale? value) {
                // ref.read(localeProvider.notifier).state =
                //     const Locale('fr', 'FR');

                setState(() {
                  _selectedLocale = value!;
                });
              },
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(tr('Cancel')),
        ),
        TextButton(
          onPressed: () {
            ref.read(localeProvider.notifier).state = _selectedLocale;
            context.setLocale(_selectedLocale);
            context.go('/');
          },
          child: Text(tr('Ok')),
        ),
      ],
    );
  }
}
