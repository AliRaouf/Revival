import 'package:flutter/material.dart';

class RememberMe extends StatefulWidget {
  bool rememberMe;
  final double textScale;
  RememberMe({
    super.key,
    required this.rememberMe,
    required this.textScale,
  });

  @override
  State<RememberMe> createState() => _RememberMeState();
}

class _RememberMeState extends State<RememberMe> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: widget.rememberMe,
          onChanged: (bool? value) {
            setState(() {
              widget.rememberMe = value!;
            });
          },
          activeColor: const Color(0xFF17405E),
        ),
        Text(
          'Remember Me',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: const Color(0xFF374151),
            fontSize: 12.8 * widget.textScale,
          ),
        ),
      ],
    );
  }
}
