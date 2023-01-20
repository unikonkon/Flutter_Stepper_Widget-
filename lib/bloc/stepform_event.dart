part of 'stepform_bloc.dart';

@immutable
abstract class StepFormEvent extends Equatable {
  const StepFormEvent();
  @override
  List<Object> get props => [];
}

class OnAddData extends StepFormEvent {
  final Data data;
  const OnAddData({required this.data});
  @override
  List<Object> get props => [data];
}
