import 'package:flutter/material.dart';
import 'package:la27mobile/config/constants.dart';
import 'package:la27mobile/domain/entities/tuip.dart';
import 'package:la27mobile/infrastructure/datasources/tuips_datasource_imp.dart';
import 'package:la27mobile/infrastructure/repositories/tuips_repository_imp.dart';
import 'package:la27mobile/presentation/widgets/shared/full_screen_image_page.dart';

class TuipWidget extends StatefulWidget {
  final TuipsRepositoryImp tuipsRepository =
      TuipsRepositoryImp(datasource: TuipsDatasourceImp());
  final Tuip tuip;
  TuipWidget({super.key, required this.tuip});

  @override
  State<TuipWidget> createState() => _TuipWidgetState();
}

class _TuipWidgetState extends State<TuipWidget> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        widget.tuip.parentData != null
            ? _Tuip(
                tuip: widget.tuip.parentData!,
                textTheme: textTheme,
                isParent: true,
              )
            : Container(),
        SizedBox(
          height: 10,
        ),
        _Tuip(tuip: widget.tuip, textTheme: textTheme),
        SizedBox(
          height: 10,
        ),
        widget.tuip.quotingData != null
            ? _TuipQuoted(
                tuipQuoted: widget.tuip.quotingData!,
                widget: widget,
                textTheme: textTheme)
            : Container(),
      ],
    );
  }
}

class _TuipQuoted extends StatelessWidget {
  const _TuipQuoted(
      {required this.widget,
      required this.textTheme,
      required this.tuipQuoted});

  final Tuip tuipQuoted;
  final TuipWidget widget;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
        margin: const EdgeInsets.only(left: 45),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: colors.primary, width: 0.1),
        ),
        child: _Tuip(
          tuip: tuipQuoted,
          textTheme: textTheme,
          isQuoted: true,
        ));
  }
}

class _Tuip extends StatelessWidget {
  const _Tuip({
    required this.tuip,
    required this.textTheme,
    this.isQuoted = false,
    this.isParent = false,
  });

  final Tuip tuip;
  final TextTheme textTheme;
  final bool isQuoted;
  final bool isParent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TuipHeader(tuip: tuip),
        SizedBox(
          height: 10,
        ),
        _TuipContent(tuip: tuip, context: context),
        SizedBox(
          height: 0,
        ),
        isQuoted == false
            ? _TuipFooter(tuip: tuip, textTheme: textTheme)
            : Container(),
      ],
    );
  }
}

class _TuipFooter extends StatefulWidget {
  const _TuipFooter({
    required this.tuip,
    required this.textTheme,
  });

  final Tuip tuip;
  final TextTheme textTheme;

  @override
  State<_TuipFooter> createState() => _TuipFooterState();
}

class _TuipFooterState extends State<_TuipFooter> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _ButtonAndLabel(
            icon: Icon(Icons.chat_bubble_outline,
                size: widget.textTheme.bodyLarge?.fontSize ?? 16),
            label: widget.tuip.responsesCount.toString()),
        GestureDetector(
          onTap: () async {
            await widget.tuip.setLikeOrDislike();
            setState(() {});
          },
          child: _ButtonAndLabel(
              icon: Icon(
                widget.tuip.youLiked == 1
                    ? Icons.favorite
                    : Icons.favorite_border_outlined,
                color: widget.tuip.youLiked == 1 ? Colors.red : null,
                size: widget.textTheme.bodyLarge?.fontSize ?? 16,
              ),
              label: widget.tuip.likesCount.toString()),
        ),
        _ButtonAndLabel(
            icon: Icon(
              Icons.share,
              size: widget.textTheme.bodyLarge?.fontSize ?? 16,
            ),
            label: '')
      ],
    );
  }
}

class _ButtonAndLabel extends StatelessWidget {
  const _ButtonAndLabel({
    required this.icon,
    required this.label,
  });

  final Icon icon;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          icon,
          SizedBox(
            width: 5,
          ),
          Text(label ?? ''),
        ],
      ),
    );
  }
}

class _TuipContent extends StatelessWidget {
  const _TuipContent({
    required this.tuip,
    required this.context,
  });

  final Tuip tuip;
  final dynamic context;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(45, 0, 10, 0),
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          tuip.tuipContent,
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        tuip.tuipMultimedia.isNotEmpty &&
                tuip.tuipMultimedia[0].endsWith('.webp')
            ? GestureDetector(
                onTap: () {
                  // Cuando se toca la imagen, navega a la pantalla completa
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullScreenImagePage(
                        imageUrl:
                            '$domain/multimedia/${tuip.tuipMultimedia[0]}',
                      ),
                    ),
                  );
                },
                child: Image.network(
                  '$domain/multimedia/${tuip.tuipMultimedia[0]}',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              )
            : Container(),
      ]),
    );
  }
}

class _TuipHeader extends StatelessWidget {
  const _TuipHeader({
    required this.tuip,
  });

  final Tuip tuip;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        tuip.profilePicture != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(
                    25), // Ajusta el radio para el redondeo
                child: Image.network(
                  '$domain/multimedia/${tuip.profilePicture}',
                  width: 35,
                  height: 35,
                  fit: BoxFit.cover,
                ),
              )
            : Placeholder(
                fallbackHeight: 35,
                fallbackWidth: 35,
              ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tuip.demonName,
              style: TextStyle(
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              '👤 ${tuip.userName}',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        Text(' 1h'),
      ],
    );
  }
}
