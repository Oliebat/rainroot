// ignore_for_file: must_be_immutable

part of 'mon_arroseur_bloc.dart';

/// Represents the state of MonArroseur in the application.
class MonArroseurState extends Equatable {
  MonArroseurState({
    this.isSelectedSwitch = false,
    this.monArroseurModelObj,
  });

  MonArroseurModel? monArroseurModelObj;

  bool isSelectedSwitch;

  @override
  List<Object?> get props => [
        isSelectedSwitch,
        monArroseurModelObj,
      ];
  MonArroseurState copyWith({
    bool? isSelectedSwitch,
    MonArroseurModel? monArroseurModelObj,
  }) {
    return MonArroseurState(
      isSelectedSwitch: isSelectedSwitch ?? this.isSelectedSwitch,
      monArroseurModelObj: monArroseurModelObj ?? this.monArroseurModelObj,
    );
  }
}
