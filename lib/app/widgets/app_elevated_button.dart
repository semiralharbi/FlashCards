import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';
import '../theme/app_fonts.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    required this.text,
    Key? key,
  });

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          bottom: AppDimensions.d12,
        ),
        child: ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  AppDimensions.d8,
                ),
                side: const BorderSide(
                  color: AppColors.cinnamon,
                ),
              ),
            ),
          ),
          child: SizedBox(
            height: AppDimensions.d50,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text(
                text,
                style: AppFonts.boldPlayfair18,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      );
}
