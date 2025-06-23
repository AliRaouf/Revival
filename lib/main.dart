import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revival/core/routes.dart';
import 'package:revival/core/services/service_locator.dart';
import 'package:revival/core/theme/theme.dart';
import 'package:revival/features/login/presentation/cubit/login_cubit.dart';
import 'package:revival/features/order/domain/use_case/copy_order_invoice.dart';
import 'package:revival/features/order/presentation/cubit/copy_order_invoice/copy_order_invoice_cubit.dart';
import 'dart:ui' as ui;

import 'package:revival/features/order/presentation/cubit/open_order/order_cubit.dart';
import 'package:revival/features/order/presentation/cubit/single_order/single_order_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: [const Locale('en', 'US'), const Locale('ar', 'EG')],
      fallbackLocale: const Locale('en', 'US'),
      path: 'assets/translations',
      child: const RevivalApp(),
    ),
  );
}

class RevivalApp extends StatelessWidget {
  const RevivalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<LoginCubit>()),
        BlocProvider(create: (context) => getIt<OrderCubit>()),
        BlocProvider(create: (context) => getIt<SingleOrderCubit>()),
        BlocProvider(create: (context) => getIt<CopyOrderInvoiceCubit>()),
      ],
      child: MaterialApp.router(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        builder: (context, child) {
          return Directionality(
            textDirection:
                context.locale.languageCode == 'ar'
                    ? ui.TextDirection.rtl
                    : ui.TextDirection.ltr,
            child: child!,
          );
        },
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        title: 'Revival',
      ),
    );
  }
}
