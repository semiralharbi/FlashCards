import '../../../theme/global_imports.dart';
import '../../../utils/enums/errors.dart';

class EmptyHomeWidget extends StatelessWidget {
  const EmptyHomeWidget({
    super.key,
    required this.failure,
  });

  final Errors? failure;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Text(
        failure?.errorText(context) ?? '',
        style: context.tht.titleMedium?.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: AppDimensions.d14,
          color: AppColors.daintree,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
