import 'package:flutter/material.dart';
import 'package:p_papper/features/onboarding/domain/page_model.dart';

class PageBuilderHelper extends StatelessWidget {
  final PageModel page;
  static const double _cardRadius = 5.0;
  const PageBuilderHelper({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_cardRadius),
        color: const Color.fromARGB(255, 146, 144, 144),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildImageSection(context),
          const SizedBox(height: 25),
          Expanded(child: _buildTextSection()),
        ],
      ),
    );
  }

  Widget _buildImageSection(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(_cardRadius),
        topRight: Radius.circular(_cardRadius),
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.60,
        width: double.infinity,
        child: Image.asset(page.image, fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildTextSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        page.title,
        textAlign: TextAlign.start,
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.8,
          color: Colors.black87,
        ),
      ),
    );
  }
}
