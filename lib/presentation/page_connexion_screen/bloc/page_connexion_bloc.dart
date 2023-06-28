import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';
import 'package:rainroot/presentation/page_connexion_screen/models/page_connexion_model.dart';
part 'page_connexion_event.dart';
part 'page_connexion_state.dart';

/// A bloc that manages the state of a PageConnexion according to the event that is dispatched to it.
class PageConnexionBloc extends Bloc<PageConnexionEvent, PageConnexionState> {
  PageConnexionBloc(PageConnexionState initialState) : super(initialState) {
    on<PageConnexionInitialEvent>(_onInitialize);
  }

  _onInitialize(
    PageConnexionInitialEvent event,
    Emitter<PageConnexionState> emit,
  ) async {}
}
