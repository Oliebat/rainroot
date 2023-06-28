// ignore_for_file: must_be_immutable

part of 'connexion_bloc.dart';

/// Represents the state of Connexion in the application.
class ConnexionState extends Equatable {
  ConnexionState({
    this.emailController,
    this.languageController,
    this.connexionModelObj,
  });

  TextEditingController? emailController;

  TextEditingController? languageController;

  ConnexionModel? connexionModelObj;

  @override
  List<Object?> get props => [
        emailController,
        languageController,
        connexionModelObj,
      ];
  ConnexionState copyWith({
    TextEditingController? emailController,
    TextEditingController? languageController,
    ConnexionModel? connexionModelObj,
  }) {
    return ConnexionState(
      emailController: emailController ?? this.emailController,
      languageController: languageController ?? this.languageController,
      connexionModelObj: connexionModelObj ?? this.connexionModelObj,
    );
  }
}
