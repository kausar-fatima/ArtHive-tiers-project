import 'package:art_hive_app/headers.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.parver,
    required this.onpress,
  });

  final String text;
  final parver;
  final VoidCallback onpress;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onpress,
          style: ElevatedButton.styleFrom(
            backgroundColor: primarycolor, // Button color
            padding: EdgeInsets.symmetric(vertical: parver),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: text == "Loading..."
              ? const CircularProgressIndicator(
                  strokeWidth: 1.6,
                  color: Colors.white,
                )
              : Text(
                  text,
                  style:
                      AppFonts.bodyText2.copyWith(color: white, fontSize: 16),
                ),
        ),
      ),
    );
  }
}
