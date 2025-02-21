import 'package:flutter/material.dart';
import 'package:la27mobile/config/constants.dart';
import 'package:la27mobile/domain/entities/tuip.dart';

class TuipWidget extends StatelessWidget {
  final Tuip tuip;
  const TuipWidget({super.key, required this.tuip});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          spacing: 10,
          children: [
            tuip.profilePicture != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(
                        25), // Ajusta el radio para el redondeo
                    child: Image.network(
                      '$domain/multimedia/${tuip.profilePicture}',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  )
                : Placeholder(
                    fallbackHeight: 50,
                    fallbackWidth: 50,
                  ),
            Column(
              children: [
                Text(tuip.demonName),
                Text(tuip.userName),
              ],
            ),
            Text(' 1h'),
          ],
        ),
        Text('Today I did 100 pushups and 100 situps'),
        Row(
          children: [
            Text('👍 10'),
            Text('👎 2'),
          ],
        ),
      ],
    );
  }
}
