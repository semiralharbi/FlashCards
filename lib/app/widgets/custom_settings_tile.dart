import '../pages/create_folder_page/widgets/country_button.dart';
import '../theme/global_imports.dart';

class CustomSettingsTile extends StatelessWidget {
  const CustomSettingsTile({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: context.tht.displaySmall,
          ),
          const SizedBox(width: 60, height: 60, child: CountryButton(initialCountryCode: 'PL')),
        ],
      ),
    );
  }
}
