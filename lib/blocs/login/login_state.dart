part of 'login_bloc.dart';

enum ErrorField {
  defaultEnum,
  emailNotValid,
  nameNotValid,
  firstNameNotValid,
  passwordNotMatch,
  passwordShort
}

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoadLoginState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginFormState extends LoginState {
  final String name;
  final String? nameError;
  final String firstName;
  final String? firstNameError;
  final String email;
  final String? emailError;
  final String password;
  final String? passwordError;
  final String confirmPassword;
  final String? confirmPasswordError;
  final bool submitting;
  final bool isVisible;
  final bool isVisibleConfirmP;
  bool? canSubmit;

  LoginFormState({
    this.nameError,
    this.firstNameError,
    this.emailError,
    this.passwordError,
    this.confirmPasswordError,
    this.submitting = false,
    this.isVisible = true,
    this.isVisibleConfirmP = true,
    required this.name,
    required this.firstName,
    required this.email,
    required this.password,
    required this.confirmPassword,
  }) {
    updateCanSubmit();
  }

  void updateCanSubmit() {
    canSubmit = emailError == null &&
        passwordError == null &&
        nameError == null &&
        firstNameError == null &&
        confirmPasswordError == null &&
        email.isNotEmpty &&
        name.isNotEmpty &&
        firstName.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        password.isNotEmpty;
  }

  @override
  List<Object?> get props => [
        name,
        nameError,
        firstName,
        firstNameError,
        email,
        emailError,
        password,
        passwordError,
        confirmPassword,
        confirmPasswordError,
        submitting,
        isVisible,
        isVisibleConfirmP,
        canSubmit
      ];
}
