import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'stepform_event.dart';
part 'stepform_state.dart';

class StepformBloc extends Bloc<StepformEvent, StepformState> {
  StepformBloc() : super(StepformInitial()) {
    on<StepformEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
