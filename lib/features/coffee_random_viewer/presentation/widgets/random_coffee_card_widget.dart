import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:verygoodcoffee/l10n/arb/app_localizations.dart';

class RandomCoffeeCard extends StatelessWidget {
  const RandomCoffeeCard({
    required this.isPressed,
    super.key,
    this.imageUrl,
    this.fileName,
    this.onPressed,
  });
  final String? imageUrl;
  final String? fileName;
  final bool isPressed;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 250,
          child: imageUrl != null
              ? Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (
                    BuildContext context,
                    Object exception,
                    StackTrace? stackTrace,
                  ) {
                    if (kDebugMode) {
                      return const Placeholder();
                    }
                    return Image.asset('assets/images/placeholder_512px.png');
                  },
                )
              : Container(
                  height: 250,
                  color: Colors.grey,
                ),
        ),
        ListTile(
          title: imageUrl != null
              ? Text(
                  AppLocalizations.of(context).photoFilename,
                )
              : Container(
                  height: 15,
                  color: Colors.grey,
                ),
          subtitle: imageUrl != null
              ? Text('$fileName')
              : Container(
                  height: 15,
                  color: Colors.grey,
                ),
          trailing: imageUrl != null
              ? IconButton(
                  onPressed: onPressed,
                  icon: isPressed
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.redAccent,
                        )
                      : const Icon(Icons.favorite_border_outlined),
                )
              : const CircleAvatar(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.grey,
                  radius: 20,
                ),
        ),
      ],
    );
  }
}
