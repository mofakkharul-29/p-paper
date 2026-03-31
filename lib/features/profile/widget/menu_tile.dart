import 'package:flutter/material.dart';

class MenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final void Function()? onTap;

  const MenuTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(
        title,
        style: const TextStyle(color: Colors.black87),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.black87,
      ),
      onTap: onTap,
    );
  }
}
