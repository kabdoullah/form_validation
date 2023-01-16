part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoadLoginEvent extends LoginEvent {
  @override
  List<Object> get props => [];
}

class NameChangedEvent extends LoginEvent {
  final String name;


  const NameChangedEvent(this.name);
  @override
  List<Object?> get props => [name];

}

class FirstNameChangedEvent extends LoginEvent {
  final String firstName;


  const FirstNameChangedEvent(this.firstName);
  @override
  List<Object?> get props => [firstName];

}

class EmailChangedEvent extends LoginEvent {
  final String email;


  const EmailChangedEvent(this.email);
  @override
  List<Object?> get props => [email];

}

class PasswordChangedEvent extends LoginEvent {
  final String password;


  const PasswordChangedEvent(this.password);
  @override
  List<Object?> get props => [password];

}

class ConfirmPasswordChangedEvent extends LoginEvent {
  //final String password;
  final String confirmPassword;


  const ConfirmPasswordChangedEvent({required this.confirmPassword});
  @override
  List<Object?> get props => [confirmPassword];

}

class FormSubmittedEvent extends LoginEvent {
  @override
  List<Object> get props => [];
}

class HidePasswordEvent extends LoginEvent {
  @override
  List<Object> get props => [];
}

class ShowPasswordEvent extends LoginEvent {
  @override
  List<Object> get props => [];
}


class HideConfirmPasswordEvent extends LoginEvent {
  @override
  List<Object> get props => [];
}

class ShowConfirmPasswordEvent extends LoginEvent {
  @override
  List<Object> get props => [];
}