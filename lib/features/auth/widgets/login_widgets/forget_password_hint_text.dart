import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:homz/core/theme/app_colors.dart';

class ForgetPasswordHintText extends StatelessWidget {
  const ForgetPasswordHintText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'forget_password_hint'.tr(),
      style: TextStyle(color: AppColors.lightGray, fontSize: 14, height: 1.6),
    );
  }
}
