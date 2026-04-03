import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_papper/features/news/presentation/provider/news_notifier_provoder.dart';

class CategorySection extends ConsumerWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsState = ref.watch(newsNotifierProvider);
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    const sections = [
      'all',
      'business',
      'technology',
      'sport',
      'world',
    ];
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: sections.length,
        itemBuilder: (context, index) {
          final section = sections[index];
          final selected =
              section == newsState.selectedSection;

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 6,
            ),
            child: ChoiceChip(
              selectedColor: Colors.amber,
              checkmarkColor: Colors.black87,
              label: Text(section.toUpperCase()),
              labelStyle: TextStyle(
                color: selected
                    ? Colors
                          .black87 // better contrast on amber
                    : isDark
                    ? Colors.white70
                    : Colors.black87,
              ),
              // labelStyle: TextStyle(
              // color: isDark
              //     ? Colors.white70
              //     : Colors.black87,

              // ),
              selected: selected,
              onSelected: (_) {
                ref
                    .read(newsNotifierProvider.notifier)
                    .onSectionChanged(section);
              },
            ),
          );
        },
      ),
    );
  }
}
