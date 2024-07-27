import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextField extends StatelessWidget {
  final String? placeHolder;
  final String? hint;
  final TextEditingController textEditingController;
  final bool? readOnly;
  final Function(String)? onChanged;
  final List<TextInputFormatter> formatData;
  final Widget? suffix;
  final Widget? prefix;


  const CommonTextField(
      {super.key,
      this.placeHolder,
      this.hint,
      required this.textEditingController,
      this.readOnly=false,
      this.onChanged,
      required this.formatData,
      this.suffix,
      this.prefix});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      placeHolder==null?const SizedBox.shrink():  Text(placeHolder ?? "",
            style: TextStyle(fontSize: 14, color: colorTheme.onBackground)),
        const SizedBox(height: 4),
        Stack(
          children: [
            TextField(
              readOnly: readOnly??false,
              onChanged: onChanged,
              controller: textEditingController,
              style: TextStyle(
                  fontSize: 20,
                  color: colorTheme.onSurface,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                    left: 24, right: 124, top: 16, bottom: 16),
                hintText: hint,
                filled: true,
                fillColor: colorTheme.secondary,
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 1, color: Colors.transparent),
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              inputFormatters: formatData,
            ),
            Positioned(
                top: 16, right: 8, child: suffix ?? const SizedBox.shrink()),
          ],
        ),
      ],
    );
  }
}
