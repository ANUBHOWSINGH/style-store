
import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _logoScale;
  late final Animation<double> _fadeIn;
  late final Animation<Offset> _slideUp;

  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );

    _logoScale = Tween<double>(
      begin: 0.72,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _fadeIn = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.1, 1.0, curve: Curves.easeIn),
    );

    _slideUp = Tween<Offset>(
      begin: const Offset(0, 0.18),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _controller.forward();

    _navigationTimer = Timer(
      const Duration(milliseconds: 2600),
          () {
        if (!mounted) return;

        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, animation, secondaryAnimation) =>
            const LoginPage(),
            transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
                ) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 350),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: Stack(
        children: [
          // Full-screen brand background
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF173D2B),
                    Color(0xFF102C20),
                  ],
                ),
              ),
            ),
          ),

          // Subtle decorative rings
          Positioned(
            top: -100,
            right: -100,
            child: _DecorativeCircle(
              size: 300,
              color: Colors.white.withValues(alpha: 0.035),
            ),
          ),
          Positioned(
            bottom: -120,
            left: -110,
            child: _DecorativeCircle(
              size: 340,
              color: AppColors.softGold.withValues(alpha: 0.07),
            ),
          ),

          // Main brand content
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  children: [
                    const Spacer(flex: 3),

                    ScaleTransition(
                      scale: _logoScale,
                      child: FadeTransition(
                        opacity: _fadeIn,
                        child: Container(
                          height: 116,
                          width: 116,
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: AppColors.cream,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.16),
                                blurRadius: 30,
                                offset: const Offset(0, 14),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            'assets/icon/clothes-hanger.png',
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) {
                              return const Icon(
                                Icons.checkroom_outlined,
                                size: 66,
                                color: AppColors.forestGreen,
                              );
                            },
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    SlideTransition(
                      position: _slideUp,
                      child: FadeTransition(
                        opacity: _fadeIn,
                        child: Column(
                          children: [
                            const Text(
                              'STYLE STORE',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 27,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 4.5,
                              ),
                            ),
                            const SizedBox(height: 13),

                            Container(
                              height: 2,
                              width: 42,
                              decoration: BoxDecoration(
                                color: AppColors.softGold,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),

                            const SizedBox(height: 16),

                            const Text(
                              'YOUR STYLE. YOUR STATEMENT.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.softGold,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 2.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const Spacer(flex: 3),

                    FadeTransition(
                      opacity: _fadeIn,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 1.8,
                              color: AppColors.softGold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'CRAFTED FOR YOUR EVERYDAY',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.62),
                              fontSize: 9,
                              letterSpacing: 1.8,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DecorativeCircle extends StatelessWidget {
  final double size;
  final Color color;

  const _DecorativeCircle({
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: color,
            width: 1.2,
          ),
        ),
      ),
    );
  }
}
