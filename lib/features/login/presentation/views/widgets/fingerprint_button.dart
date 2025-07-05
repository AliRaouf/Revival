import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/features/login/presentation/cubit/login_cubit.dart';

class FingerPrintButton extends StatelessWidget {
  const FingerPrintButton({super.key, required this.isLoading});

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        icon: const Icon(Icons.fingerprint, size: 32, color: primaryColor),
        onPressed:
            isLoading
                ? null
                : () => context.read<LoginCubit>().attemptBiometricLogin(),
        style: IconButton.styleFrom(
          backgroundColor: Colors.white,
          shape: const CircleBorder(),
          side: BorderSide(color: primaryColor.withOpacity(0.15)),
          minimumSize: const Size(56, 56),
        ),
      ),
    );
  }
}
