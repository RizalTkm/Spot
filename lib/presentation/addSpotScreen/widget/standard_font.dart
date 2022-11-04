import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StandardFont extends StatelessWidget {
  final String title;

  const StandardFont({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
