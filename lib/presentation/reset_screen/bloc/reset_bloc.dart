import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:rainroot/presentation/reset_screen/models/reset_model.dart';
part 'reset_event.dart';
part 'reset_state.dart';

/// A bloc that manages the state of a Reset according to the event that is dispatched to it.
class ResetBloc extends Bloc<ResetEvent, ResetState> {
  ResetBloc(ResetState initialState) : super(initialState) {
    on<ResetInitialEvent>(_onInitialize);
  }

  _onInitialize(
    ResetInitialEvent event,
    Emitter<ResetState> emit,
  ) async {
    emit(state.copyWith(emailController: TextEditingController()));
  }
}
