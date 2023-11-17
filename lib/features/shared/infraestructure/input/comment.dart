import 'package:formz/formz.dart';

enum CommentError { empty }


class Comment extends FormzInput<String, CommentError> {


  const Comment.pure() : super.pure('');


  const Comment.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == CommentError.empty) return 'El campo es requerido';

    return null;
  }
  @override
  CommentError? validator(String value) {
    if (value.trim().isEmpty) return CommentError.empty;

    return null;
  }
}