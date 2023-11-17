import 'package:bloc_tdd_clean_arch/core/utils/typedef.dart';

abstract class UseCaseWithParams<Type, Params> {
  ResultFuture<Type> call(Params params);
}

abstract class UseCaseWithOutParams<Type> {
  ResultFuture<Type> call();
}
