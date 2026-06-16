import 'package:flutter/material.dart';
import 'package:shinup/core/localization/app_localizations.dart';

class CounterDisplay extends StatelessWidget {
  final int value;

  const CounterDisplay({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        t.formatNumber(value),
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
