import 'package:flutter/material.dart';

class TextFormWithTitle extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final Icon icon;
  final String hint;
  final Widget? suffexIcon;
  final bool isScure;
  const TextFormWithTitle({
    super.key,
    required this.title,
    required this.controller,
    required this.icon,
    required this.hint,
    this.suffexIcon,
    this.isScure=false,
  });

  @override
  State<TextFormWithTitle> createState() => _TextFormWithTitleState();
}

class _TextFormWithTitleState extends State<TextFormWithTitle> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        TextFormField(
          controller: widget.controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) => value == null || value.isEmpty
              ? "${widget.title} Cannot be Empty"
              : null,
          obscureText: widget.isScure,
          decoration: InputDecoration(
            prefixIcon: widget.icon,
            suffixIcon: widget.suffexIcon,
            hintText: widget.hint,
            hintStyle: TextStyle(color: Colors.grey),
            fillColor: Colors.grey[100],
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(16),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}
