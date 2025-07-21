import 'package:flutter/material.dart';

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
          isInternetError ? 'No Internet Connection' : 'Unknown Error',
        ),
        MaterialButton(
          color: Colors.orangeAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onPressed: onPressed,
          child: const Text('Tap to Try Again'),
        ),
      ],
    );
  }
}
