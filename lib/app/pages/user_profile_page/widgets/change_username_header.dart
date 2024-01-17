import '../../../../domain/entities/user/user_profile_entity.dart';
import '../../../theme/global_imports.dart';
import '../../../widgets/custom_text_field.dart';
import '../cubit/user_profile_cubit.dart';

class ChangeUsernameHeader extends StatefulWidget {
  const ChangeUsernameHeader({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  State<ChangeUsernameHeader> createState() => _ChangeUsernameHeaderState();
}

class _ChangeUsernameHeaderState extends State<ChangeUsernameHeader> {
  late final TextEditingController _controller;
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(_handleTextChange);
  }

  void _handleTextChange() {
    String text = _controller.text.trim();
    setState(() {
      _isButtonEnabled = text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CustomTextField(
            controller: _controller,
            maxLength: 10,
            hintText: context.tr.userProfilePage_textField,
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppDimensions.d3),
              child: GestureDetector(
                onTap: _isButtonEnabled ? _onCheckIconTap : null,
                child: Icon(
                  Icons.check,
                  color: _isButtonEnabled ? AppColors.daintree : AppColors.painGrey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppDimensions.d3),
              child: GestureDetector(
                onTap: () {
                  widget.onTap();
                },
                child: const Icon(Icons.cancel),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _onCheckIconTap() {
    context.read<UserProfileCubit>().onUpdateUserProfileButton(
          entity: UserProfileEntity(
            name: _controller.text.trim(),
          ),
        );
    widget.onTap();
  }
}
