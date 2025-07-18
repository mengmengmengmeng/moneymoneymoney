import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:moneymoneymoney/domain/entities/user.dart';
import 'package:moneymoneymoney/domain/usecases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;

  LoginBloc(this._loginUseCase) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        final user = await _loginUseCase.execute(
          event.username,
          event.password,
        );
        emit(LoginSuccess(user: user));
      } catch (e) {
        emit(LoginFailure(error: e.toString()));
      }
    });
  }
}
