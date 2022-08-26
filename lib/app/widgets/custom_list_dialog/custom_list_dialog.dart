import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../rounded_icon_button.dart';
import 'list_dialog_content.dart';

class CustomListDialog extends HookWidget {
  const CustomListDialog({
    Key? key,
    required this.enWordListControllers,
    required this.translatedListControllers,
    required this.onForwardTap,
  }) : super(key: key);

  final List<TextEditingController> enWordListControllers;
  final List<TextEditingController> translatedListControllers;
  final VoidCallback onForwardTap;

  @override
  Widget build(BuildContext context) {
    final addWords = useState(1);
    return Center(
      child: Material(
        borderRadius: const BorderRadius.all(
          Radius.circular(
            AppDimensions.d16,
          ),
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: AppDimensions.d8,
            horizontal: AppDimensions.d6,
          ),
          decoration: const BoxDecoration(
            color: AppColors.whiteSmoke,
            borderRadius: BorderRadius.all(
              Radius.circular(
                AppDimensions.d16,
              ),
            ),
          ),
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width * 0.92,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: addWords.value,
                  itemBuilder: (context, index) => ListDialogContent(
                    enWordController: enWordListControllers[index],
                    translatedController: translatedListControllers[index],
                  ),
                ),
              ),
              const SizedBox(
                height: AppDimensions.d12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: AppDimensions.d8,
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: RoundedIconButton(
                          elementHeight: AppDimensions.d36,
                          padding: const EdgeInsets.all(
                            AppDimensions.d12,
                          ),
                          onTap: () {
                              enWordListControllers.add(TextEditingController());
                              translatedListControllers.add(TextEditingController());
                              addWords.value++;
                          },
                          iconData: Icons.add,
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: AppDimensions.d8,
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: RoundedIconButton(
                        elementHeight: AppDimensions.d36,
                        padding: const EdgeInsets.all(
                          AppDimensions.d12,
                        ),
                        onTap: onForwardTap,
                        iconData: Icons.arrow_forward_rounded,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
