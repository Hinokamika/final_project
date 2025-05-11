import 'package:final_project/pages/site_pages/fitness_level.dart';
import 'package:final_project/pages/site_pages/health_goal.dart';
import 'package:final_project/pages/site_pages/user_information.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class UserInfoPage extends StatelessWidget {
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 900,
            child: PageView(
              controller: _controller,
              children: const [
                UserInformation(),
                FitnessLevel(),
                HealthGoal(),
              ],
            ),
          ),

          SmoothPageIndicator(controller: _controller, count: 3,
            effect: const WormEffect(
              activeDotColor: Color(0xFFFF3333),
              dotHeight: 10,
              dotWidth: 10,
              spacing: 16,
            ),
          ),
        ],
      ),
    );
  }
}