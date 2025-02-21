import 'package:flutter/material.dart';
import 'package:la27mobile/config/theme/app_theme.dart';
import 'package:la27mobile/presentation/providers/auth_provider.dart';
import 'package:la27mobile/presentation/screens/login_screen.dart';
import 'package:la27mobile/presentation/screens/main_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LA27',
      theme: AppTheme().getTheme(),
      home: SafeArea(
        bottom: false,
        top: false,
        child: const AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    // if (authProvider.isLoading) {
    //   return const Scaffold(body: Center(child: CircularProgressIndicator()));
    // }

    if (authProvider.token == null) {
      return const LoginScreen();
    }

    return const MainScreen();
  }
}
