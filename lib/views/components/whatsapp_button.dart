import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppButton extends StatelessWidget {
  final String phoneNumber;

  const WhatsAppButton({
    super.key,
    required this.phoneNumber,
  }); // Replace with your desired number

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(Icons.call, color: Colors.white),
      label: Text("Chat on WhatsApp"),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      onPressed: () async {
        final Uri whatsappUrl = Uri.parse("https://wa.me/$phoneNumber");
        if (await canLaunchUrl(whatsappUrl)) {
          await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Could not open WhatsApp")),
          );
        }
      },
    );
  }
}
