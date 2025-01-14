import 'package:art_hive_app/headers.dart';

class ProfileButtons extends StatelessWidget {
  const ProfileButtons({
    super.key,
    required this.onpress,
    required this.text,
    required this.icon,
  });

  final VoidCallback onpress;
  final String text;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: size.width * 0.1, vertical: size.height * 0.008),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 10),
            Text(
              text,
              style: AppFonts.bodyText1.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        onpress();
      },
    );
  }
}
