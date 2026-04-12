import 'package:flutter/material.dart';

import 'otp_input_field.dart';

class OtpInputRow extends StatelessWidget {
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final VoidCallback onCompleted;

  const OtpInputRow({
    super.key,
    required this.controllers,
    required this.focusNodes,
    required this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        4,
        (index) => OtpInputField(
          controller: controllers[index],
          focusNode: focusNodes[index],
          // ✅ Last field triggers onCompleted instead of nextFocus
          onCompleted: index == 3
              ? onCompleted
              : () => FocusScope.of(context).nextFocus(),
        ),
      ),
    );
  }
}
