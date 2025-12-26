import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:theik11_portfolio/core/constants/app_spacing.dart';
import 'package:theik11_portfolio/core/theme/app_theme.dart';

/// Space background with animated stars
class SpaceBackground extends StatefulWidget {
  final Widget child;
  final int starCount;

  const SpaceBackground({
    required this.child,
    this.starCount = 100,
    super.key,
  });

  @override
  State<SpaceBackground> createState() => _SpaceBackgroundState();
}

class _SpaceBackgroundState extends State<SpaceBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Star> stars;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    // Generate random stars
    stars = List.generate(
      widget.starCount,
      (index) => Star(
        x: (index * 73.0) % 1.0,
        y: (index * 43.0) % 1.0,
        size: 0.5 + (index % 3) * 0.5,
        opacity: 0.3 + (index % 7) * 0.1,
        duration: Duration(seconds: 5 + (index % 10)),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF0a0e27), // Deep space blue
                const Color(0xFF1a1a3a), // Space purple
                const Color(0xFF0f172a), // Dark blue
              ],
            ),
          ),
          child: Stack(
            children: [
              // Animated stars background
              CustomPaint(
                painter: StarsPainter(
                  stars: stars,
                  animation: _controller.value,
                ),
                size: Size.infinite,
              ),
              // Animated nebula-like glow
              Positioned(
                top: -200,
                right: -200,
                child: Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFFDC2626).withOpacity(0.1),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -150,
                left: -150,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFFF87171).withOpacity(0.05),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              // Content
              child!,
            ],
          ),
        );
      },
      child: widget.child,
    );
  }
}

/// Star model for space background
class Star {
  final double x;
  final double y;
  final double size;
  final double opacity;
  final Duration duration;

  Star({
    required this.x,
    required this.y,
    required this.size,
    required this.opacity,
    required this.duration,
  });
}

/// Custom painter for stars
class StarsPainter extends CustomPainter {
  final List<Star> stars;
  final double animation;

  StarsPainter({
    required this.stars,
    required this.animation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (final star in stars) {
      // Calculate twinkling effect
      final twinkle = (math.sin(animation * math.pi * 2 / (star.duration.inMilliseconds / 1000)) + 1) / 2;
      final opacity = star.opacity * (0.5 + twinkle * 0.5);

      paint.color = Colors.white.withOpacity(opacity);

      canvas.drawCircle(
        Offset(star.x * size.width, star.y * size.height),
        star.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(StarsPainter oldDelegate) {
    return oldDelegate.animation != animation;
  }
}

/// Animated gradient background with subtle particle effect
class AnimatedGradientBackground extends StatefulWidget {
  final Widget child;

  const AnimatedGradientBackground({
    required this.child,
    super.key,
  });

  @override
  State<AnimatedGradientBackground> createState() =>
      _AnimatedGradientBackgroundState();
}

class _AnimatedGradientBackgroundState extends State<AnimatedGradientBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.bgPrimary,
                AppColors.bgSecondary.withOpacity(0.5),
                AppColors.bgTertiary.withOpacity(0.3),
              ],
              stops: [
                0.0,
                0.5 + 0.1 * (_controller.value * 2 - 1),
                1.0,
              ],
            ),
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

/// Animated profile picture with glowing border and rotation
class AnimatedProfilePicture extends StatefulWidget {
  final double size;
  final Color glowColor;
  final Widget child;

  const AnimatedProfilePicture({
    required this.child,
    this.size = 200,
    this.glowColor = AppColors.primary,
    super.key,
  });

  @override
  State<AnimatedProfilePicture> createState() =>
      _AnimatedProfilePictureState();
}

class _AnimatedProfilePictureState extends State<AnimatedProfilePicture>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // Outer animated dashed ring
            Transform.rotate(
              angle: _controller.value * 2 * math.pi,
              child: CustomPaint(
                size: Size(widget.size + 50, widget.size + 50),
                painter: DashedRingPainter(
                  color: widget.glowColor.withOpacity(0.6),
                  strokeWidth: 2,
                ),
              ),
            ),

            // Middle pulsing ring
            Container(
              width: widget.size + 25,
              height: widget.size + 25,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: widget.glowColor.withOpacity(
                    0.3 + 0.3 * math.sin(_controller.value * 2 * math.pi),
                  ),
                  width: 1.5,
                ),
              ),
            ),

            // Inner glowing ring
            Container(
              width: widget.size + 10,
              height: widget.size + 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: widget.glowColor.withOpacity(0.5),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.glowColor.withOpacity(0.4),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),

            // Profile picture content
            Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: widget.glowColor,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.glowColor.withOpacity(0.6),
                    blurRadius: 20,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: ClipOval(
                child: child!,
              ),
            ),
          ],
        );
      },
      child: widget.child,
    );
  }
}

