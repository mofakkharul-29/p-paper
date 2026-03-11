import 'package:flutter/material.dart';

class LogRegOptions extends StatelessWidget {
  const LogRegOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getButton(
          onPressed: () {},
          image: 'assets/images/google.png',
        ),
        const SizedBox(width: 20),
        getButton(
          onPressed: () {},
          image: 'assets/images/facebook.png',
        ),
        const SizedBox(width: 20),
        getButton(
          onPressed: () {},
          image: 'assets/images/phone.png',
        ),
      ],
    );
  }

  Widget getButton({
    required void Function()? onPressed,
    required String image,
  }) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        fixedSize: Size(60, 60),
        shape: const CircleBorder(),
        surfaceTintColor: Colors.transparent,
        padding: EdgeInsets.zero,
        overlayColor: Colors.transparent,
        alignment: Alignment.center,
        backgroundColor: Colors.transparent,
      ),
      child: Image.asset(
        image,
        fit: BoxFit.contain,
        height: 55,
        width: 55,
      ),
    );
  }
}
