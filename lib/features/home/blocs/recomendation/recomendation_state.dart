part of 'recomendation_cubit.dart';

sealed class RecomendationState extends Equatable {
  const RecomendationState();

  @override
  List<Object> get props => [];
}

final class RecomendationInitial extends RecomendationState {}

final class RecomendationLoading extends RecomendationState {}

final class RecomendationLoaded extends RecomendationState {
  final List<ResultModel> results;

  const RecomendationLoaded(this.results);

  @override
  List<Object> get props => [results];
}

final class RecomendationError extends RecomendationState {
  final String error;

  const RecomendationError(this.error);

  @override
  List<Object> get props => [error];
}
