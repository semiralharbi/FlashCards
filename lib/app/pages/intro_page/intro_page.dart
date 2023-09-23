import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../theme/app_dimensions.dart';
import '../../theme/consts.dart';
import '../../utils/enums/context_extension.dart';
import '../../utils/router/app_router.dart';
import 'widgets/intro_fade_transition.dart';
import 'widgets/intro_slide_button.dart';
import 'widgets/intro_slide_transition.dart';

@RoutePage()
class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> with TickerProviderStateMixin {
  late final AnimationController _rightBtnController;
  late final AnimationController _leftBtnController;
  late final AnimationController _rightContainerController;
  late final AnimationController _leftContainerController;
  late final AnimationController _fadeTextController;

  late final Animation<Offset> _rightBtnAnimation;
  late final Animation<Offset> _leftBtnAnimation;
  late final Animation<Offset> _rightContainerAnimation;
  late final Animation<Offset> _leftContainerAnimation;
  late final Animation<double> _fadeTextAnimation;

  @override
  void initState() {
    super.initState();

    _initControllers();
    _initAnimations();
    _configureAnimationListeners();
  }

  void _initControllers() {
    _rightBtnController = _createController(ms: 600);
    _leftBtnController = _createController(ms: 600);
    _rightContainerController = _createController(s: 1);
    _leftContainerController = _createController(s: 1);
    _fadeTextController = _createController(s: 1);
  }

  AnimationController _createController({int? ms, int? s}) {
    return AnimationController(
      duration: ms != null ? Duration(milliseconds: ms) : Duration(seconds: s!),
      vsync: this,
    );
  }

  void _initAnimations() {
    _rightBtnAnimation = _offsetAnimation(_rightBtnController, const Offset(1.0, 0.0), Offset.zero);
    _leftBtnAnimation = _offsetAnimation(_leftBtnController, const Offset(-1.0, 0.0), Offset.zero);
    _rightContainerAnimation = _offsetAnimation(_rightContainerController, const Offset(1.0, 0.0), Offset.zero);
    _leftContainerAnimation = _offsetAnimation(_leftContainerController, const Offset(-1.0, 0.0), Offset.zero);
    _fadeTextAnimation = Tween(begin: 0.0, end: 1.0).animate(_fadeTextController);
  }

  Animation<Offset> _offsetAnimation(AnimationController controller, Offset start, Offset end) {
    return Tween(begin: start, end: end).animate(controller);
  }

  void _configureAnimationListeners() {
    _rightContainerController.forward();
    _leftContainerController.forward();
    _leftContainerController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _fadeTextController.forward();
        _fadeTextController.addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            _rightBtnController.forward();
            _leftBtnController.forward();
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          IntroSlideTransition(
            animation: _leftContainerAnimation,
            alignment: Alignment.topLeft,
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(AppDimensions.d68),
            ),
          ),
          const Spacer(flex: 2),
          IntroFadeTransition(animation: _fadeTextAnimation, text: context.tr.welcome),
          const Spacer(flex: 3),
          IntroSlideButton(
            margin: const EdgeInsets.only(right: AppDimensions.d20),
            animation: _leftBtnAnimation,
            alignment: Alignment.centerLeft,
            text: context.tr.login,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(AppDimensions.d68),
              bottomRight: Radius.circular(AppDimensions.d68),
            ),
            transitionOffset: const Offset(-AppDimensions.d2, AppConst.staticZero),
            destinationPage: const LoginRoute(),
          ),
          const Spacer(),
          IntroSlideButton(
            margin: const EdgeInsets.only(left: AppDimensions.d20),
            animation: _rightBtnAnimation,
            alignment: Alignment.centerRight,
            text: context.tr.registration,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppDimensions.d68),
              bottomLeft: Radius.circular(AppDimensions.d68),
            ),
            transitionOffset: const Offset(AppDimensions.d2, AppConst.staticZero),
            destinationPage: const RegistrationRoute(),
          ),
          const Spacer(flex: 3),
          IntroSlideTransition(
            animation: _rightContainerAnimation,
            alignment: Alignment.bottomRight,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(AppDimensions.d68)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _rightBtnController.dispose();
    _leftBtnController.dispose();
    _rightContainerController.dispose();
    _leftContainerController.dispose();
    _fadeTextController.dispose();
    super.dispose();
  }
}
