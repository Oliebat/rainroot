// ignore_for_file: must_be_immutable

part of 'arroseurs_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///Arroseurs widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class ArroseursEvent extends Equatable {}

/// Event that is dispatched when the Arroseurs widget is first created.
class ArroseursInitialEvent extends ArroseursEvent {
  @override
  List<Object?> get props => [];
}
