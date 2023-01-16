import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoadLoginEvent>((event, emit) {
      emit(LoginFormState(
          name: '',
          firstName: '',
          email: '',
          password: '',
          confirmPassword: ''));
    });

    on<NameChangedEvent>((event, emit) {
      final state = this.state as LoginFormState;
      String? nameError;
      final name = event.name;
      if (name.isEmpty) {
        nameError = 'Nom est requis.';
      }
      emit(LoginFormState(
        name: name,
        nameError: nameError,
        firstNameError: state.firstNameError,
        passwordError: state.passwordError,
        emailError: state.emailError,
        confirmPasswordError: state.confirmPasswordError,
        firstName: state.firstName,
        confirmPassword: state.confirmPassword,
        email: state.email,
        password: state.password,
      ));
    });

    on<FirstNameChangedEvent>((event, emit) {
      final state = this.state as LoginFormState;
      String? firstNameError;
      final firstName = event.firstName;
      if (firstName.isEmpty) {
        firstNameError = 'Prénom est requis.';
      }
      emit(LoginFormState(
        firstNameError: firstNameError,
        name: state.name,
        nameError: state.nameError,
        firstName: firstName,
        confirmPassword: state.confirmPassword,
        confirmPasswordError: state.confirmPasswordError,
        emailError: state.emailError,
        passwordError: state.passwordError,
        email: state.email,
        password: state.password,
      ));
    });

    on<EmailChangedEvent>((event, emit) {
      final state = this.state as LoginFormState;
      String? emailError;
      final email = event.email;
      if (email.isEmpty) {
        emailError = 'Email est requis.';
      } else if (!email.contains('@')) {
        emailError = 'Email est invalide.';
      }
      print("error  : $emailError");
      emit(LoginFormState(
        email: email,
        emailError: emailError,
        name: state.name,
        confirmPassword: state.confirmPassword,
        password: state.password,
        firstName: state.firstName,
        nameError: state.nameError,
        firstNameError: state.firstNameError,
        confirmPasswordError: state.confirmPasswordError,
        passwordError: state.passwordError,
      ));
    });

    on<PasswordChangedEvent>((event, emit) {
      final state = this.state as LoginFormState;
      final password = event.password;
      print("password : $password");
      String? passwordError;
      String? confirmPasswordError;
      if (password.isEmpty) {
        passwordError = 'Mot de passe est requis.';
      } else if (password.length < 4) {
        passwordError = 'Mot de passe doit contenir au moins 8 caractères.';
      }
      if (state.password != password){
        confirmPasswordError = "Mot de passe ne correspond pas !";
      }
      emit(LoginFormState(
          password: password,
          passwordError: passwordError,
          name: state.name,
          firstName: state.firstName,
          confirmPassword: state.confirmPassword,
          email: state.email,
          confirmPasswordError: confirmPasswordError,
          firstNameError: state.firstNameError,
          nameError: state.nameError,
          emailError: state.emailError));
    });

    on<ConfirmPasswordChangedEvent>((event, emit) {
      final state = this.state as LoginFormState;
      final confirmPassword = event.confirmPassword;
      //final password = event.password;
      String? confirmPasswordError;
      print("confirmPassword : $confirmPassword");
      print("password == : ${state.password}");
      if (confirmPassword != state.password) {
        confirmPasswordError = "Mot de passe ne correspond pas !";
      } else if (confirmPassword.isEmpty) {
        confirmPasswordError = 'Mot de passe est requis.';
      }
      emit(LoginFormState(
        confirmPassword: confirmPassword,
        confirmPasswordError: confirmPasswordError,
        name: state.name,
        email: state.email,
        firstName: state.firstName,
        password: state.password,
        emailError: state.emailError,
        nameError: state.nameError,
        firstNameError: state.firstNameError,
        passwordError: state.passwordError,
      ));
    });

    on<FormSubmittedEvent>((event, emit) {
      final state = this.state as LoginFormState;
      if (state.nameError == null &&
          state.firstNameError == null &&
          state.emailError == null &&
          state.passwordError == null &&
          state.confirmPasswordError == null) {
        emit(LoginFormState(
            submitting: true,
            name: state.name,
            password: state.password,
            firstName: state.firstName,
            email: state.email,
            confirmPassword: state.confirmPassword));
      } else {
        emit(LoginFormState(
          confirmPassword: state.confirmPassword,
          confirmPasswordError: state.confirmPasswordError,
          name: state.name,
          email: state.email,
          firstName: state.firstName,
          password: state.password,
          emailError: state.emailError,
          nameError: state.nameError,
          firstNameError: state.firstNameError,
          passwordError: state.passwordError,
        ));
      }
    });

    on<HidePasswordEvent>((event, emit) {
      final state = this.state as LoginFormState;
      emit(LoginFormState(
        confirmPassword: state.confirmPassword,
        confirmPasswordError: state.confirmPasswordError,
        name: state.name,
        email: state.email,
        firstName: state.firstName,
        password: state.password,
        emailError: state.emailError,
        nameError: state.nameError,
        firstNameError: state.firstNameError,
        passwordError: state.passwordError,
        isVisible: false,
        isVisibleConfirmP: false
      ));
    });
    on<ShowPasswordEvent>((event, emit) {
      final state = this.state as LoginFormState;
      emit(LoginFormState(
        confirmPassword: state.confirmPassword,
        confirmPasswordError: state.confirmPasswordError,
        name: state.name,
        email: state.email,
        firstName: state.firstName,
        password: state.password,
        emailError: state.emailError,
        nameError: state.nameError,
        firstNameError: state.firstNameError,
        passwordError: state.passwordError,
        isVisible: true,
        isVisibleConfirmP: true
      ));
    });

    on<HideConfirmPasswordEvent>((event, emit) {
      final state = this.state as LoginFormState;
      emit(LoginFormState(
          confirmPassword: state.confirmPassword,
          confirmPasswordError: state.confirmPasswordError,
          name: state.name,
          email: state.email,
          firstName: state.firstName,
          password: state.password,
          emailError: state.emailError,
          nameError: state.nameError,
          firstNameError: state.firstNameError,
          passwordError: state.passwordError,
          isVisible: state.isVisible,
          isVisibleConfirmP: false
      ));
    });

    on<ShowConfirmPasswordEvent>((event, emit) {
      final state = this.state as LoginFormState;
      emit(LoginFormState(
          confirmPassword: state.confirmPassword,
          confirmPasswordError: state.confirmPasswordError,
          name: state.name,
          email: state.email,
          firstName: state.firstName,
          password: state.password,
          emailError: state.emailError,
          nameError: state.nameError,
          firstNameError: state.firstNameError,
          passwordError: state.passwordError,
          isVisible: state.isVisible,
          isVisibleConfirmP: true
      ));
    });

  }
}
