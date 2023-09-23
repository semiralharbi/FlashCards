import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_dimensions.dart';
import '../../theme/consts.dart';
import '../../utils/enums/context_extension.dart';
import '../login_page/login_page.dart';
import '../registration_page/registration_page.dart';

@RoutePage()
class IntroPage extends HookWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AnimationController rightButtonSlideController = useAnimationController(
      duration: const Duration(milliseconds: 600),
    );
    final AnimationController leftButtonSlideController = useAnimationController(
      duration: const Duration(milliseconds: 600),
    );
    final AnimationController rightSlideController = useAnimationController(
      duration: const Duration(seconds: 1),
    );
    final AnimationController leftSlideController = useAnimationController(
      duration: const Duration(seconds: 1),
    );
    final AnimationController fadeAnimationController = useAnimationController(
      duration: const Duration(seconds: 1),
    );

    final rightSlideButtonAnimation = Tween(begin: const Offset(1.0, 0.0), end: Offset.zero).animate(
      rightButtonSlideController,
    );
    final leftSlideButtonAnimation = Tween(begin: const Offset(-1.0, 0.0), end: Offset.zero).animate(
      leftButtonSlideController,
    );
    final rightSlideContainerAnimation = Tween(begin: const Offset(1.0, 0.0), end: Offset.zero).animate(
      rightSlideController,
    );
    final leftSlideContainerAnimation = Tween(begin: const Offset(-1.0, 0.0), end: Offset.zero).animate(
      leftSlideController,
    );
    final textAnimation = Tween(begin: 0.0, end: 1.0).animate(
      fadeAnimationController,
    );

    useEffect(
      () {
        rightSlideController.forward();
        leftSlideController.forward();
        leftSlideController.addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            fadeAnimationController.forward();
            fadeAnimationController.addStatusListener((status) {
              if (status == AnimationStatus.completed) {
                rightButtonSlideController.forward();
                leftButtonSlideController.forward();
              }
            });
          }
        });
        return () {
          rightButtonSlideController.dispose();
          leftButtonSlideController.dispose();
          rightSlideController.dispose();
          leftSlideController.dispose();
          fadeAnimationController.dispose();
        };
      },
      [],
    );

    return Scaffold(
      body: Column(
        children: <Widget>[
          SlideTransition(
            position: leftSlideContainerAnimation,
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                height: context.mqs.height * 0.1,
                width: context.mqs.width * 0.92,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.daintree,
                      blurRadius: AppDimensions.d4,
                      spreadRadius: AppDimensions.d2,
                    ),
                  ],
                  color: AppColors.daintree,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(
                      AppDimensions.d68,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Spacer(
            flex: 2,
          ),
          FadeTransition(
            opacity: textAnimation,
            child: Center(
              child: Text(
                context.tr.welcome,
                style: context.tht.displayMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const Spacer(
            flex: 3,
          ),
          SlideTransition(
            position: leftSlideButtonAnimation,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.daintree,
                      blurRadius: AppDimensions.d6,
                      blurStyle: BlurStyle.outer,
                    ),
                  ],
                  border: Border.all(color: AppColors.daintree),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(
                      AppDimensions.d68,
                    ),
                    bottomRight: Radius.circular(
                      AppDimensions.d68,
                    ),
                  ),
                ),
                height: context.mqs.height * 0.1,
                width: context.mqs.width * 0.86,
                child: InkWell(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(
                      AppDimensions.d68,
                    ),
                    bottomRight: Radius.circular(
                      AppDimensions.d68,
                    ),
                  ),
                  splashColor: AppColors.blueStone,
                  onTap: () async => await Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const LoginPage(),
                      transitionDuration: const Duration(milliseconds: AppConst.millisecond400),
                      transitionsBuilder: (_, a, __, c) => SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(-AppDimensions.d2, AppConst.staticZero),
                          end: const Offset(AppConst.staticZero, AppConst.staticZero),
                        ).animate(a),
                        child: c,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      context.tr.login,
                      style: context.tht.displayMedium?.copyWith(
                        shadows: [
                          const Shadow(
                            color: AppColors.white,
                            blurRadius: AppDimensions.d8,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          SlideTransition(
            position: rightSlideButtonAnimation,
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.daintree,
                      blurRadius: AppDimensions.d6,
                      blurStyle: BlurStyle.outer,
                    ),
                  ],
                  border: Border.all(
                    color: AppColors.daintree,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(
                      AppDimensions.d68,
                    ),
                    bottomLeft: Radius.circular(
                      AppDimensions.d68,
                    ),
                  ),
                ),
                height: context.mqs.height * 0.1,
                width: context.mqs.width * 0.86,
                child: InkWell(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(
                      AppDimensions.d68,
                    ),
                    bottomLeft: Radius.circular(
                      AppDimensions.d68,
                    ),
                  ),
                  splashColor: AppColors.blueStone,
                  onTap: () async => await Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const RegistrationPage(),
                      transitionDuration: const Duration(milliseconds: AppConst.millisecond400),
                      transitionsBuilder: (_, a, __, c) => SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(AppDimensions.d2, AppConst.staticZero),
                          end: const Offset(AppConst.staticZero, AppConst.staticZero),
                        ).animate(a),
                        child: c,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      context.tr.registration,
                      style: context.tht.displayMedium?.copyWith(
                        shadows: [
                          const Shadow(
                            color: AppColors.white,
                            blurRadius: AppDimensions.d8,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Spacer(
            flex: 3,
          ),
          SlideTransition(
            position: rightSlideContainerAnimation,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                height: context.mqs.height * 0.1,
                width: context.mqs.width * 0.92,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.daintree,
                      blurRadius: AppDimensions.d4,
                      spreadRadius: AppDimensions.d1,
                    ),
                  ],
                  color: AppColors.daintree,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      AppDimensions.d68,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
