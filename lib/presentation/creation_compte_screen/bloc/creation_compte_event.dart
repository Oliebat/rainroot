// ignore_for_file: must_be_immutable

part of 'creation_compte_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///CreationCompte widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class CreationCompteEvent extends Equatable {}

/// Event that is dispatched when the CreationCompte widget is first created.
class CreationCompteInitialEvent extends CreationCompteEvent {
  @override
  List<Object?> get props => [];
}
