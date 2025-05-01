// lib/view/widgets/menu_button.dart
import 'package:finance_app/constants/styles/styles.dart';
import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const MenuButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: ElevatedButton(
        style: AppStyles.menuButton,
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
              height: 48,
              width: double.infinity,
              child:
                  Center(child: Text(label, style: AppStyles.menuButtonText))),
        ),
      ),
    );
  }
}
