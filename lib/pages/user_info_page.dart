import 'package:final_project/pages/register_login_pages/authentication_page.dart';
import 'package:final_project/pages/site_pages/fitness_level.dart';
import 'package:final_project/pages/site_pages/health_goal.dart';
import 'package:final_project/pages/site_pages/user_information.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({Key? key}) : super(key: key);

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[200],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: (() {
              // Check if keyboard is visible
              bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
              
              // If keyboard is visible, use reduced height
              if (isKeyboardVisible) {
              return screenHeight * 0.57;
              }
              
              // Check orientation
              bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
              
              // Normal size when keyboard isn't visible
              if (isPortrait) {
              return screenHeight * 0.90;
              } else {
              // Landscape mode
              return screenHeight * 0.8;
              }
            })(),
            child: PageView(
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),  // ← disable swipe
              children: [
                UserInformation(controller: _controller),
                FitnessLevel(controller: _controller),
                HealthGoal(controller: _controller),
                AuthenticationPage(controller: _controller),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
