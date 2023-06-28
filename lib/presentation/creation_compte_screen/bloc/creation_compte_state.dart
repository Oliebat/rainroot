// ignore_for_file: must_be_immutable

part of 'creation_compte_bloc.dart';

/// Represents the state of CreationCompte in the application.
class CreationCompteState extends Equatable {
  CreationCompteState({
    this.firstnameController,
    this.lastnameController,
    this.emailController,
    this.languageController,
    this.creationCompteModelObj,
  });

  TextEditingController? firstnameController;

  TextEditingController? lastnameController;

  TextEditingController? emailController;

  TextEditingController? languageController;

  CreationCompteModel? creationCompteModelObj;

  @override
  List<Object?> get props => [
        firstnameController,
        lastnameController,
        emailController,
        languageController,
        creationCompteModelObj,
      ];
  CreationCompteState copyWith({
    TextEditingController? firstnameController,
    TextEditingController? lastnameController,
    TextEditingController? emailController,
    TextEditingController? languageController,
    CreationCompteModel? creationCompteModelObj,
  }) {
    return CreationCompteState(
      firstnameController: firstnameController ?? this.firstnameController,
      lastnameController: lastnameController ?? this.lastnameController,
      emailController: emailController ?? this.emailController,
      languageController: languageController ?? this.languageController,
      creationCompteModelObj:
          creationCompteModelObj ?? this.creationCompteModelObj,
    );
  }
}
