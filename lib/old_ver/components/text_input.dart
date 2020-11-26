import 'package:flutter/material.dart';
import 'package:soedja_freelance/old_ver/themes/color.dart';

class TextInputProps {
  String hintText;
  TextInputType keyboardType;
  FormFieldValidator<String> validator;
  TextEditingController controller;
  FocusNode focusNode;
  ValueChanged<String> onFieldSubmitted;

  TextInputProps({
    this.hintText,
    this.keyboardType,
    this.validator,
    this.controller,
    this.focusNode,
    this.onFieldSubmitted,
  });
}

class TextInput extends StatefulWidget {
  final TextInputProps props;
  final ValueChanged<String> onChanged;
  final InputBorder border;
  final EdgeInsets padding;
  final int maxLines;
  final int minLines;
  final int maxLength;
  final double fontSize;
  final bool enabled;

  const TextInput({
    Key key,
    this.onChanged,
    this.props,
    this.border,
    this.padding,
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.fontSize,
    this.enabled = true,
  });

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onChanged: widget.onChanged,
        controller: widget.props.controller,
        keyboardType: widget.props.keyboardType,
        validator: widget.props.validator,
        style: TextStyle(
            fontSize: widget.fontSize ?? 14.0, color: AppColors.dark, fontWeight: FontWeight.normal),
        textAlign: TextAlign.left,
        cursorColor: AppColors.black,
        onFieldSubmitted: widget.props.onFieldSubmitted,
        focusNode: widget.props.focusNode,
        minLines: widget.minLines ?? 1,
        maxLines: widget.maxLines ?? 1,
        maxLength: widget.maxLength,
        enabled: widget.enabled,
        decoration: InputDecoration(
          counterText: '',
          hintText: widget.props.hintText,
          focusedBorder: widget.border ?? OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.black,width: 1.5 )),
          border: widget.border ?? OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.black.withOpacity(.2), width: 1.0)),
          contentPadding: widget.padding ?? EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
          labelStyle: TextStyle(
              color: AppColors.black,
              fontSize: 14.0,
              fontWeight: FontWeight.normal,
              letterSpacing: 0.3),
        ));
  }
}