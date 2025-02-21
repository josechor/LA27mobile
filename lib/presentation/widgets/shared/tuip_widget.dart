import 'package:flutter/material.dart';
import 'package:la27mobile/config/constants.dart';
import 'package:la27mobile/domain/entities/tuip.dart';

class TuipWidget extends StatelessWidget {
  final Tuip tuip;
  const TuipWidget({super.key, required this.tuip});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        _tuipHeader(),
        SizedBox(
          height: 10,
        ),
        _tuipContent(),
        SizedBox(
          height: 10,
        ),
        _tuipFooter(textTheme),
      ],
    );
  }

  Row _tuipFooter(TextTheme textTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buttonAndLabel(
            Icon(Icons.chat_bubble_outline,
                size: textTheme.bodySmall?.fontSize ?? 12),
            tuip.responsesCount.toString()),
        _buttonAndLabel(
            Icon(
              tuip.youLiked == 1
                  ? Icons.favorite
                  : Icons.favorite_border_outlined,
              color: tuip.youLiked == 1 ? Colors.red : null,
              size: textTheme.bodySmall?.fontSize ?? 12,
            ),
            tuip.likesCount.toString()),
        _buttonAndLabel(
            Icon(
              Icons.share,
              size: textTheme.bodySmall?.fontSize ?? 12,
            ),
            '')
      ],
    );
  }

  Row _buttonAndLabel(Icon icon, String? label) {
    return Row(
      children: [
        icon,
        SizedBox(
          width: 5,
        ),
        Text(label ?? ''),
      ],
    );
  }

  Container _tuipContent() {
    return Container(
      padding: const EdgeInsets.fromLTRB(45, 0, 10, 0),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tuip.tuipContent,
            textAlign: TextAlign.start,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          tuip.tuipMultimedia.isNotEmpty &&
                  tuip.tuipMultimedia[0].endsWith('.webp')
              ? Image.network(
                  '$domain/multimedia/${tuip.tuipMultimedia[0]}',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                )
              : Container(),
        ],
      ),
    );
  }

  Row _tuipHeader() {
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
