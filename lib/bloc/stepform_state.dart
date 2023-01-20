part of 'stepform_bloc.dart';

class StepFormState extends Equatable {
  const StepFormState({this.all = const <Data>[]});
  final List<Data> all;

  StepFormState copyWith({
    List<Data>? all,
  }) {
    return StepFormState(all: all ?? this.all);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [all];
}
