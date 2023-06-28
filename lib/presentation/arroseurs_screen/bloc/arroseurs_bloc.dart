import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:rainroot/presentation/arroseurs_screen/models/arroseurs_model.dart';
part 'arroseurs_event.dart';
part 'arroseurs_state.dart';

/// A bloc that manages the state of a Arroseurs according to the event that is dispatched to it.
class ArroseursBloc extends Bloc<ArroseursEvent, ArroseursState> {
  ArroseursBloc(ArroseursState initialState) : super(initialState) {
    on<ArroseursInitialEvent>(_onInitialize);
  }

  _onInitialize(
    ArroseursInitialEvent event,
    Emitter<ArroseursState> emit,
  ) async {}
}
