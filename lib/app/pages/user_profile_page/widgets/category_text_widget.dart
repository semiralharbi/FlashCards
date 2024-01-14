import '../../../theme/global_imports.dart';

class CategoryTextWidget extends StatelessWidget {
  const CategoryTextWidget({super.key, required this.categoryText});

  final String categoryText;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        categoryText,
        textAlign: TextAlign.left,
        style: context.tht.displayMedium,
      ),
    );
  }
}
