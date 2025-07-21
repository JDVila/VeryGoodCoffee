import 'package:flutter/material.dart';

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
                )
              : Container(
                  height: 250,
                  color: Colors.grey,
                ),
        ),
        ListTile(
          title: imageUrl != null
              ? const Text(
                  'Photo Filename:',
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
