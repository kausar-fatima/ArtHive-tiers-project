import 'package:art_hive_app/headers.dart';

class AppFonts {
  // Headings
  static TextStyle heading1 = GoogleFonts.montserrat(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: primarycolor,
  );

  static TextStyle heading2 = GoogleFonts.montserrat(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: primarycolor,
  );

  static TextStyle heading3 = GoogleFonts.raleway(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: primarycolor,
  );
  static TextStyle heading4 = GoogleFonts.raleway(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: primarycolor,
  );

  // Body Text
  static TextStyle bodyText1 = GoogleFonts.lato(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: accentcolor,
  );

  static TextStyle bodyText2 = GoogleFonts.lato(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: secondarycolor,
  );

  // Accent/Logo Text
  static TextStyle logoText = GoogleFonts.playfairDisplay(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.italic,
    color: Colors.black,
  );

  // Button Text
  static TextStyle buttonText = GoogleFonts.montserrat(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // Caption Text
  static TextStyle captionText = GoogleFonts.lato(
    fontSize: 11,
    fontWeight: FontWeight.normal,
    color: primarycolor,
  );
}
