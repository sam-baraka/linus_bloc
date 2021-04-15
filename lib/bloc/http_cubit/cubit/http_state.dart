part of 'http_cubit.dart';

@immutable
abstract class HttpState extends Equatable {}

class HttpInitial extends HttpState {
  @override
  List<Object?> get props => [];
}

class HttpStateLoading extends HttpState {
  @override
  List<Object?> get props => [];
}

class HttpStateSuccess extends HttpState {
  final String? successValue;

  HttpStateSuccess(this.successValue);
  @override
  List<Object?> get props => [successValue];
}

class HttpStateFailed extends HttpState {
  final String? errrorMessage;

  HttpStateFailed(this.errrorMessage);
  @override
  List<Object?> get props => throw [];
}
