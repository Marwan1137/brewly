// Responsive and Adaptive Onboarding Screen
import 'package:brewly/Presentation/Screens/auth/signin_screen/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = PageController();
  int currentPage = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget buildPage({
    required BuildContext context,
    required Color color,
    required String title,
    required String subtitle,
    required String imageUrl,
  }) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Container(
      color: color,
      padding: EdgeInsets.symmetric(horizontal: width * 0.07),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              flex: 6,
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    imageUrl,
                    height: height * 0.5,
                    width: width * 0.85,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: height * 0.5,
                        width: width * 0.85,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Icon(
                          Icons.image_not_supported,
                          size: 60,
                          color: Colors.grey[600],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.04),
            Flexible(
              flex: 3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: (width * 0.065).clamp(20.0, 32.0),
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: (width * 0.045).clamp(14.0, 20.0),
                        color: Colors.grey[700],
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.12),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bottomSheetHeight = size.height * 0.1;
    final buttonWidth = size.width * 0.2;

    return Scaffold(
      body: PageView(
        controller: controller,
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });
        },
        children: [
          buildPage(
            context: context,
            color: Colors.brown[50]!,
            title: 'Welcome to Brewly',
            subtitle:
                'Discover the world of coffee and explore your favorite flavors from every corner of the globe.',
            imageUrl: 'assets/onboarding/onboarding1.jpeg',
          ),
          buildPage(
            context: context,
            color: Colors.brown[50]!,
            title: 'Track Your Coffee Journey',
            subtitle:
                'Keep track of your favorite coffees, brewing methods, and taste notes to brew the perfect cup every time.',
            imageUrl: 'assets/onboarding/onboarding2.jpeg',
          ),
          buildPage(
            context: context,
            color: Colors.brown[50]!,
            title: 'Brew Your Perfect Cup',
            subtitle:
                "Let's start your coffee adventure and explore new flavors, cafés, and brewing tips!",
            imageUrl: 'assets/onboarding/onboarding2.jpg',
          ),
        ],
      ),
      bottomSheet: Container(
        color: Colors.brown[50],
        height: bottomSheetHeight.clamp(70.0, 100.0),
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
          vertical: size.height * 0.01,
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Skip Button
              SizedBox(
                width: buttonWidth.clamp(70.0, 100.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInScreen(),
                    ),
                  ),
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: (size.width * 0.035).clamp(12.0, 16.0),
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              // Page Indicator
              SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: SwapEffect(
                  dotHeight: (size.width * 0.03).clamp(10.0, 14.0),
                  dotWidth: (size.width * 0.03).clamp(10.0, 14.0),
                  spacing: size.width * 0.015,
                  dotColor: Colors.grey.shade400,
                  activeDotColor: Colors.brown,
                ),
              ),

              // Next / Start Button
              SizedBox(
                width: buttonWidth.clamp(70.0, 100.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: currentPage == 2
                        ? const Color.fromARGB(255, 156, 88, 6)
                        : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    if (currentPage == 2) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInScreen(),
                        ),
                      );
                    } else {
                      controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text(
                    currentPage == 2 ? 'Start' : 'Next',
                    style: TextStyle(
                      fontSize: (size.width * 0.035).clamp(12.0, 16.0),
                      fontWeight: FontWeight.w600,
                      color: currentPage == 2 ? Colors.white : Colors.black,
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
