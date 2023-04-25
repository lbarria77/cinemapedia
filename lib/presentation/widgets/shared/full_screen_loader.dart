import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    Stream<String> loadinDots() {
      final dots = <String>[
        'Loading .',
        'Loading . .',
        'Loading . . .',
        'Loading . . . .',
        'Loading . . . . .',
      ];

      return Stream.periodic(const Duration(milliseconds: 1200), (step) {
        return dots[step];
      }).take(dots.length);
    }

    return Center(
      child: Container(
        width: double.infinity,
        color: colors.primary.withOpacity(0.2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: colors.primary,
              strokeWidth: 2,
            ),
            const SizedBox(height: 10),
            StreamBuilder(
              stream: loadinDots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Text('Cargando...');
                return Text(snapshot.data!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
