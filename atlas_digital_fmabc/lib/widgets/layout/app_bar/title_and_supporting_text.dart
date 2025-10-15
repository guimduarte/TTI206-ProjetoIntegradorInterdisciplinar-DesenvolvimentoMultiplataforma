import 'package:flutter/material.dart';

/// Título com texto de suporte para AppBar, segundo o Material Design.
class TitleAndSupportingText extends StatelessWidget {
  const TitleAndSupportingText({
    super.key,
    required this.title,
    required this.supportingText,
    required this.color,
  });

  final String title;
  final String supportingText;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: color),
        ),
        Text(
          supportingText,
          style: Theme.of(
            context,
          ).textTheme.labelMedium!.copyWith(color: color),
        ),
      ],
    );
  }
}
