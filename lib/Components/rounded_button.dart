import 'package:flutter/material.dart';
import 'package:doers_app/Components/hex_colors.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({this.title, this.colour, this.font_size, this.text_color,  @required this.onPressed});

  final Color colour;
  final String title;
  final Function onPressed;
  final double font_size;
  final Color text_color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 300.0,
          height: 42.0,
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: text_color,
              fontSize: font_size,
            ),
          ),
        ),
      ),
    );
  }
}
