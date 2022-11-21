part of 'box_bloc.dart';

@immutable
abstract class BoxState {}

class BoxInitial extends BoxState {}

/// list of box initialized success state
class BoxInitializeSuccess extends BoxState {
  final List<Box> boxes;

  BoxInitializeSuccess({required this.boxes});
}

/// select box success state
class BoxSelectSuccess extends BoxState {
  final List<Box> boxes;

  BoxSelectSuccess({required this.boxes});
}
