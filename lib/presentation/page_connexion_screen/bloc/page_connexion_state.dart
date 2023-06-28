// ignore_for_file: must_be_immutable

part of 'page_connexion_bloc.dart';

/// Represents the state of PageConnexion in the application.
class PageConnexionState extends Equatable {
  PageConnexionState({this.pageConnexionModelObj});

  PageConnexionModel? pageConnexionModelObj;

  @override
  List<Object?> get props => [
        pageConnexionModelObj,
      ];
  PageConnexionState copyWith({PageConnexionModel? pageConnexionModelObj}) {
    return PageConnexionState(
      pageConnexionModelObj:
          pageConnexionModelObj ?? this.pageConnexionModelObj,
    );
  }
}
