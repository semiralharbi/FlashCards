import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';
import '../utils/enums/context_extension.dart';

class DictionaryContainer extends StatelessWidget {
  const DictionaryContainer({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: AppDimensions.d6),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "$title:",
                style: context.tht.subtitle1!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(
            height: context.mqs.height * 0.01,
          ),
          Container(
            width: context.mqs.width,
            height: context.mqs.height * 0.1,
            decoration: BoxDecoration(
              color: AppColors.whiteSmoke,
              border: Border.all(color: AppColors.daintree),
              borderRadius: BorderRadius.circular(AppDimensions.d16),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.daintree,
                  offset: Offset.zero,
                  blurRadius: AppDimensions.d4,
                  spreadRadius: 0.4,
                ),
              ],
            ),
            child: SafeArea(
              minimum: const EdgeInsets.all(AppDimensions.d12),
              child: Text(title),
            ),
          ),
        ],
      );
}
