import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_papper/core/utils/scaffold_body_container_color.dart';
import 'package:p_papper/features/onboarding/data/pages.dart';
import 'package:p_papper/features/onboarding/presentation/widgets/page_builder_helper.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState
    extends ConsumerState<OnboardingScreen> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final pages = onboardingPages;

    return Scaffold(
      backgroundColor: gradientStart,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  PageView.builder(
                    itemCount: 3,
                    onPageChanged: (index) {
                      setState(() {
                        currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      final showPage = pages[index];

                      return PageBuilderHelper(
                        page: showPage,
                      );
                    },
                  ),
                  Positioned(
                    top: 0,
                    right: 20,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(
                              0,
                              250,
                              247,
                              247,
                            ),
                      ),
                      child: Text('Skip'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            //page indicator
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4.0,
                  ),
                  child: CircleAvatar(radius: 6),
                );
              }),
            ),
            const SizedBox(height: 10),
            // next button
            ElevatedButton(
              onPressed: () {},
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
