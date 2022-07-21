import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';

class AppProgressIndicator extends StatelessWidget {
  const AppProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitCubeGrid(
        color: AppColors.whiteSmoke,
        size: AppDimensions.d120,
        duration: Duration(milliseconds: 800),
      ),
    );
  }
}
