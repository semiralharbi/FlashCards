import 'package:flutter/material.dart';

import '../theme/app_dimensions.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    this.withDivider = true,
    required this.title,
    this.subtitle,
    this.contentPadding,
  });

  final bool withDivider;
  final Widget title;
  final Widget? subtitle;
  final EdgeInsets? contentPadding;

  @override
  Widget build(BuildContext context) => ListTile(
        subtitle: withDivider
            ? const Divider(
                height: AppDimensions.d40,
                thickness: 1.5,
              )
            : subtitle,
        title: title,
        contentPadding: contentPadding,
      );
}
