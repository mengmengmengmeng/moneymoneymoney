import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:moneymoneymoney/domain/usecases/send_money_usecase.dart';
import 'package:moneymoneymoney/ui/bloc/send_money/send_money_event.dart';
import 'package:moneymoneymoney/ui/bloc/send_money/send_money_state.dart';

@injectable
class SendMoneyBloc extends Bloc<SendMoneyEvent, SendMoneyState> {
  final SendMoneyUseCase _sendMoneyUseCase;

  SendMoneyBloc(this._sendMoneyUseCase) : super(SendMoneyInitial()) {
    on<SendMoneyButtonPressed>((event, emit) async {
      emit(SendMoneyLoading());
      try {
        await _sendMoneyUseCase.execute(event.amount);
        emit(SendMoneySuccess());
      } catch (e) {
        emit(SendMoneyFailure(error: e.toString()));
      }
    });
  }
}