/// Custom painter for dashed rotating ring
class DashedRingPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  DashedRingPainter({
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - (strokeWidth / 2);
    
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    const dashWidth = 15.0;
    const dashSpace = 10.0;
    const totalLength = dashWidth + dashSpace;

    double distance = 0;
    while (distance < 2 * math.pi * radius) {
      final startAngle = distance / radius;
      final endAngle = (distance + dashWidth) / radius;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        endAngle - startAngle,
        false,
        paint,
      );

      distance += totalLength;
    }
  }

  @override
  bool shouldRepaint(DashedRingPainter oldDelegate) => false;
}

/// Custom cursor widget for desktop
class CustomCursorWidget extends StatefulWidget {
  final Widget child;
  final bool showOnDesktopOnly;

  const CustomCursorWidget({
    required this.child,
    this.showOnDesktopOnly = true,
    super.key,
  });

  @override
  State<CustomCursorWidget> createState() => _CustomCursorWidgetState();
}

class _CustomCursorWidgetState extends State<CustomCursorWidget> {
  late Offset _cursorPosition = Offset.zero;
  late bool _isMouseOver = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        setState(() {
          _cursorPosition = event.localPosition;
        });
      },
      onEnter: (event) {
        setState(() {
          _isMouseOver = true;
        });
      },
      onExit: (event) {
        setState(() {
          _isMouseOver = false;
        });
      },
      child: Stack(
        children: [
          widget.child,
          if (_isMouseOver)
            Positioned(
              left: _cursorPosition.dx - 8,
              top: _cursorPosition.dy - 8,
              child: IgnorePointer(
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.primary,
                      width: 2,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Animated button with hover effect
class AnimatedHoverButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isPrimary;
  final IconData? icon;
  final EdgeInsets padding;
  final double? iconSize;
  final double? fontSize;

  const AnimatedHoverButton({
    required this.label,
    required this.onPressed,
    this.isPrimary = true,
    this.icon,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    this.iconSize,
    this.fontSize,
    super.key,
  });

  @override
  State<AnimatedHoverButton> createState() => _AnimatedHoverButtonState();
}

class _AnimatedHoverButtonState extends State<AnimatedHoverButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.isPrimary
            ? ElevatedButton.icon(
                onPressed: widget.onPressed,
                icon: widget.icon != null ? Icon(widget.icon, size: widget.iconSize ?? 24) : const SizedBox(),
                label: Text(
                  widget.label,
                  style: TextStyle(fontSize: widget.fontSize ?? 16),
                ),
                style: ElevatedButton.styleFrom(
                  padding: widget.padding,
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              )
            : OutlinedButton.icon(
                onPressed: widget.onPressed,
                icon: widget.icon != null ? Icon(widget.icon, size: widget.iconSize ?? 24) : const SizedBox(),
                label: Text(
                  widget.label,
                  style: TextStyle(fontSize: widget.fontSize ?? 16),
                ),
                style: OutlinedButton.styleFrom(
                  padding: widget.padding,
                  side: const BorderSide(color: AppColors.primary, width: 2),
                  foregroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
      ),
    );
  }
}

/// Fade in animation
class FadeInAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final bool animateOnBuild;

  const FadeInAnimation({
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.curve = Curves.easeOut,
    this.animateOnBuild = true,
    super.key,
  });

  @override
  State<FadeInAnimation> createState() => _FadeInAnimationState();
}

class _FadeInAnimationState extends State<FadeInAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );

    if (widget.animateOnBuild) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: widget.child,
    );
  }
}

/// Slide in animation
class SlideInAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Offset beginOffset;

  const SlideInAnimation({
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.curve = Curves.easeOut,
    this.beginOffset = const Offset(0, 0.2),
    super.key,
  });

  @override
  State<SlideInAnimation> createState() => _SlideInAnimationState();
}

class _SlideInAnimationState extends State<SlideInAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(begin: widget.beginOffset, end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: widget.child,
    );
  }
}

/// Skill chip widget
class SkillChip extends StatefulWidget {
  final String label;
  final Color? backgroundColor;
  final Color? textColor;

  const SkillChip({
    required this.label,
    this.backgroundColor,
    this.textColor,
    super.key,
  });

  @override
  State<SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<SkillChip>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? AppColors.bgSecondary,
            border: Border.all(
              color: widget.textColor ?? AppColors.primary,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              color: widget.textColor ?? AppColors.primary,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

/// Section divider
class SectionDivider extends StatelessWidget {
  final String? label;

  const SectionDivider({this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sectionGap),
      child: Column(
        children: [
          if (label != null) ...[
            Text(
              label!,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
          ],
          Container(
            height: 1,
            width: 60,
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
