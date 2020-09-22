import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List<dynamic> properties = const <dynamic>[]]);
}

class UnknownFailure implements Failure {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}

class AuthFailure implements Failure {
  @override
  List<Object> get props => ['auth'];

  @override
  bool get stringify => false;
}

class ApiFailure implements Failure {
  @override
  List<Object> get props => ['api'];

  @override
  bool get stringify => false;
}

class NetworkFailure implements Failure {
  @override
  List<Object> get props => ['network'];

  @override
  bool get stringify => false;
}
