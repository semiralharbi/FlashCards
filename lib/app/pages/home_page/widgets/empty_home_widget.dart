import '../../../../gen/assets.gen.dart';
import '../../../theme/global_imports.dart';
import '../../../utils/enums/errors.dart';

class EmptyHomeWidget extends StatelessWidget {
  const EmptyHomeWidget({
    super.key,
    required this.text,
  });

  final Errors? text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(Assets.png.emptyBox.path, scale: 0.8),
        Text(
          text?.errorText(context) ?? '',
          style: context.tht.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: AppDimensions.d16,
            color: AppColors.daintree,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
