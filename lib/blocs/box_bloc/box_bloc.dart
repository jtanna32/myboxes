import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:myboxes/model/box.dart';

part 'box_event.dart';
part 'box_state.dart';

/// box bloc to handle states
class BoxBloc extends Bloc<BoxEvent, BoxState> {
  List<Box> boxes = [];
  Random random = Random();

  BoxBloc() : super(BoxInitial()) {
    on<InitialBlocEvent>((event, emit) {
      boxes.clear();
      emit(
          BoxInitial()
      );
    });
    /// initialize list of box
    on<InitializeListEvent>((event, emit) {
      boxes.clear();
      boxes.addAll(List.generate(
          event.number!,
              (index) =>
              Box(number: index, isRandomlySelected: false, isSelected: false)));
      int n = random.nextInt(event.number!);
      boxes.forEach((element) {
        if (boxes[n].isRandomlySelected == false) {
          boxes[n].isRandomlySelected = true;
        }
      });
      emit(BoxInitializeSuccess(boxes: this.boxes));
    });
    /// select bloc on tap
    on<SelectBoxEvent>((event, emit) {
      boxes[event.index!].isSelected = true;
      int x = random.nextInt(2);
      int n = random.nextInt(event.length!);
      for (int i = 0; i < event.length!; i++) {
        if (boxes[n].isSelected == true) {
          n = random.nextInt(event.length!);
        }
        if (boxes[n].isRandomlySelected == false) {
          boxes[n].isRandomlySelected = true;
          break;
        } else {
          n = random.nextInt(event.length!);
        }
      }
      emit(BoxSelectSuccess(boxes: this.boxes));
    });
  }
}
