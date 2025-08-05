import 'package:flutter/material.dart';
import 'package:verygoodcoffee/l10n/arb/app_localizations.dart';

class RandomCoffeeErrorWidget extends StatelessWidget {
  const RandomCoffeeErrorWidget({
    required this.isInternetError,
    super.key,
    this.onPressed,
  });
  final bool isInternetError;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          isInternetError ? Icons.wifi_off : Icons.error,
        ),
        Text(
          isInternetError
              ? AppLocalizations.of(context).noInternetConnection
              : AppLocalizations.of(context).unknownError,
        ),
        MaterialButton(
          color: Colors.orangeAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onPressed: onPressed,
          child: Text(AppLocalizations.of(context).tapToTryAgain),
        ),
      ],
    );
  }
}
