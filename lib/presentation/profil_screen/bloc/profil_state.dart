// ignore_for_file: must_be_immutable

part of 'profil_bloc.dart';

/// Represents the state of Profil in the application.
class ProfilState extends Equatable {
  ProfilState({
    this.firstnameController,
    this.lastnameController,
    this.emailController,
    this.languageController,
    this.profilModelObj,
  });

  TextEditingController? firstnameController;

  TextEditingController? lastnameController;

  TextEditingController? emailController;

  TextEditingController? languageController;

  ProfilModel? profilModelObj;

  @override
  List<Object?> get props => [
        firstnameController,
        lastnameController,
        emailController,
        languageController,
        profilModelObj,
      ];
  ProfilState copyWith({
    TextEditingController? firstnameController,
    TextEditingController? lastnameController,
    TextEditingController? emailController,
    TextEditingController? languageController,
    ProfilModel? profilModelObj,
  }) {
    return ProfilState(
      firstnameController: firstnameController ?? this.firstnameController,
      lastnameController: lastnameController ?? this.lastnameController,
      emailController: emailController ?? this.emailController,
      languageController: languageController ?? this.languageController,
      profilModelObj: profilModelObj ?? this.profilModelObj,
    );
  }
}
