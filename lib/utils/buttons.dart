import 'package:flutter/material.dart';
import 'package:oweflow/utils/colors.dart';

// ignore: must_be_immutable
class SaveButton extends StatelessWidget {
  String title;
  final void Function()? onTap;

  SaveButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [
            Color(0xffE3823C),
            Color(0xffE33C3C),
            //add more colors
          ]),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
              fixedSize: Size(270, 49),
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          child: Text(
            title,
            style: TextStyle(
                fontSize: 14,
                fontFamily: "Mulish",
                fontWeight: FontWeight.w500,
                color: colorwhite),
          ),
        ));
  }
}

// ignore: must_be_immutable
class OutlineButton extends StatelessWidget {
  String title;
  final void Function()? onTap;

  OutlineButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
          side: BorderSide(color: Color(0xffE94057), width: 1),
          fixedSize: Size(46, 20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      child: Text(
        title,
        style: TextStyle(
            fontFamily: "Mulish",
            fontWeight: FontWeight.w600,
            color: Color(0xffE94057)),
      ),
    );
  }
}
