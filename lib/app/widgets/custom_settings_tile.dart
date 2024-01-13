import '../pages/create_folder_page/widgets/country_button.dart';
import '../theme/global_imports.dart';

class FlagTile extends StatelessWidget {
  const FlagTile({
    super.key,
    required this.title,
    required this.countryCode,
    required this.onSelect,
    required this.flagWidth,
    required this.flagHeight,
  });

  final String title;
  final double flagWidth;
  final double flagHeight;
  final String countryCode;
  final Function(String) onSelect;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            title,
            style: context.tht.displaySmall,
          ),
        ),
        SizedBox(
          width: flagWidth,
          height: flagHeight,
          child: CountryButton(
            initialCountryCode: countryCode,
            onSelect: onSelect,
            width: AppDimensions.d10,
            height: AppDimensions.d10,
          ),
        ),
      ],
    );
  }
}
