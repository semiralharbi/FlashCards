import 'package:country_flags/country_flags.dart';
import 'package:country_picker/country_picker.dart';

import '../../../theme/global_imports.dart';
import '../../../theme/theme_manager.dart';

class CountryButton extends StatefulWidget {
  const CountryButton({super.key, required this.initialCountryCode});

  final String initialCountryCode;

  @override
  State<CountryButton> createState() => _CountryButtonState();
}

class _CountryButtonState extends State<CountryButton> {
  late String _selectedCountryCode;

  @override
  void initState() {
    _selectedCountryCode = widget.initialCountryCode;
    super.initState();
  }

  void _showCountryPicker() {
    showCountryPicker(
      context: context,
      countryListTheme: ThemeManager.countryListThemeData,
      onSelect: (country) {
        setState(() {
          _selectedCountryCode = country.countryCode;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimensions.d120,
      height: AppDimensions.d80,
      child: ElevatedButton(
        style: context.th.elevatedButtonTheme.style?.copyWith(
          backgroundColor: MaterialStateProperty.all(AppColors.buttonInactive),
        ),
        onPressed: _showCountryPicker,
        child: CountryFlag.fromCountryCode(
          _selectedCountryCode,
          height: AppDimensions.d60,
          width: AppDimensions.d60,
        ),
      ),
    );
  }
}
