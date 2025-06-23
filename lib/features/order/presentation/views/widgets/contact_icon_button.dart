import 'package:flutter/material.dart';

/// A circular icon button for contact actions.
class ContactIconButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const ContactIconButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Overrides the theme for a circular shape but uses theme colors.
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(10),
        minimumSize: const Size(40, 40),
        // Uses the primary color from the theme's colorScheme
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      child: Tooltip(message: tooltip, child: Icon(icon, size: 20)),
    );
  }
}
