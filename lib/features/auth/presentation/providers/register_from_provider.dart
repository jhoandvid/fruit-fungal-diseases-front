import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:fruit_fungal_diseases/features/auth/presentation/providers/auth_provider.dart';
import 'package:fruit_fungal_diseases/features/shared/infraestructure/input/name.dart';
import 'package:fruit_fungal_diseases/features/shared/shared.dart';

final registerFormProvider =
    StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>(
        (ref) {
  final registerUserCallback = ref.watch(authProvider.notifier).registerUser;

  return RegisterFormNotifier(registerUserCallback: registerUserCallback);
});

//! 2- Como implementar un notifacer

class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  final Function(String, String, String) registerUserCallback;

  RegisterFormNotifier({required this.registerUserCallback})
      : super(RegisterFormState());

  onNameChange(String value) {
    final newName = Name.dirty(value);
    state = state.copyWith(
        name: newName,
        isValid: Formz.validate([newName, state.password, state.email]));
  }

  onEmailChange(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
        email: newEmail,
        isValid: Formz.validate([newEmail, state.password, state.name]));
  }

  onPasswordChanged(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
        password: newPassword,
        isValid: Formz.validate([newPassword, state.email, state.name]));
  }

  onNewPasswordChanged(String value) {
    final valuePassword = ConfirmPassword.dirty(state.password, value);
    state = state.copyWith(
        confirmPassword: valuePassword,
        isValid: Formz.validate(
            [valuePassword, state.email, state.name, state.password]));
  }

  onFormSubmit() async {
    _touchedEveryField();
    if (!state.isValid) return;

    await registerUserCallback(
        state.name.value, state.email.value, state.password.value);
  }

  _touchedEveryField() {
    final name = Name.dirty(state.name.value);
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final newPassword =
        ConfirmPassword.dirty(state.password, state.confirmPassword.value);
    state = state.copyWith(
        isFormPosted: true,
        email: email,
        name: name,
        password: password,
        confirmPassword: newPassword,
        isValid: Formz.validate([email, name, password]));
  }
}

//! 1 - State del provider
class RegisterFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Name name;
  final Email email;
  final Password password;
  final ConfirmPassword confirmPassword;

  RegisterFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.name = const Name.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
  });

  RegisterFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Name? name,
    Email? email,
    Password? password,
    ConfirmPassword? confirmPassword,
  }) =>
      RegisterFormState(
          isPosting: isPosting ?? this.isPosting,
          isFormPosted: isFormPosted ?? this.isFormPosted,
          isValid: isValid ?? this.isValid,
          name: name ?? this.name,
          email: email ?? this.email,
          password: password ?? this.password,
          confirmPassword: confirmPassword ?? this.confirmPassword);

  @override
  String toString() {
    return '''
  LoginFormState:
    isPosting: $isPosting
    isFormPosted: $isFormPosted
    isValid: $isValid
    nombre: $name
    email: $email
    password: $password
''';
  }
}
