// ignore_for_file: must_be_immutable

part of 'mon_arroseur_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///MonArroseur widget.
///
/// Events must be immutable and implement the [Equatable] interface.
@immutable
abstract class MonArroseurEvent extends Equatable {}

/// Event that is dispatched when the MonArroseur widget is first created.
class MonArroseurInitialEvent extends MonArroseurEvent {
  @override
  List<Object?> get props => [];
}

///Event for changing switch
class ChangeSwitchEvent extends MonArroseurEvent {
  ChangeSwitchEvent({required this.value});

  bool value;

  @override
  List<Object?> get props => [
        value,
      ];
}
