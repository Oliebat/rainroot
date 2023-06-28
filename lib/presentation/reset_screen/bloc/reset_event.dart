// ignore_for_file: must_be_immutable

part of 'reset_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///Reset widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class ResetEvent extends Equatable {}

/// Event that is dispatched when the Reset widget is first created.
class ResetInitialEvent extends ResetEvent {
  @override
  List<Object?> get props => [];
}
