import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:rainroot/presentation/creation_compte_screen/models/creation_compte_model.dart';
part 'creation_compte_event.dart';
part 'creation_compte_state.dart';

/// A bloc that manages the state of a CreationCompte according to the event that is dispatched to it.
class CreationCompteBloc
    extends Bloc<CreationCompteEvent, CreationCompteState> {
  CreationCompteBloc(CreationCompteState initialState) : super(initialState) {
    on<CreationCompteInitialEvent>(_onInitialize);
  }

  _onInitialize(
    CreationCompteInitialEvent event,
    Emitter<CreationCompteState> emit,
  ) async {
    emit(state.copyWith(
        firstnameController: TextEditingController(),
        lastnameController: TextEditingController(),
        emailController: TextEditingController(),
        languageController: TextEditingController()));
  }
}
