// ignore_for_file: must_be_immutable

part of 'arroseurs_bloc.dart';

/// Represents the state of Arroseurs in the application.
class ArroseursState extends Equatable {
  ArroseursState({this.arroseursModelObj});

  ArroseursModel? arroseursModelObj;

  @override
  List<Object?> get props => [
        arroseursModelObj,
      ];
  ArroseursState copyWith({ArroseursModel? arroseursModelObj}) {
    return ArroseursState(
      arroseursModelObj: arroseursModelObj ?? this.arroseursModelObj,
    );
  }
}
