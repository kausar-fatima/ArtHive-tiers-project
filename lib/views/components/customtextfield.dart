import 'package:art_hive_app/headers.dart';

class customTextField extends StatelessWidget {
  const customTextField({
    super.key,
    required this.controller,
    required this.hinttext,
    required this.isobscure,
    required this.icon,
    required this.maxline,
    required this.isdesc,
  });

  final TextEditingController controller;
  final String hinttext;
  final bool isobscure;
  final Icon icon;
  final int maxline;
  final bool isdesc;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hinttext,
        hintStyle: AppFonts.bodyText2,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        prefixIcon: !isdesc ? icon : null,
      ),
      obscureText: isobscure,
      maxLines: maxline,
    );
  }
}
