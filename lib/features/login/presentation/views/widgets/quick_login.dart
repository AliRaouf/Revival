import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revival/features/login/presentation/cubit/login_cubit.dart';

class QuickLogin extends StatelessWidget {
  const QuickLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        style: ButtonStyle(
          minimumSize: WidgetStatePropertyAll(const Size.square(52)),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              side: BorderSide(color: Theme.of(context).colorScheme.primary),
            ),
          ),
        ),
        onPressed: () {
          final cubit = context.read<LoginCubit>();
          cubit.attemptBiometricLogin();
        },
        icon: const Icon(Icons.fingerprint),
      ),
    );
  }
}
