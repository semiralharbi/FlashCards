import 'package:country_flags/country_flags.dart';

import '../../../theme/global_imports.dart';

class LanguageFlagsBox extends StatelessWidget {
  const LanguageFlagsBox({
    super.key,
    this.sourceLanguageCode = 'de',
    this.targetLanguageCode = 'en',
  });

  final String sourceLanguageCode;
  final String targetLanguageCode;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CountryFlag.fromLanguageCode(
            sourceLanguageCode,
            height: AppDimensions.d26,
            width: AppDimensions.d26,
          ),
          CountryFlag.fromLanguageCode(
            targetLanguageCode,
            height: AppDimensions.d26,
            width: AppDimensions.d26,
          ),
        ],
      );
}
