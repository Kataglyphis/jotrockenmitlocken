import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class EMailButton extends StatefulWidget {
  const EMailButton(
      {super.key,
      required this.title,
      required this.eMail,
      required this.firstName});
  final String title;
  final String eMail;
  final String firstName;

  @override
  State<StatefulWidget> createState() => EMailButtonState();
}

class EMailButtonState extends State<EMailButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          textStyle: Theme.of(context).textTheme.titleLarge,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        ),
        onPressed: () async {
          String email = Uri.encodeComponent(widget.eMail);
          String subject = Uri.encodeComponent("Awesome job offer");
          String body = Uri.encodeComponent("Hi ${widget.firstName}");
          //print(subject); //output: Hello%20Flutter
          Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
          if (await launchUrl(mail)) {
            //email app opened
          } else {
            //email app is not opened
          }
        },
        child: Text(
          widget.title,
        ));
  }
}
