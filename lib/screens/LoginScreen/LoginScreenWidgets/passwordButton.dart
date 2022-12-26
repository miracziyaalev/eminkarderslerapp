import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  final String hintText;
  final TextEditingController textEditingController;

  const PasswordInput(
      {required this.textEditingController, required this.hintText, Key? key})
      : super(key: key);

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool pwdVisibility = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 300),
      child: TextFormField(
        controller: widget.textEditingController,
        obscureText: !pwdVisibility,
        decoration: InputDecoration(
          hintText: widget.hintText,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(25.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(25.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(25.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(25.0),
          ),
          suffixIcon: InkWell(
            onTap: () => setState(
              () => pwdVisibility = !pwdVisibility,
            ),
            child: Icon(
              pwdVisibility
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: Colors.grey.shade400,
              size: 28,
            ),
          ),
        ),
        validator: (val) {
          if (val!.isEmpty) {
            return 'Required';
          }
          return null;
        },
      ),
    );
  }
}
