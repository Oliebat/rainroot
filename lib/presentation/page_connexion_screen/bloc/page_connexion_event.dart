// ignore_for_file: must_be_immutable

part of 'page_connexion_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///PageConnexion widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class PageConnexionEvent extends Equatable {}

/// Event that is dispatched when the PageConnexion widget is first created.
class PageConnexionInitialEvent extends PageConnexionEvent {
  @override
  List<Object?> get props => [];
}
