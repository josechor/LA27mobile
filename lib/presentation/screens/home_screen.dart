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
  bool _loading = false;
  bool _refreshing = false;
  double _refreshProgress = 0.0; // Progreso del scroll para el loader
  int page = 1;
  final int limit = 20;
  final double refreshThreshold = -80; // Umbral para activar el refresco

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _getTuips(page: 1, limit: 10);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_loading) {
      page++;
      _getTuips(page: page, limit: limit);
    }

    // Detectar intento de scroll hacia arriba
    if (_scrollController.position.pixels < 0) {
      double progress = (_scrollController.position.pixels / refreshThreshold)
          .clamp(0.0, 1.0);

      setState(() {
        _refreshProgress = progress;
      });

      if (_scrollController.position.pixels <= refreshThreshold &&
          !_refreshing) {
        _refreshTuips();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _getTuips({required int page, required int limit}) async {
    setState(() {
      _loading = true;
    });
    final List<Tuip> fetchedTuips =
        await tuipsRepository.getTuips(page: page, limit: limit);
    setState(() {
      if (page == 1) {
        tuips = fetchedTuips;
      } else {
        tuips.addAll(fetchedTuips);
      }
      _loading = false;
    });
  }

  Future<void> _refreshTuips() async {
    setState(() {
      _refreshing = true;
      _refreshProgress = 1.0;
    });

    page = 1;
    await _getTuips(page: page, limit: limit);

    setState(() {
      _refreshing = false;
      _refreshProgress = 0.0;
      _scrollController.jumpTo(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            height: _refreshProgress *
                50, // Ajusta el tamaño del loader según el scroll
            child: _refreshProgress > 0
                ? Opacity(
                    opacity: _refreshProgress,
                    child: const CircularProgressIndicator(),
                  )
                : const SizedBox.shrink(),
          ),
          Expanded(
            child: ListView.separated(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
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
          if (_loading) const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
