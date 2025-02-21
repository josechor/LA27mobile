import 'package:flutter/material.dart';
import 'package:la27mobile/presentation/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
        body: Center(
            child: FilledButton(
                onPressed: () {
                  authProvider.logout();
                },
                child: Text('Salir'))));
  }
}
