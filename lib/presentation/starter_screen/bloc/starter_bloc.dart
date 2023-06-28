import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:rainroot/presentation/starter_screen/models/starter_model.dart';
part 'starter_event.dart';
part 'starter_state.dart';

/// A bloc that manages the state of a Starter according to the event that is dispatched to it.
class StarterBloc extends Bloc<StarterEvent, StarterState> {
  StarterBloc(StarterState initialState) : super(initialState) {
    on<StarterInitialEvent>(_onInitialize);
  }

  _onInitialize(
    StarterInitialEvent event,
    Emitter<StarterState> emit,
  ) async {}
}
