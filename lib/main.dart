import 'package:cinemapedia_app/config/config.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

final logger = Logger(printer: PrettyPrinter());

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  return runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme().getTheme();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor:
            appTheme.primaryColor, // Color de fondo de la barra
        systemNavigationBarIconBrightness:
            Brightness.light, // Color de los íconos
      ),
    );
    return MaterialApp.router(
      title: 'Cinemapedia',
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      routerConfig: appRouter,
    );
  }
}
