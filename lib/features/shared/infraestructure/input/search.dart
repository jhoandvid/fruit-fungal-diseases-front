import 'package:formz/formz.dart';

// Define input validation errors
enum SearchError { empty }

// Extend FormzInput and provide the input type and error type.
class Search extends FormzInput<String, SearchError> {

  // Call super.pure to represent an unmodified form input.
  const Search.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Search.dirty( String value ) : super.dirty(value);



  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == SearchError.empty ) return 'El campo es requerido';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  SearchError? validator(String value) {
    if ( value.isEmpty || value.trim().isEmpty ) return SearchError.empty;

    return null;
  }
}