import 'package:flutter/material.dart';
import 'package:hello_flutter/Features/Authentication/sign_in_screen.dart';
import 'package:hello_flutter/Theme/app_colors.dart';
import 'package:hello_flutter/components/bottom-navigation/bottom_navigation.dart';
import 'package:hello_flutter/screens/home/home_page.dart';
import 'package:hello_flutter/screens/home/Medical_history.dart';
import 'package:hello_flutter/screens/home/reminders.dart';
import 'package:hello_flutter/screens/settings/settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        scaffoldBackgroundColor: AppColors.scaffoldBackground,
      ),
      home: const SignInScreen(),
      routes: <String, WidgetBuilder>{
        '/sign-in': (context) => const SignInScreen(),
        '/home': (context) => const MainNavigation(),
      },
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomePage(),
    const MedicalHistory(),
    // Placeholder screens for other tabs
    Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: const Center(child: Text('Add Screen')),
    ),
    const RemindersScreen(),
    const SettingsScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: _buildBottomNavigation(context),
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
    final items = [
      BottomNavigationItem(icon: Icons.home, label: 'Home'),
      BottomNavigationItem(icon: Icons.history, label: 'History'),
      BottomNavigationItem(icon: Icons.add_circle, label: 'Add'),
      BottomNavigationItem(
        icon: Icons.notifications_outlined,
        label: 'Reminders',
      ),
      BottomNavigationItem(icon: Icons.settings, label: 'Settings'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: items,
      ),
    );
  }
}
