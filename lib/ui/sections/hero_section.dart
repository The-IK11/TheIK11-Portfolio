import 'package:flutter/material.dart';
import 'package:theik11_portfolio/core/constants/app_constants.dart';
import 'package:theik11_portfolio/core/constants/app_spacing.dart';
import 'package:theik11_portfolio/core/theme/app_theme.dart';
import 'package:theik11_portfolio/core/utils/responsive.dart';
import 'package:theik11_portfolio/ui/widgets/custom_widgets.dart';

/// Hero / Home Section
class HeroSection extends StatefulWidget {
  final ScrollController scrollController;
  final GlobalKey sectionKey;

  const HeroSection({
    required this.scrollController,
    required this.sectionKey,
    super.key,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _characterCount;
  final String _fullText =
      'I build beautiful, fast, and scalable Flutter applications.';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _characterCount =
        StepTween(begin: 0, end: _fullText.length).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = Responsive.getMaxContentWidth(context);
    final isMobile = Responsive.isMobile(context);

    return Container(
      key: widget.sectionKey,
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.containerPadding,
        vertical: AppSpacing.sectionPadding,
      ),
      child: Center(
        child: SizedBox(
          width: maxWidth,
          child: isMobile
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Profile Picture (Mobile - Top)
                    AnimatedProfilePicture(
                      size: 280,
                      glowColor: AppColors.primary,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: AppColors.gradientPrimary,
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 140,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxxl),
                    // Text Content (Mobile - Below)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Greeting
                        FadeInAnimation(
                          duration: const Duration(milliseconds: 600),
                          child: Text(
                            'Hey, I\'m ${AppConstants.fullName}',
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),

                        // Typing Animation Text - No fixed height, wrap naturally
                        AnimatedBuilder(
                          animation: _characterCount,
                          builder: (context, child) {
                            return SlideInAnimation(
                              duration: const Duration(milliseconds: 400),
                              child: Text(
                                _fullText.substring(0, _characterCount.value),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      color: AppColors.primary,
                                    ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: AppSpacing.xl),

                        // Subtitle
                        FadeInAnimation(
                          duration: const Duration(milliseconds: 800),
                          child: Text(
                            '${AppConstants.title} • Full-Stack Developer • UI/UX Enthusiast',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xxxl),

                        // CTA Buttons
                        FadeInAnimation(
                          duration: const Duration(milliseconds: 1000),
                          child: Wrap(
                            spacing: AppSpacing.lg,
                            runSpacing: AppSpacing.lg,
                            children: [
                              AnimatedHoverButton(
                                label: 'Download Resume',
                                onPressed: () {
                                  // TODO: Implement resume download
                                },
                                icon: Icons.download,
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                iconSize: 28,
                                fontSize: 18,
                              ),
                              AnimatedHoverButton(
                                label: 'Hire Me',
                                onPressed: () {
                                  // TODO: Scroll to contact section
                                },
                                isPrimary: false,
                                icon: Icons.mail,
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                iconSize: 28,
                                fontSize: 18,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Text Content (Desktop - Left)
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Greeting
                          FadeInAnimation(
                            duration: const Duration(milliseconds: 600),
                            child: Text(
                              'Hey, I\'m ${AppConstants.fullName}',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.lg),

                          // Typing Animation Text - No fixed height, wrap naturally
                          AnimatedBuilder(
                            animation: _characterCount,
                            builder: (context, child) {
                              return SlideInAnimation(
                                duration: const Duration(milliseconds: 400),
                                child: Text(
                                  _fullText.substring(0, _characterCount.value),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        color: AppColors.primary,
                                      ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: AppSpacing.xl),

                          // Subtitle
                          FadeInAnimation(
                            duration: const Duration(milliseconds: 800),
                            child: Text(
                              '${AppConstants.title} • Full-Stack Developer • UI/UX Enthusiast',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xxxl),

                          // CTA Buttons
                          FadeInAnimation(
                            duration: const Duration(milliseconds: 1000),
                            child: Wrap(
                              spacing: AppSpacing.lg,
                              runSpacing: AppSpacing.lg,
                              children: [
                                AnimatedHoverButton(
                                  label: 'Download Resume',
                                  onPressed: () {
                                    // TODO: Implement resume download
                                  },
                                  icon: Icons.download,
                                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                  iconSize: 28,
                                  fontSize: 18,
                                ),
                                AnimatedHoverButton(
                                  label: 'Hire Me',
                                  onPressed: () {
                                    // TODO: Scroll to contact section
                                  },
                                  isPrimary: false,
                                  icon: Icons.mail,
                                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                  iconSize: 28,
                                  fontSize: 18,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xxxl),
                    // Profile Picture (Desktop - Right)
                    Expanded(
                      child: Center(
                        child: AnimatedProfilePicture(
                          size: 350,
                          glowColor: AppColors.primary,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: AppColors.gradientPrimary,
                            ),
                            child: const Icon(
                              Icons.person,
                              size: 180,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
