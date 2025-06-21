// lib/widgets/text_link.dart
import 'package:flutter/material.dart';

class TextLink extends StatelessWidget {
  final String text;
  final String linkText;
  final Function(BuildContext context) onTap;

  const TextLink({
    super.key,
    required this.text,
    required this.linkText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(context),
      child: RichText(
        text: TextSpan(
          text: '$text ',
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: Colors.grey[700]),
          children: [
            TextSpan(
              text: linkText,
              style: TextStyle(
                color: Theme.of(
                  context,
                ).colorScheme.primary, // Using primary color for the link
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
