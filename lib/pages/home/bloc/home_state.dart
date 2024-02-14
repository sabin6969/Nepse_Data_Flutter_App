part of 'home_bloc.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeLoadedState extends HomeState {
  final CompaniesModel companiesModel;

  HomeLoadedState({
    required this.companiesModel,
  });
}

final class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState({required this.message});
}
