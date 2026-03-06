import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p_papper/core/utils/custom_elevated_button.dart';
import 'package:p_papper/core/utils/custom_text.dart';
import 'package:p_papper/core/utils/scaffold_body_container_color.dart';
import 'package:p_papper/features/onboarding/data/pages.dart';
import 'package:p_papper/features/onboarding/presentation/provider/current_page_provider.dart';
import 'package:p_papper/features/onboarding/presentation/widgets/custom_animated_container.dart';
import 'package:p_papper/features/onboarding/presentation/widgets/page_builder_helper.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState
    extends ConsumerState<OnboardingScreen> {
  late final PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = onboardingPages;
    final currentPageIndex = ref.watch(currentPageProvider);

    return Scaffold(
      backgroundColor: gradientStart,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _controller,
                    itemCount: pages.length,
                    onPageChanged: (value) {
                      ref
                          .read(
                            currentPageProvider.notifier,
                          )
                          .onPageChange(value);
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
                    child:
                        currentPageIndex == pages.length - 1
                        ? SizedBox()
                        : CustomElevatedButton(
                            bgColor: Colors.transparent,
                            overlayColor:
                                Colors.transparent,
                            onPressed: () =>
                                _onPressed(type: 'skip'),
                            child: getChild(
                              'Skip',
                              Colors.amber,
                              16,
                            ),
                          ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(pages.length, (
                index,
              ) {
                final isActive = currentPageIndex == index;
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4.0,
                  ),
                  child: CustomAnimatedContainer(
                    isActive: isActive,
                  ),
                );
              }),
            ),
            const SizedBox(height: 10),
            CustomElevatedButton(
              elevation: 3,
              overlayColor: Colors.transparent,
              tintColor: Colors.transparent,
              fixedSize: Size(
                MediaQuery.of(context).size.width - 35,
                55,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(
                  5,
                ),
              ),
              bgColor:
                  currentPageIndex ==
                      onboardingPages.length - 1
                  ? Colors.amber
                  : const Color.fromARGB(
                      255,
                      107,
                      103,
                      103,
                    ),
              onPressed: () => _onPressed(type: 'next'),
              child: getChild(
                currentPageIndex ==
                        onboardingPages.length - 1
                    ? 'Get Started'
                    : 'Next',
                Colors.black87,
                18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onPressed({required String type}) {
    if (!_controller.hasClients) return;

    if (type == 'skip') {
      _controller.animateToPage(
        onboardingPages.length - 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else if (type == 'next') {
      final currentPageIndex = ref.read(
        currentPageProvider,
      );
      final nextPage = (currentPageIndex + 1).clamp(
        0,
        onboardingPages.length - 1,
      );

      _controller.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget? getChild(
    String text,
    Color? color,
    double? fontSize,
  ) {
    return CustomText(
      text: text,
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
    );
  }
}
