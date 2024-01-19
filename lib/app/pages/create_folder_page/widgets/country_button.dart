import 'package:country_flags/country_flags.dart';
import 'package:country_picker/country_picker.dart';

import '../../../theme/global_imports.dart';
import '../../../theme/theme_manager.dart';

class CountryButton extends StatefulWidget {
  const CountryButton({
    super.key,
    required this.initialCountryCode,
    required this.onSelect,
    required this.width,
    required this.height,
  });

  final String initialCountryCode;
  final Function(String) onSelect;
  final double width;
  final double height;

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
    return ElevatedButton(
      style: context.th.elevatedButtonTheme.style?.copyWith(
        backgroundColor: MaterialStateProperty.all(AppColors.buttonInactive),
        minimumSize: MaterialStateProperty.all(Size(widget.width, widget.height)),
      ),
      onPressed: _showCountryPicker,
      child: CountryFlag.fromCountryCode(
        _selectedCountryCode,
        height: AppDimensions.d60,
        width: AppDimensions.d60,
      ),
    );
  }
}
