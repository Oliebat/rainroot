// ignore_for_file: must_be_immutable

part of 'connexion_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///Connexion widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class ConnexionEvent extends Equatable {}

/// Event that is dispatched when the Connexion widget is first created.
class ConnexionInitialEvent extends ConnexionEvent {
  @override
  List<Object?> get props => [];
}
