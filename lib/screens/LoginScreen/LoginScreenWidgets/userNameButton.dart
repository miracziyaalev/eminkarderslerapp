import 'package:flutter/material.dart';

class UsernameInput extends StatefulWidget {
  final String hintText;
  final TextEditingController textEditingController;

  const UsernameInput(
      {required this.textEditingController, required this.hintText, Key? key})
      : super(key: key);

  @override
  State<UsernameInput> createState() => _UsernameInputState();
}

class _UsernameInputState extends State<UsernameInput> {
  bool pwdVisibility = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 300),
      child: TextFormField(
        controller: widget.textEditingController,
        obscureText: pwdVisibility,
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
              width: 1,
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
        ),
      ),
    );
  }
}
