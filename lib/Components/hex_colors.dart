import 'package:flutter/material.dart';

// Convert hex strings into hex numbers
Color fromHex(String hex) {
  final hexCode = hex.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}

// Map of the colors chosen for this app
Map<int, Color> color = {
  50: fromHex('#9fffdf'), // light green
  100: fromHex('#69efad'), // green
  200: fromHex('#2bbc7d'), // dark green
  300: fromHex('#ffffff'), // white
  400: fromHex('#cfd8dc'), // light grey
  500: fromHex('#9ea7aa'), // dark grey
  600: fromHex('#000000'), // black
};