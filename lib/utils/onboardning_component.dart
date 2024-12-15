import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingComponent extends StatefulWidget {
  final String image;
  final String text_1;
  final String text_2;

  const OnboardingComponent(
      {super.key,
        required this.image,
        required this.text_1,
        required this.text_2
      });

  @override
  State<OnboardingComponent> createState() => _OnboardingComponentState();
}

class _OnboardingComponentState extends State<OnboardingComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(widget.image),
            Padding(
                padding: const EdgeInsets.only(top: 20, left: 20),
                child: Text(
                  widget.text_1,
                  style: GoogleFonts.poppins(fontSize: 28,color: Colors.white,fontWeight: FontWeight.w800),
                )),
            Padding(
                padding: const EdgeInsets.only(top: 20, left: 20),
                child: Text(
                  widget.text_2,
                  maxLines: 3,
                  style: GoogleFonts.poppins(fontSize: 12,color: Colors.white,fontWeight: FontWeight.normal),
                )),
          ],
        ));
  }
}