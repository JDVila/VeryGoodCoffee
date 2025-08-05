import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:verygoodcoffee/l10n/arb/app_localizations.dart';

class FavoriteCoffeeCard extends StatelessWidget {
  const FavoriteCoffeeCard({
    super.key,
    this.imageBytes,
    this.fileName,
  });
  final String? imageBytes;
  final String? fileName;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 250,
          child: imageBytes != null
              ? Image.memory(
                  base64Decode(imageBytes!),
                  fit: BoxFit.cover,
                )
              : Container(
                  height: 250,
                  color: Colors.grey,
                ),
        ),
        ListTile(
          title: Text(
            AppLocalizations.of(context).photoFilename,
          ),
          subtitle: Text('$fileName'),
        ),
      ],
    );
  }
}
