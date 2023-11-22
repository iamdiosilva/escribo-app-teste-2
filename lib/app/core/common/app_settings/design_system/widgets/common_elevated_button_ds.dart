import 'package:flutter/material.dart';

class CommonElevatedButtonDS extends StatelessWidget {
  final Function()? onPressed;
  final double? width;
  final String title;

  const CommonElevatedButtonDS({
    super.key,
    this.onPressed,
    required this.title,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 128,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        ),
        child: Text(title),
      ),
    );
  }
}
