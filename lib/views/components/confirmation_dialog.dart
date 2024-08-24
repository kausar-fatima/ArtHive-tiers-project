import 'package:art_hive_app/headers.dart';

Future<bool?> showConfirmationDialog(
  BuildContext context, {
  required String title,
  required String content,
  String confirmButtonText = 'Confirm',
}) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          CustomButton(
              text: confirmButtonText,
              parver: 8.0,
              onpress: () {
                Navigator.of(context).pop(true);
              }),
        ],
      );
    },
  );
}
