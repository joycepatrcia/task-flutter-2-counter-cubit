import 'package:bloc/bloc.dart';

/// {@template counter_cubit}
/// A [Cubit] which manages an [int] as its state.
/// {@endtemplate}
class CounterCubit extends Cubit<int> {
  /// {@macro counter_cubit}
  CounterCubit() : super(0);

  /// Add 1 to the current state.
  void increment() => emit(state + 1);

  /// Subtract 1 from the current state.
  void decrement() => emit(state - 1);

  // kalikan 2
  void doubleCounter() => emit(state * 2);

  //kurangi 2
  void decrementByTwo() => emit(state - 2);

  // reset jadi 0
  void resetCounter() => emit(0);
}
