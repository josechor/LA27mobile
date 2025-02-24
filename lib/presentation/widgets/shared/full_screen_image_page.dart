import 'package:flutter/material.dart';

class FullScreenImagePage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImagePage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fondo negro para la imagen
      appBar: AppBar(
        backgroundColor:
            Colors.transparent, // Transparente para mostrar la imagen
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () =>
              Navigator.pop(context), // Vuelve a la pantalla anterior
        ),
      ),
      body: Center(
        child: InteractiveViewer(
          child: Image.network(
            imageUrl,
            fit: BoxFit
                .contain, // Para que la imagen se ajuste sin distorsionarse
          ),
        ),
      ),
    );
  }
}
