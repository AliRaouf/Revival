import 'package:flutter/material.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/shared/utils.dart';

class AnimatedErrorMessage extends StatelessWidget {
  const AnimatedErrorMessage({
    super.key,
    required String? errorMessage,
    required this.utilities,
  }) : _errorMessage = errorMessage;

  final String? _errorMessage;
  final Utilities utilities;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity:
          _errorMessage != null ? 1.0 : 0.0,
      duration: const Duration(
        milliseconds: 800,
      ),
      child: Container(
        margin: const EdgeInsets.only(top: 12),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: errorColor.withOpacity(0.08),
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: errorColor,
              size: 20,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                _errorMessage ?? '',
                style: utilities
                    .textTheme
                    .bodySmall
                    ?.copyWith(
                      color: errorColor,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}