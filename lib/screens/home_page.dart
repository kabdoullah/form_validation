import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validation_bloc/screens/welcome_page.dart';

import '../blocs/login/login_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        if (state is LoginFormState) {
          return SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50),
              child: SingleChildScrollView(
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        autovalidateMode: AutovalidateMode.always,
                        validator: (value) {
                          return state.nameError;
                        },
                        onChanged: (value) => context
                            .read<LoginBloc>()
                            .add(NameChangedEvent(value)),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Nom",
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.always,
                        onChanged: (value) => context
                            .read<LoginBloc>()
                            .add(FirstNameChangedEvent(value)),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Prénom",
                        ),
                        validator: (value) {
                          return state.firstNameError;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.always,
                        onChanged: (value) => context
                            .read<LoginBloc>()
                            .add(EmailChangedEvent(value)),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Email",
                        ),
                        validator: (value) {
                          return state.emailError;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.always,
                        obscureText: state.isVisible,
                        onChanged: (value) => context
                            .read<LoginBloc>()
                            .add(PasswordChangedEvent(value)),
                        decoration:  InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: "Password",
                          suffixIcon: IconButton(onPressed: () {
                            state.isVisible ? context.read<LoginBloc>().add(HidePasswordEvent()):context.read<LoginBloc>().add(ShowPasswordEvent());
                          }, icon: state.isVisible ? const Icon(Icons.visibility_off_outlined): const Icon(Icons.visibility_outlined),)
                        ),
                        validator: (value) {
                          return state.passwordError;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.always,
                        obscureText: state.isVisibleConfirmP,
                        onChanged: (value) => context
                            .read<LoginBloc>()
                            .add(ConfirmPasswordChangedEvent(confirmPassword: value)),
                        decoration:   InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: "Confirmer mot de passe",
                            suffixIcon: IconButton(onPressed: () {
                              state.isVisibleConfirmP ? context.read<LoginBloc>().add(HideConfirmPasswordEvent()):context.read<LoginBloc>().add(ShowConfirmPasswordEvent());
                            }, icon: state.isVisibleConfirmP ? const Icon(Icons.visibility_off_outlined): const Icon(Icons.visibility_outlined),)
                        ),
                        validator: (value) {
                          return state.confirmPasswordError;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: state.canSubmit! ? () {
                            context.read<LoginBloc>().add(FormSubmittedEvent());
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const WelcomePage(),));
                          }: null, child: const Text("Login"))
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
