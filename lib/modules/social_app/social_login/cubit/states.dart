abstract class socialLoginState {}

class socialLoginIntialState extends socialLoginState {}

class socialLoginLoadingState extends socialLoginState {}

class socialLoginSuccesState extends socialLoginState {}

class socialLoginErrorState extends socialLoginState {
  final String error;
  socialLoginErrorState(this.error);
}

class socialLoginChangePasswordState extends socialLoginState {}
