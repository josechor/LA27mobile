import 'package:flutter/material.dart';
import 'package:la27mobile/domain/entities/tuip.dart';
import 'package:la27mobile/infrastructure/datasources/tuips_datasource_imp.dart';
import 'package:la27mobile/infrastructure/repositories/tuips_repository_imp.dart';
import 'package:la27mobile/presentation/widgets/shared/tuip_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TuipsRepositoryImp tuipsRepository =
      TuipsRepositoryImp(datasource: TuipsDatasourceImp());
  List<Tuip> tuips = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _getTuips(
        page: 1, limit: 10); // Llamamos a la función al inicializar el widget
  }

  void _getTuips({required int page, required int limit}) async {
    final List<Tuip> fetchedTuips =
        await tuipsRepository.getTuips(page: page, limit: limit);
    setState(() {
      tuips = fetchedTuips;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return TuipWidget(
      tuip: tuips[0],
    );
  }
}
