import 'package:flutter/material.dart';
import 'package:theik11_portfolio/core/constants/app_constants.dart';
import 'package:theik11_portfolio/core/constants/app_spacing.dart';
import 'package:theik11_portfolio/core/theme/app_theme.dart';
import 'package:theik11_portfolio/core/utils/responsive.dart';
import 'package:theik11_portfolio/ui/widgets/custom_widgets.dart';
import 'dart:html' as html;
import 'package:url_launcher/url_launcher.dart';

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
  
  bool _isHoveringEye = false;
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

  Future<void> _downloadResume() async {
    try {
      // Create download link for the resume PDF
      final String resumePath = 'assets/file/Ibrahim%20Khalil%20resume.pdf';
      
      // For web platform, use HTML anchor to trigger download
      html.AnchorElement(href: resumePath)
        ..setAttribute('download', 'Ibrahim_Khalil_Resume.pdf')
        ..click();
      
      _showSuccess('Resume download started!');
    } catch (e) {
      debugPrint('Error downloading resume: $e');
      _showError('Error opening resume: $e');
    }
  }

  void _showSuccess(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _openResumeDrive() async {
    final String driveUrl = 'https://drive.google.com/file/d/1_U6cDrLyulNkt-dhSRCkYjcq09rijo9Z/view?usp=sharing';
    try {
      // Try to open in new tab for web
      html.window.open(driveUrl, '_blank');
    } catch (e) {
      // Fallback to url_launcher
      final uri = Uri.parse(driveUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        _showError('Could not open link.');
      }
    }
  }

  Future<void> _openWhatsApp() async {
    const String phoneNumber = '8801889254301'; // WhatsApp number without +
    final String message = 'Hi, I\'m interested from your portfolio!';
    
    try {
      // WhatsApp web link
      final Uri whatsappUri = Uri.parse(
        'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}',
      );
      
      if (await canLaunchUrl(whatsappUri)) {
        await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
      } else {
        _showError('Could not open WhatsApp.');
      }
    } catch (e) {
      debugPrint('Error opening WhatsApp: $e');
      _showError('Error opening WhatsApp.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = Responsive.getMaxContentWidth(context);
    final isMobile = Responsive.isMobile(context);

    return Stack(
      children: [
        Container(
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
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(140),
                        child: Image.asset(
                          'assets/images/profile_picture.jpg',
                          fit: BoxFit.cover,
                          width: 280,
                          height: 280,
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
                            '${AppConstants.title} • Frontend-App Developer • UI/UX Enthusiast',
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
                              // Custom download button with embedded eye preview button
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AnimatedHoverButton(
                                    label: 'Download Resume',
                                    onPressed: _downloadResume,
                                    icon: Icons.download,
                                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                    iconSize: 28,
                                    fontSize: 18,
                                  ),
                                  const SizedBox(width: 8),
                                  MouseRegion(
                                    onEnter: (_) => setState(() => _isHoveringEye = true),
                                    onExit: (_) => setState(() => _isHoveringEye = false),
                                    child: GestureDetector(
                                      onTap: _openResumeDrive,
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: const Icon(
                                          Icons.remove_red_eye,
                                          size: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              AnimatedHoverButton(
                                label: 'Hire Me',
                                onPressed: _openWhatsApp,
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
                              '${AppConstants.title} • Frontend App Developer • UI/UX Enthusiast',
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
                                    // Desktop: custom download button with embedded eye
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        AnimatedHoverButton(
                                          label: 'Download Resume',
                                          onPressed: _downloadResume,
                                          icon: Icons.download,
                                                 padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                          iconSize: 28,
                                          fontSize: 18,
                                        ),
                                        const SizedBox(width: 8),
                                        MouseRegion(
                                          onEnter: (_) => setState(() => _isHoveringEye = true),
                                          onExit: (_) => setState(() => _isHoveringEye = false),
                                          child: GestureDetector(
                                            onTap: _openResumeDrive,
                                            child: Container(
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                color: AppColors.primary,
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: const Icon(
                                                Icons.remove_red_eye,
                                                size:18 ,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                   // const SizedBox(width: 8),
                                AnimatedHoverButton(
                                  label: 'Hire Me',
                                  onPressed: _openWhatsApp,
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
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(175),
                            child: Image.asset(
                              'assets/images/profile_picture.jpg',
                              fit: BoxFit.cover,
                              width: 350,
                              height: 350,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
      ),
        Positioned(
          // show centered tooltip preview above the buttons
          bottom: isMobile ? 220 : 220,
          left: (MediaQuery.of(context).size.width - 320) / 2,
          child: Visibility(
            visible: _isHoveringEye,
            child: Material(
              elevation: 12,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 320,
                height: isMobile ? 220 : 280,
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.picture_as_pdf, size: 48, color: Colors.red),
                    const SizedBox(height: AppSpacing.md),
                    Text('Resume Preview', style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: AppSpacing.sm),
                    Text('Click the eye to open Google Drive preview', style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
