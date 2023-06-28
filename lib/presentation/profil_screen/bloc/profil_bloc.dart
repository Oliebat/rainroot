import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:rainroot/presentation/profil_screen/models/profil_model.dart';
part 'profil_event.dart';
part 'profil_state.dart';

/// A bloc that manages the state of a Profil according to the event that is dispatched to it.
class ProfilBloc extends Bloc<ProfilEvent, ProfilState> {
  ProfilBloc(ProfilState initialState) : super(initialState) {
    on<ProfilInitialEvent>(_onInitialize);
  }

  _onInitialize(
    ProfilInitialEvent event,
    Emitter<ProfilState> emit,
  ) async {
    emit(state.copyWith(
        firstnameController: TextEditingController(),
        lastnameController: TextEditingController(),
        emailController: TextEditingController(),
        languageController: TextEditingController()));
  }
}
