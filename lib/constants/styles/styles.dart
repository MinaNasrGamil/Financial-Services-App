import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  // Colors
  static const Color primary = Color(0xffEB2930);
  static const Color background = Colors.white;
  static const Color text = Colors.black87;
  static const Color hintText = Colors.grey;

  // Text Styles
  static final TextStyle heading = GoogleFonts.roboto(
      fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black);

  static final TextStyle subheading = GoogleFonts.roboto(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: text,
  );

  static final TextStyle bodyText = GoogleFonts.roboto(
    fontSize: 14,
    color: text,
  );

  static final TextStyle menuButtonText = GoogleFonts.roboto(
      fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white);

  static final ButtonStyle menuButton = ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: AppStyles.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}
