import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroment{
  static String api = dotenv.env['api']?? 'No hay Api key';
}