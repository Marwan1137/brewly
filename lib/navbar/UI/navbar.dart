import 'package:brewly/Screens/coffee_beans_types/coffee_beans_types_screen.dart';
import 'package:brewly/Screens/explore_screen.dart';
import 'package:brewly/Screens/favourites_screen.dart';
import 'package:brewly/Screens/home_screen/home_screen.dart';
import 'package:brewly/Screens/profile_screen.dart';
import 'package:brewly/Screens/quiz_screen.dart';
import 'package:brewly/navbar/logic/cubit/nav_bar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavbarUi extends StatelessWidget {
  NavbarUi({super.key});
  final List<Widget> pages = [
    const HomeScreen(),
    const ExploreScreen(),
    const QuizScreen(),
    const FavouritesScreen(),
    const ProfileScreen(),
    const CoffeeBeansTypesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBarCubit, NavBarState>(
      builder: (context, state) {
        NavBarCubit cubitNavBar = context.read<NavBarCubit>();
        return Scaffold(
          body: pages[cubitNavBar.currentIndex],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  spreadRadius: 0,
                  blurRadius: 10,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                child: BottomNavigationBar(
                  currentIndex: cubitNavBar.currentIndex,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  selectedItemColor: const Color.fromARGB(255, 200, 124, 64),
                  unselectedItemColor: Colors.grey[400],
                  selectedFontSize: 12,
                  unselectedFontSize: 12,
                  items: [
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/navbarIcons/Home.png',
                        height: 24,
                        width: 24,
                        color: Colors.grey[400],
                      ),
                      activeIcon: Image.asset(
                        'assets/navbarIcons/Home_filled.png',
                        height: 24,
                        width: 24,
                        color: const Color.fromARGB(255, 200, 124, 64),
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/navbarIcons/explore.png',
                        height: 24,
                        width: 24,
                        color: Colors.grey[400],
                      ),
                      activeIcon: Image.asset(
                        'assets/navbarIcons/explore_filled.png',
                        height: 24,
                        width: 24,
                        color: const Color.fromARGB(255, 200, 124, 64),
                      ),
                      label: 'Explore',
                    ),
                    BottomNavigationBarItem(
                      icon: CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        radius: 24,
                        child: Icon(
                          Icons.quiz_outlined,
                          color: Colors.grey[400],
                        ),
                      ),
                      activeIcon: CircleAvatar(
                        backgroundColor: Colors.black87,
                        radius: 24,
                        child: const Icon(
                          Icons.quiz,
                          color: Color.fromARGB(255, 200, 124, 64),
                        ),
                      ),
                      label: 'Take Quiz',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/navbarIcons/favourites.png',
                        height: 24,
                        width: 24,
                        color: Colors.grey[400],
                      ),
                      activeIcon: Image.asset(
                        'assets/navbarIcons/favourites_filled.png',
                        height: 24,
                        width: 24,
                        color: const Color.fromARGB(255, 200, 124, 64),
                      ),
                      label: 'Favourites',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person_outline),
                      activeIcon: Icon(Icons.person),
                      label: 'Profile',
                    ),
                  ],
                  onTap: (index) {
                    cubitNavBar.changeIndex(index);
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
