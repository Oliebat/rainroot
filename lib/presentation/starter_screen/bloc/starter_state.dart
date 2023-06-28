// ignore_for_file: must_be_immutable

part of 'starter_bloc.dart';

/// Represents the state of Starter in the application.
class StarterState extends Equatable {
  StarterState({this.starterModelObj});

  StarterModel? starterModelObj;

  @override
  List<Object?> get props => [
        starterModelObj,
      ];
  StarterState copyWith({StarterModel? starterModelObj}) {
    return StarterState(
      starterModelObj: starterModelObj ?? this.starterModelObj,
    );
  }
}
