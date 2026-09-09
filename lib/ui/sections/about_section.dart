import 'package:flutter/material.dart';
import 'package:theik11_portfolio/core/constants/app_spacing.dart';
import 'package:theik11_portfolio/core/theme/app_theme.dart';
import 'package:theik11_portfolio/core/utils/responsive.dart';
import 'package:theik11_portfolio/ui/widgets/custom_widgets.dart';

/// About Section
class AboutSection extends StatelessWidget {
  final GlobalKey sectionKey;

  const AboutSection({required this.sectionKey, super.key});

  @override
  Widget build(BuildContext context) {
    final maxWidth = Responsive.getMaxContentWidth(context);

    return Container(
      key: sectionKey,
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.containerPadding,
        vertical: AppSpacing.sectionPadding,
      ),
      child: Center(
        child: SizedBox(
          width: maxWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section Title
              FadeInAnimation(
                child: Text(
                  'About Me',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              const SizedBox(height: AppSpacing.xxxl),

              // Content
              FadeInAnimation(
                duration: const Duration(milliseconds: 800),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'With over 2 years of hands-on experience, I thrive at the intersection of great design and solid engineering. I love taking an idea from a simple concept to a fully deployed, high-performing Flutter application.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Text(
                      'I\'m proficient in Dart, Firebase, and REST APIs, always focusing on writing clean code with optimal state management like GetX and Provider. Whether it\'s building a complex UI flow or ensuring a smooth app release, I am dedicated to delivering top-tier digital products.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),

                    const SizedBox(height: AppSpacing.xxl),

                    // Quick Facts
                    Wrap(
                      spacing: AppSpacing.xxxl,
                      runSpacing: AppSpacing.xl,
                      children: [
                        _QuickFact(
                          title: '15+',
                          subtitle: 'Projects Completed',
                        ),
                        _QuickFact(title: '20+', subtitle: 'Features Built'),
                        _QuickFact(
                          title: '2',
                          subtitle: 'Years of Hands-on Experience',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickFact extends StatelessWidget {
  final String title;
  final String subtitle;

  const _QuickFact({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(color: AppColors.primary),
        ),
        Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
