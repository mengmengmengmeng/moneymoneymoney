import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@module
abstract class InjectionModule {
  @lazySingleton
  http.Client get client => http.Client();
}
