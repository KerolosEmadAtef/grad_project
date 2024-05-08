import 'package:flutter/material.dart';
import 'package:test1/constants/colors.dart';

// ignore: must_be_immutable
class MainAppTextField extends StatefulWidget {
  final Color textFieldColor;
  final Color borderColor;
  final String text;
  final Color textColor;
  final Color textTypingColor;
  final String? iconAssetPath;
  IconData? icon;
  final IconData defaultIcon;
  final bool isIcon;
  double? widthSize;
  double? heightSize;
  final bool obscureText;
  final TextEditingController? controller;
  final VoidCallback? onSuffixTap;

  MainAppTextField({
    super.key,
    required this.textFieldColor,
    required this.borderColor,
    required this.text,
    required this.textColor,
    required this.textTypingColor,
    this.iconAssetPath,
    this.icon,
    this.defaultIcon = Icons.email,
    this.isIcon = false,
    this.widthSize = double.infinity,
    this.heightSize = 55,
    this.obscureText = false,
    this.controller,
    this.onSuffixTap,
  });

  @override
  State<MainAppTextField> createState() => _MainAppTextFieldState();
}

class _MainAppTextFieldState extends State<MainAppTextField> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    // Initialize the controller if provided, or create a new one
    _textEditingController = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is disposed
    _textEditingController.dispose();
    super.dispose();
  }

  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.heightSize,
      width: widget.widthSize,
      child: TextField(
        controller: _textEditingController,
        keyboardType: TextInputType.emailAddress,
        obscureText: widget.obscureText ? _isObscure : false,
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.textFieldColor,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.borderColor),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.highligtedTextColor),
          ),
          hintText: widget.text,
          hintStyle: TextStyle(color: widget.textColor),
          prefixIcon: widget.isIcon && widget.iconAssetPath != null
              ? Image.asset(widget.iconAssetPath!)
              : Icon(widget.defaultIcon),
          suffixIcon: widget.onSuffixTap != null
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                    widget.onSuffixTap!(); // Call optional callback
                  },
                  icon: Icon(
                    _isObscure ? Icons.visibility_off : Icons.visibility,
                  ),
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
        ),
        style: TextStyle(color: widget.textTypingColor),
      ),
    );
  }
}
