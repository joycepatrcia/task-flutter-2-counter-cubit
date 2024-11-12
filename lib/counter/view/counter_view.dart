import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_cubit/counter/counter.dart';
import 'package:confetti/confetti.dart';

class CounterView extends StatefulWidget {
  const CounterView({super.key});

  @override
  _CounterViewState createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Counter',
          style: TextStyle(fontWeight: FontWeight.bold), // Use the theme text style
        ),
        backgroundColor: colorScheme.primary, // Primary color from theme
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: BlocBuilder<CounterCubit, int>(
              builder: (context, state) {
                // Show a snackbar for multiples of 5
                if (state % 5 == 0 && state != 0) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('You got $state!'),
                      ),
                    );
                    // Trigger confetti
                    _confettiController.play();
                  });
                }

                return state % 5 == 0 && state != 0
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star, size: 50, color: colorScheme.secondary),
                          Container(
                            padding: const EdgeInsets.all(30.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Text(
                              '$state',
                              style: textTheme.displayMedium?.copyWith(color: colorScheme.onSurface),
                            ),
                          ),
                        ],
                      )
                    : Container(
                        padding: const EdgeInsets.all(50.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Text(
                          '$state',
                          style: textTheme.displayMedium?.copyWith(color: colorScheme.onSurface),
                        ),
                      );
              },
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: [colorScheme.secondary, colorScheme.primary, colorScheme.secondaryContainer, colorScheme.primaryContainer],
              createParticlePath: drawStar,
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            key: const Key('counterView_increment_floatingActionButton'),
            child: const Icon(Icons.add),
            onPressed: () => context.read<CounterCubit>().increment(),
            backgroundColor: colorScheme.secondary, // Floating action button color
            foregroundColor: colorScheme.onSecondary, // Icon color
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            key: const Key('counterView_decrement_floatingActionButton'),
            child: const Icon(Icons.remove),
            onPressed: () => context.read<CounterCubit>().decrement(),
            backgroundColor: colorScheme.secondary,
            foregroundColor: colorScheme.onSecondary,
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            child: const Icon(Icons.close),
            onPressed: () => context.read<CounterCubit>().doubleCounter(),
            backgroundColor: colorScheme.secondary,
            foregroundColor: colorScheme.onSecondary,
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            child: const Icon(Icons.exposure_neg_2),
            onPressed: () => context.read<CounterCubit>().decrementByTwo(),
            backgroundColor: colorScheme.secondary,
            foregroundColor: colorScheme.onSecondary,
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            child: const Icon(Icons.delete),
            onPressed: () => context.read<CounterCubit>().resetCounter(),
            backgroundColor: colorScheme.secondary,
            foregroundColor: colorScheme.onSecondary,
          ),
        ],
      ),
    );
  }

  Path drawStar(Size size) {
    final Path path = Path();
    final double w = size.width;
    final double h = size.height;
    path.moveTo(w * 0.5, 0);
    path.lineTo(w * 0.61, h * 0.35);
    path.lineTo(w, h * 0.38);
    path.lineTo(w * 0.68, h * 0.61);
    path.lineTo(w * 0.79, h);
    path.lineTo(w * 0.5, h * 0.76);
    path.lineTo(w * 0.21, h);
    path.lineTo(w * 0.32, h * 0.61);
    path.lineTo(0, h * 0.38);
    path.lineTo(w * 0.39, h * 0.35);
    path.close();
    return path;
  }
}
