import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils.dart';
import '../../auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _repository = AuthRepository();

  String? phone;
  String? otp;
  bool? registered;

  AuthBloc() : super(AuthInitial()) {
    on<CheckEvent>((event, emit) {
      emit(AuthInitial());
    });

    on<LoginEvent>((event, emit) async {
      emit(LoadingState());
      phone = event.phone
          .replaceAll(' (', '')
          .replaceAll(') ', '')
          .replaceAll('-', '');

      if (phone != null) {
        Result result = await _repository.registerGetCode(phone!);

        if (result is CodeResult) {
          otp = result.code.toString();
          registered = result.registered;
          Utils.phoneValid = false;
          emit(OtpState());
        }
      }
    });

    on<CheckOtpEvent>((event, emit) async {
      if (event.otp == otp) {
        if (registered == true) {
          Result result = await _repository.login(phone!, Utils.fcmToken);
          if (result is SuccessResult) {
            await Utils.saveData('token', result.token);
            await Utils.getTokens();
            if (Utils.blockSettings) {
              emit(HomeState());
            } else {
              emit(BlockerSettingsState());
            }
          } else {
            emit(ErrorState());
          }
        } else {
          emit(ReasonState());
        }
      } else {
        emit(OtpErrorState());
      }
    });

    on<ReasonEvent>((event, emit) async {
      String reason = '';
      if (event.first) {
        reason = 'busy';
      } else {
        reason = 'protection';
      }

      Result result = await _repository.register(
        phone ?? '',
        Utils.fcmToken,
        reason,
      );

      if (result is SuccessResult) {
        await Utils.saveData('token', result.token);
        await Utils.getTokens();
        emit(HomeState());
      }
    });
  }
}
