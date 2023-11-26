import 'package:injectable/injectable.dart';
import 'package:translator_plus/translator_plus.dart';

@module
abstract class Translator {
  @lazySingleton
  GoogleTranslator get instance => GoogleTranslator();
}
