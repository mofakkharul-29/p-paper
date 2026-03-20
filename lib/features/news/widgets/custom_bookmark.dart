import 'package:flutter/material.dart';

class CustomBookmark extends StatelessWidget {
  final Function()? onTap;
  const CustomBookmark({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      right: 10,
      child: Material(
        color: Colors.black.withAlpha(120),
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            // 👉 later: save to firestore
          },
          child: const Padding(
            padding: EdgeInsets.all(6),
            child: Icon(
              Icons.bookmark_border,
              color: Colors.amber,
              fontWeight: FontWeight.w700,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
