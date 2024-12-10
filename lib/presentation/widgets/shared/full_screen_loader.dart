import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  final loadingMoviesMessages = const [
    'Estamos cargando las películas...',
    '¡Ya casi terminamos!',
    '¡Gracias por esperar!',
    'Está tomando más tiempo de lo esperado...',
    '¡Estamos casi listos!',
    '¡Gracias por tu paciencia!',
  ];

  Stream<String> getLoadingMessages() {
    return Stream.periodic(const Duration(seconds: 3), (index) {
      return loadingMoviesMessages[index % loadingMoviesMessages.length];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Espere un momento por favor...'),
        const SizedBox(height: 16),
        const CircularProgressIndicator(
          strokeWidth: 2,
        ),
        const SizedBox(height: 16),
        StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Cargando...');
              return Text(snapshot.data!);
            })
      ],
    ));
  }
}
