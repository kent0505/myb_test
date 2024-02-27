import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils.dart';
import '../../auth_repository.dart';
import '../../auth_result.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _repository = AuthRepository();

  String? phone;
  String? otp;
  bool? registered;

  AuthBloc() : super(AuthInitial()) {
    on<LoginInitialEvent>((event, emit) {
      emit(PhoneState());
    });

    on<CheckValidEvent>((event, emit) {
      emit(PhoneState());
    });

    on<LoginEvent>((event, emit) async {
      phone = event.phone
          .replaceAll(' (', '')
          .replaceAll(') ', '')
          .replaceAll('-', '');
      if (phone != null) {
        AuthResult result = await _repository.registerGetCode(phone!);
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
          AuthResult result = await _repository.login(phone!, Utils.fcmToken);
          if (result is SuccessResult) {
            await Utils.saveData('token', result.token);
            emit(HomeState());
            await Future.delayed(const Duration(seconds: 1), () {
              emit(AuthInitial());
            });
          }
        } else {
          emit(ReasonState());
        }
      }
    });

    on<ReasonEvent>((event, emit) async {
      String reason = '';
      if (event.first) {
        reason = 'busy';
      } else {
        reason = 'protection';
      }
      AuthResult result = await _repository.register(
        phone ?? '',
        Utils.fcmToken,
        reason,
      );
      if (result is SuccessResult) {
        await Utils.saveData('token', result.token);
        emit(OnboardingState());
      }
    });
  }
}
