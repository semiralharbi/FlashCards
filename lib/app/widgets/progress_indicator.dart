import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';

class AppProgressIndicator extends StatelessWidget {
  const AppProgressIndicator({Key? key, this.color}) : super(key: key);
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitCubeGrid(
        color: color ?? AppColors.whiteSmoke,
        size: AppDimensions.d60,
        duration: const Duration(milliseconds: 800),
      ),
    );
  }
}
