import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:rainroot/presentation/mon_arroseur_screen/models/mon_arroseur_model.dart';
part 'mon_arroseur_event.dart';
part 'mon_arroseur_state.dart';

/// A bloc that manages the state of a MonArroseur according to the event that is dispatched to it.
class MonArroseurBloc extends Bloc<MonArroseurEvent, MonArroseurState> {
  MonArroseurBloc(MonArroseurState initialState) : super(initialState) {
    on<MonArroseurInitialEvent>(_onInitialize);
    on<ChangeSwitchEvent>(_changeSwitch);
  }

  _changeSwitch(
    ChangeSwitchEvent event,
    Emitter<MonArroseurState> emit,
  ) {
    emit(state.copyWith(isSelectedSwitch: event.value));
  }

  _onInitialize(
    MonArroseurInitialEvent event,
    Emitter<MonArroseurState> emit,
  ) async {
    emit(state.copyWith(isSelectedSwitch: false));
  }
}
