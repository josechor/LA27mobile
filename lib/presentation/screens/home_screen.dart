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
  final ScrollController _scrollController = ScrollController();
  List<Tuip> tuips = [];
  bool _loading = true;
  int page = 1;
  final int limit = 20;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _getTuips(
        page: 1, limit: 10); // Llamamos a la función al inicializar el widget
  }

  // Función que se llama cuando el usuario hace scroll
  void _scrollListener() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_loading) {
      page++;
      _getTuips(page: page, limit: limit);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _getTuips({required int page, required int limit}) async {
    setState(() {
      _loading = true;
    });
    final List<Tuip> fetchedTuips =
        await tuipsRepository.getTuips(page: page, limit: limit);
    setState(() {
      tuips = [...tuips, ...fetchedTuips];
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    if (_loading && tuips.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              controller: _scrollController,
              itemCount: tuips.length,
              itemBuilder: (context, index) {
                return TuipWidget(tuip: tuips[index]);
              },
              separatorBuilder: (context, index) => Divider(
                color: colors.secondary, // Color de la línea
                thickness: 0.1, // Grosor de la línea
                height: 10, // Espacio total entre elementos
              ),
            ),
          ),
          if (_loading) CircularProgressIndicator(),
        ],
      ),
    );
  }
}
