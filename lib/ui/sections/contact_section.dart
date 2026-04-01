import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:theik11_portfolio/core/constants/app_constants.dart';
import 'package:theik11_portfolio/core/constants/app_spacing.dart';
import 'package:theik11_portfolio/core/theme/app_theme.dart';
import 'package:theik11_portfolio/core/utils/responsive.dart';
import 'package:theik11_portfolio/ui/widgets/custom_widgets.dart';
import 'package:theik11_portfolio/data/contact_message_service.dart';

/// Contact Section with Form
class ContactSection extends StatefulWidget {
  final GlobalKey sectionKey;

  const ContactSection({required this.sectionKey, super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _subjectController;
  late TextEditingController _messageController;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _subjectController = TextEditingController();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _subjectController.text.isEmpty ||
        _messageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      // Show loading dialog
      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      'Sending your message...',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.textPrimary,
                          ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }

      // Submit to Firebase
      final contactService = ContactMessageService();
      await contactService.submitContactMessage(
        name: _nameController.text,
        email: _emailController.text,
        subject: _subjectController.text,
        message: _messageController.text,
      );

      if (mounted) {
        // Close loading dialog
        Navigator.of(context).pop();

        setState(() => _isSubmitting = false);
        _nameController.clear();
        _emailController.clear();
        _subjectController.clear();
        _messageController.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Message sent successfully!'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        // Close loading dialog
        Navigator.of(context).pop();

        setState(() => _isSubmitting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final maxWidth = Responsive.getMaxContentWidth(context);

    return Container(
      key: widget.sectionKey,
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.containerPadding,
        vertical: AppSpacing.sectionPadding,
      ),
      color: AppColors.bgSecondary.withOpacity(0.5),
      child: Center(
        child: SizedBox(
          width: maxWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section Title
              FadeInAnimation(
                child: Text(
                  'Get In Touch',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              FadeInAnimation(
                child: Text(
                  'Have a project in mind? Let\'s talk about it.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: AppSpacing.xxxl),

              // Content
              FadeInAnimation(
                duration: const Duration(milliseconds: 800),
                child: isMobile
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Contact Info (Mobile - Top)
                          _ContactInfo(
                            icon: Icons.email,
                            label: 'Email',
                            value: AppConstants.email,
                          ),
                          const SizedBox(height: AppSpacing.xxl),
                          _ContactInfo(
                            icon: Icons.phone,
                            label: 'Phone',
                            value: AppConstants.phone,
                          ),
                          const SizedBox(height: AppSpacing.xxl),

                          // Social Links (Mobile - Top)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Connect',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: AppSpacing.md),
                              Wrap(
                                spacing: AppSpacing.md,
                                children: [
                                  _SocialButton(
                                    icon: Icons.language,
                                    label: 'GitHub',
                                    url: AppConstants.githubUrl,
                                  ),
                                  _SocialButton(
                                    icon: Icons.language,
                                    label: 'LinkedIn',
                                    url: AppConstants.linkedinUrl,
                                  ),
                                  _SocialButton(
                                    icon: Icons.language,
                                    label: 'Medium',
                                    url: AppConstants.mediumUrl,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.xxxl),

                          // Contact Form (Mobile - Below)
                          Column(
                            children: [
                              TextField(
                                controller: _nameController,
                                style: const TextStyle(
                                  color: AppColors.textPrimary,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Your Name',
                                  prefixIcon: const Icon(Icons.person),
                                ),
                              ),
                              const SizedBox(height: AppSpacing.lg),
                              TextField(
                                controller: _emailController,
                                style: const TextStyle(
                                  color: AppColors.textPrimary,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Your Email',
                                  prefixIcon: const Icon(Icons.email),
                                ),
                              ),
                              const SizedBox(height: AppSpacing.lg),
                              TextField(
                                controller: _subjectController,
                                style: const TextStyle(
                                  color: AppColors.textPrimary,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Subject',
                                  prefixIcon: const Icon(Icons.subject),
                                ),
                              ),
                              const SizedBox(height: AppSpacing.lg),
                              TextField(
                                controller: _messageController,
                                style: const TextStyle(
                                  color: AppColors.textPrimary,
                                ),
                                maxLines: 5,
                                decoration: InputDecoration(
                                  hintText: 'Your Message',
                                  prefixIcon: const Icon(Icons.message),
                                ),
                              ),
                              const SizedBox(height: AppSpacing.xl),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: _isSubmitting ? null : _submitForm,
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 18),
                                  ),
                                  child: _isSubmitting
                                      ? const SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.5,
                                            valueColor: AlwaysStoppedAnimation<Color>(
                                              Colors.white,
                                            ),
                                          ),
                                        )
                                      : const Text(
                                          'Send Message',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Contact Info (Desktop/Tablet)
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _ContactInfo(
                                  icon: Icons.email,
                                  label: 'Email',
                                  value: AppConstants.email,
                                ),
                                const SizedBox(height: AppSpacing.xxl),
                                _ContactInfo(
                                  icon: Icons.phone,
                                  label: 'Phone',
                                  value: AppConstants.phone,
                                ),
                                const SizedBox(height: AppSpacing.xxl),

                                // Social Links
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Connect',
                                      style: Theme.of(context).textTheme.titleLarge,
                                    ),
                                    const SizedBox(height: AppSpacing.md),
                                    Wrap(
                                      spacing: AppSpacing.md,
                                      children: [
                                        _SocialButton(
                                          icon: Icons.language,
                                          label: 'GitHub',
                                          url: AppConstants.githubUrl,
                                        ),
                                        _SocialButton(
                                          icon: Icons.language,
                                          label: 'LinkedIn',
                                          url: AppConstants.linkedinUrl,
                                        ),
                                        _SocialButton(
                                          icon: Icons.language,
                                          label: 'Medium',
                                          url: AppConstants.mediumUrl,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: AppSpacing.xxxl),

                          // Contact Form (Desktop/Tablet)
                          Expanded(
                            child: Column(
                              children: [
                                TextField(
                                  controller: _nameController,
                                  style: const TextStyle(
                                    color: AppColors.textPrimary,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Your Name',
                                    prefixIcon: const Icon(Icons.person),
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.lg),
                                TextField(
                                  controller: _emailController,
                                  style: const TextStyle(
                                    color: AppColors.textPrimary,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Your Email',
                                    prefixIcon: const Icon(Icons.email),
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.lg),
                                TextField(
                                  controller: _subjectController,
                                  style: const TextStyle(
                                    color: AppColors.textPrimary,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Subject',
                                    prefixIcon: const Icon(Icons.subject),
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.lg),
                                TextField(
                                  controller: _messageController,
                                  style: const TextStyle(
                                    color: AppColors.textPrimary,
                                  ),
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                    hintText: 'Your Message',
                                    prefixIcon: const Icon(Icons.message),
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.xl),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: _isSubmitting ? null : _submitForm,
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(vertical: 18),
                                    ),
                                    child: _isSubmitting
                                        ? const SizedBox(
                                            height: 24,
                                            width: 24,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2.5,
                                              valueColor: AlwaysStoppedAnimation<Color>(
                                                Colors.white,
                                              ),
                                            ),
                                          )
                                        : const Text(
                                            'Send Message',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
              const SizedBox(height: AppSpacing.sectionGap),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactInfo extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ContactInfo({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  State<_ContactInfo> createState() => _ContactInfoState();
}

class _ContactInfoState extends State<_ContactInfo> {
  bool _isHovered = false;

  Future<void> _handleContactAction() async {
    try {
      if (widget.label.toLowerCase() == 'email') {
        // Open email client
        final Uri emailUri = Uri(
          scheme: 'mailto',
          path: widget.value,
        );
        if (await canLaunchUrl(emailUri)) {
          await launchUrl(emailUri);
        }
      } else if (widget.label.toLowerCase() == 'phone') {
        // Open phone dialer
        final Uri phoneUri = Uri(
          scheme: 'tel',
          path: widget.value,
        );
        if (await canLaunchUrl(phoneUri)) {
          await launchUrl(phoneUri);
        }
      }
    } catch (e) {
      debugPrint('Error launching contact action: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isClickable =
        widget.label.toLowerCase() == 'email' || widget.label.toLowerCase() == 'phone';

    return MouseRegion(
      onEnter: (_) {
        if (isClickable) {
          setState(() => _isHovered = true);
        }
      },
      onExit: (_) {
        if (isClickable) {
          setState(() => _isHovered = false);
        }
      },
      cursor: isClickable ? SystemMouseCursors.click : MouseCursor.defer,
      child: GestureDetector(
        onTap: isClickable ? _handleContactAction : null,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: AppColors.gradientPrimary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(widget.icon, color: Colors.white),
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.label,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    widget.value,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: _isHovered ? AppColors.primary : AppColors.textSecondary,
                          decoration: _isHovered ? TextDecoration.underline : null,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.url,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _launchUrl() async {
    try {
      final Uri uri = Uri.parse(widget.url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        debugPrint('Could not launch ${widget.url}');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      child: ScaleTransition(
        scale: Tween<double>(begin: 1.0, end: 1.1).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primary),
            borderRadius: BorderRadius.circular(8),
          ),
          child: GestureDetector(
            onTap: _launchUrl,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(widget.icon, size: 16, color: AppColors.primary),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  widget.label,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
