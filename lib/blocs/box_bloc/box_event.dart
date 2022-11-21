part of 'box_bloc.dart';

@immutable
abstract class BoxEvent {}

class InitialBlocEvent extends BoxEvent {

}
/// initialize list of box event
class InitializeListEvent extends BoxEvent {
  final int? number;

  InitializeListEvent({this.number});
}

/// select box event
class SelectBoxEvent extends BoxEvent {
  final int? index;
  final int? length;

  SelectBoxEvent({this.index, this.length});
}
