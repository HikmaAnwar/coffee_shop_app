import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import 'login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive sizing
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Padding(
          // Responsive horizontal padding (6% of screen width, clamped between 16 and 32)
          padding: EdgeInsets.symmetric(
            horizontal: (screenWidth * 0.06).clamp(16, 32),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // "Welcome to" aligned to the left
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Welcome to',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: (screenWidth * 0.05).clamp(
                      16,
                      22,
                    ), // Responsive font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: (screenHeight * 0.01).clamp(8, 12),
              ), // Responsive spacing
              // "CupfulCanvas" centered
              Align(
                alignment: Alignment.center,
                child: Text(
                  'CupfulCanvas',
                  style: GoogleFonts.dancingScript(
                    textStyle: TextStyle(
                      color: AppColors.primary,
                      fontSize: (screenWidth * 0.14).clamp(
                        40,
                        60,
                      ), // Responsive font size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: (screenHeight * 0.005).clamp(4, 8),
              ), // Responsive spacing
              // "Sip. Smile. Create." aligned to the right
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Sip. Smile. Create.',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: (screenWidth * 0.045).clamp(
                      14,
                      20,
                    ), // Responsive font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: (screenHeight * 0.04).clamp(24, 40),
              ), // Responsive spacing
              // Coffee cup image
              Image.asset(
                'assets/images/front.png',
                height: (screenHeight * 0.4).clamp(
                  300,
                  450,
                ), // Responsive image height
                fit: BoxFit.contain,
              ),
              SizedBox(
                height: (screenHeight * 0.06).clamp(32, 56),
              ), // Responsive spacing
              // Get Started button
              SizedBox(
                width: (screenWidth * 0.75).clamp(
                  250,
                  350,
                ), // Responsive button width
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: (screenHeight * 0.02).clamp(
                        12,
                        18,
                      ), // Responsive vertical padding
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: (screenWidth * 0.045).clamp(
                        16,
                        20,
                      ), // Responsive font size
                      fontWeight: FontWeight.bold,
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
