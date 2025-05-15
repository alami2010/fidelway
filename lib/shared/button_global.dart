import 'package:flutter/material.dart';

import 'constant.dart';

class ButtonGlobal extends StatelessWidget {
  final String buttontext;
  final Decoration buttonDecoration;
  final VoidCallback? onPressed;
  final Color textColor;
  final double? height;
  final double fontSize;
  final IconData? icon;
  final bool isLoading;

  const ButtonGlobal({
    Key? key,
    required this.buttontext,
    required this.buttonDecoration,
    required this.onPressed,
    this.textColor = Colors.white,
    this.height,
    this.fontSize = 16.0,
    this.icon,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          height: height ?? 54.0,
          decoration: buttonDecoration,
          child: Center(
            child: isLoading
                ? SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(textColor),
                      strokeWidth: 2.5,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (icon != null) ...[
                        Icon(
                          icon,
                          color: textColor,
                          size: fontSize + 2,
                        ),
                        const SizedBox(width: 8.0),
                      ],
                      Text(
                        buttontext,
                        style: kTextStyle.copyWith(
                          fontSize: fontSize,
                          color: textColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class ButtonGlobalWithoutIcon extends StatelessWidget {
  final String buttontext;
  final Decoration buttonDecoration;
  final VoidCallback? onPressed;
  final Color buttonTextColor;
  final double? height;
  final double fontSize;
  final bool isOutlined;
  final bool isLoading;

  const ButtonGlobalWithoutIcon({
    Key? key,
    required this.buttontext,
    required this.buttonDecoration,
    required this.onPressed,
    required this.buttonTextColor,
    this.height,
    this.fontSize = 16.0,
    this.isOutlined = false,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          height: height ?? 54.0,
          decoration: buttonDecoration,
          child: Center(
            child: isLoading
                ? SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(buttonTextColor),
                      strokeWidth: 2.5,
                    ),
                  )
                : Text(
                    buttontext,
                    style: kTextStyle.copyWith(
                      fontSize: fontSize,
                      color: buttonTextColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class ButtonGlobalOutlined extends StatelessWidget {
  final String buttontext;
  final Color borderColor;
  final VoidCallback? onPressed;
  final Color textColor;
  final double? height;
  final double fontSize;
  final IconData? icon;

  const ButtonGlobalOutlined({
    Key? key,
    required this.buttontext,
    required this.borderColor,
    required this.onPressed,
    required this.textColor,
    this.height,
    this.fontSize = 16.0,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          height: height ?? 54.0,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: borderColor,
              width: 1.5,
            ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    color: textColor,
                    size: fontSize + 2,
                  ),
                  const SizedBox(width: 8.0),
                ],
                Text(
                  buttontext,
                  style: kTextStyle.copyWith(
                    fontSize: fontSize,
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonGlobalSmall extends StatelessWidget {
  final String buttontext;
  final Decoration buttonDecoration;
  final VoidCallback? onPressed;
  final Color textColor;
  final double width;
  final double fontSize;
  final IconData? icon;

  const ButtonGlobalSmall({
    Key? key,
    required this.buttontext,
    required this.buttonDecoration,
    required this.onPressed,
    required this.textColor,
    required this.width,
    this.fontSize = 14.0,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: width,
          height: 40.0,
          decoration: buttonDecoration,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    color: textColor,
                    size: fontSize + 2,
                  ),
                  const SizedBox(width: 6.0),
                ],
                Text(
                  buttontext,
                  style: kTextStyle.copyWith(
                    fontSize: fontSize,
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonGlobalWithIcon extends StatelessWidget {
  final String buttontext;
  final Decoration buttonDecoration;
  final VoidCallback? onPressed;
  final Color textColor;
  final double? height;
  final double fontSize;
  final Widget icon;

  const ButtonGlobalWithIcon({
    Key? key,
    required this.buttontext,
    required this.buttonDecoration,
    required this.onPressed,
    required this.textColor,
    this.height,
    this.fontSize = 16.0,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          height: height ?? 54.0,
          decoration: buttonDecoration,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 12.0),
                Text(
                  buttontext,
                  style: kTextStyle.copyWith(
                    fontSize: fontSize,
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showCustomDialog({
  required BuildContext context,
  required String title,
  required String content,
  String? buttonText,
  VoidCallback? onButtonPressed,
  bool showCloseButton = true,
  IconData? icon,
  Color? iconColor,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showCloseButton)
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, size: 20),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ),
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 50,
                  color: iconColor ?? kMainColor,
                ),
                const SizedBox(height: 20),
              ],
              Text(
                title,
                style: kTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              Text(
                content,
                style: kTextStyle.copyWith(color: kGreyTextColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              if (buttonText != null)
                ButtonGlobal(
                  buttontext: buttonText,
                  buttonDecoration: BoxDecoration(
                    color: kMainColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: onButtonPressed ?? () => Navigator.pop(context),
                  height: 45,
                ),
            ],
          ),
        ),
      );
    },
  );
}

