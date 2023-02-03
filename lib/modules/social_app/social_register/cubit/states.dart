abstract class socialRegisterState {}

class socialRegisterIntialState extends socialRegisterState {}

class socialRegisterLoadingState extends socialRegisterState {}

class socialRegisterSuccesState extends socialRegisterState {}

class socialRegisterErrorState extends socialRegisterState {
  final String error;
  socialRegisterErrorState(this.error);
}

class socialRegisterChangePasswordState extends socialRegisterState {}
