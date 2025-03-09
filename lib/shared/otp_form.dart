import 'package:flutter/material.dart';

import 'constant.dart';

class OtpForm extends StatefulWidget {
  final Function(String) onOtpCompleted; // Callback function

  const OtpForm({Key? key, required this.onOtpCompleted}) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  late List<FocusNode> focusNodes;
  late List<TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    focusNodes = List.generate(6, (index) => FocusNode());
    controllers = List.generate(6, (index) => TextEditingController());
  }

  @override
  void dispose() {
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void nextField(String value, int index) {
    if (value.length == 1 && index < focusNodes.length - 1) {
      focusNodes[index + 1].requestFocus();
    }
  }

  String getOtpCode() {
    return controllers.map((controller) => controller.text).join();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
              6,
              (index) => SizedBox(
                    width: 50.0,
                    child: TextFormField(
                      controller: controllers[index],
                      focusNode: focusNodes[index],
                      obscureText: true,
                      style: const TextStyle(fontSize: 24),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: otpInputDecoration,
                      onChanged: (value) {
                        nextField(value, index);
                        if (index == 5 && value.length == 1) {
                          focusNodes[index].unfocus();
                          String otp = getOtpCode();
                          widget.onOtpCompleted(otp); // 🔥 Send OTP outside
                        }
                      },
                    ),
                  )),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
