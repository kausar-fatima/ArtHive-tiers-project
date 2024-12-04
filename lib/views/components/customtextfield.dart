import 'package:art_hive_app/headers.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hinttext,
    this.isPasswordField = false,
    required this.icon,
    required this.maxline,
    required this.isdesc,
    required this.validator,
  });

  final TextEditingController controller;
  final String hinttext;
  final bool isPasswordField; // Indicates if this is a password field
  final Icon icon;
  final int maxline;
  final bool isdesc;
  final String? Function(String?) validator;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isPasswordVisible = false; // Toggle password visibility

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText:
          widget.isPasswordField && !isPasswordVisible, // Hide/show text
      maxLines: widget.maxline,
      decoration: InputDecoration(
        hintText: widget.hinttext,
        hintStyle: AppFonts.bodyText2,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        prefixIcon: !widget.isdesc ? widget.icon : null,
        errorMaxLines: 2,
        suffixIcon: widget.isPasswordField
            ? IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible; // Toggle visibility
                  });
                },
              )
            : null,
      ),
      style: AppFonts.bodyText2, // Style for the input text
    );
  }
}
