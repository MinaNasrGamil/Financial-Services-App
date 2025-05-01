// lib/main.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:finance_app/logic/cubits/complaint/complaint_cubit.dart';
import 'package:finance_app/logic/cubits/product/product_cubit.dart';
import 'package:finance_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'utils/app_theme.dart';
import 'data/repositories/product_repository.dart';
import 'data/repositories/complaint_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => ProductCubit(ProductRepository()),
          ),
          BlocProvider(
            create: (_) => ComplaintCubit(ComplaintRepository()),
          ),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.onGenerate,
      initialRoute: Routes.home,
    );
  }
}
