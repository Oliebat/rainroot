import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:rainroot/presentation/connexion_screen/models/connexion_model.dart';
part 'connexion_event.dart';
part 'connexion_state.dart';

/// A bloc that manages the state of a Connexion according to the event that is dispatched to it.
class ConnexionBloc extends Bloc<ConnexionEvent, ConnexionState> {
  ConnexionBloc(ConnexionState initialState) : super(initialState) {
    on<ConnexionInitialEvent>(_onInitialize);
  }

  _onInitialize(
    ConnexionInitialEvent event,
    Emitter<ConnexionState> emit,
  ) async {
    emit(state.copyWith(
        emailController: TextEditingController(),
        languageController: TextEditingController()));
  }
}
