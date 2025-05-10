import 'package:final_project/pages/site_pages/fitness_level.dart';
import 'package:final_project/pages/site_pages/health_goal.dart';
import 'package:final_project/pages/site_pages/user_information.dart';
import 'package:flutter/material.dart';

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
            child: PageView(
              controller: _controller,
              children: const [
                UserInformation(),
                FitnessLevel(),
                HealthGoal(),
              ],
            ),
          )
        ],
      ),
    );
  }
}