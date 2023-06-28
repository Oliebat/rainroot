// ignore_for_file: must_be_immutable

part of 'reset_bloc.dart';

/// Represents the state of Reset in the application.
class ResetState extends Equatable {
  ResetState({
    this.emailController,
    this.resetModelObj,
  });

  TextEditingController? emailController;

  ResetModel? resetModelObj;

  @override
  List<Object?> get props => [
        emailController,
        resetModelObj,
      ];
  ResetState copyWith({
    TextEditingController? emailController,
    ResetModel? resetModelObj,
  }) {
    return ResetState(
      emailController: emailController ?? this.emailController,
      resetModelObj: resetModelObj ?? this.resetModelObj,
    );
  }
}
