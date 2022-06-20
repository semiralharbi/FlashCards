import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../theme/app_colors.dart';

class AppProgressIndicator extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const SpinKitCubeGrid(
      color: AppColors.electricViolet,
      duration: Duration(milliseconds: 800),
    );
  }
}
