// ignore_for_file: must_be_immutable

part of 'starter_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///Starter widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class StarterEvent extends Equatable {}

/// Event that is dispatched when the Starter widget is first created.
class StarterInitialEvent extends StarterEvent {
  @override
  List<Object?> get props => [];
}
