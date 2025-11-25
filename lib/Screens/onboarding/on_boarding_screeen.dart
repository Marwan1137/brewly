// ignore_for_file: must_be_immutable

import 'package:brewly/Screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreeen extends StatefulWidget {
  const OnBoardingScreeen({super.key});

  @override
  State<OnBoardingScreeen> createState() => _OnBoardingScreeenState();
}

class _OnBoardingScreeenState extends State<OnBoardingScreeen> {
  final controller = PageController();

  int currentPage = 0;

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Widget buildPage({
    required Color color,
    required String title,
    required String subtitle,
    required String imageUrl,
  }) {
    return Container(
      color: color,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(
              imageUrl,
              height: 400,
              width: 500,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 40),
          Text(
            title,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 18, color: Colors.white70),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 100), // leave space for bottom sheet
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 80),
        child: PageView(
          onPageChanged: (index) {
            setState(() {
              currentPage = index; // update the current page
            });
          },
          controller: controller,
          children: [
            buildPage(
              color: Colors.brown.shade400,
              title: 'Welcome to Brewly',
              subtitle:
                  'Discover the world of coffee and explore your favorite flavors from every corner of the globe.',
              imageUrl: 'assets/onboarding/onboarding1.jpeg',
            ),

            buildPage(
              color: Colors.brown.shade400,
              title: 'Track Your Coffee Journey',
              subtitle:
                  'Keep track of your favorite coffees, brewing methods, and taste notes to brew the perfect cup every time.',
              imageUrl: 'assets/onboarding/onboarding2.jpeg',
            ),
            buildPage(
              color: Colors.brown.shade400,
              title: 'Brew Your Perfect Cup',
              subtitle:
                  'Let’s start your coffee adventure and explore new flavors, cafés, and brewing tips!',
              imageUrl: 'assets/onboarding/onboarding2.jpg',
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: Colors.brown.shade400,
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 80,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white60,
                ),
                child: TextButton(
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  ),
                  child: Text(
                    'Skip',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
              ),
              Center(
                child: SmoothPageIndicator(
                  onDotClicked: (index) => controller.animateToPage(
                    index,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  ),
                  controller: controller,
                  count: 3,

                  effect: SwapEffect(
                    dotHeight: 12,
                    dotWidth: 12,
                    dotColor: Colors.white54,
                    activeDotColor: Colors.white,
                  ),
                ),
              ),
              Container(
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white60,
                ),
                child: TextButton(
                  onPressed: () => (currentPage == 2)
                      ? Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        )
                      : controller.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        ),
                  child: Text(
                    currentPage == 2 ? 'Start' : 'Next',
                    style: TextStyle(fontSize: 14, color: Colors.black),
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
