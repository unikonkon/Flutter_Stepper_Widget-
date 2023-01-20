import 'package:application_test/model_data.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'stepform_event.dart';
part 'stepform_state.dart';

class StepFormBloc extends Bloc<StepFormEvent, StepFormState> {
  StepFormBloc() : super(const StepFormState()) {
    on<OnAddData>(_onAddData);
  }

  void _onAddData(
    OnAddData event,
    Emitter<StepFormState> emit,
  ) async {
    final state = this.state;
    emit(
      StepFormState(
        all: List.from(state.all)..add(event.data),
      ),
    );
  }
}
