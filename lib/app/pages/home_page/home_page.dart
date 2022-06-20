import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../widgets/app_scaffold.dart';
import 'widgets/email_registration_box_widget.dart';
import 'widgets/login_box_widget.dart';

class HomePage extends HookWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginAnimationValue = useState(true);
    final registrationAnimationValue = useState(false);
    return AppScaffold(
      child: Stack(
        children: [
          LoginBoxWidget(
            loginAnimationValue: loginAnimationValue.value,
            onTap: () {
              loginAnimationValue.value = false;
              registrationAnimationValue.value = true;
            },
          ),
          EmailRegistrationBoxWidget(
            emailRegAnimationValue: registrationAnimationValue.value,
            onTap: () {
              loginAnimationValue.value = true;
              registrationAnimationValue.value = false;
            },
          ),
        ],
      ),
    );
  }
}
