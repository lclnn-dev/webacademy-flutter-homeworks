import 'package:flutter/material.dart';

import '../design/app_spacing.dart';
import '../design/app_styles.dart';
import 'video_screen.dart';
import 'audio_screen.dart';


class Homework14Screen extends StatelessWidget {
  const Homework14Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multimedia', style: AppStyles.titleLarge(context)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  _buildNavigationButton(
                      context, 'Відео (локальне)', const VideoScreen()),
                  const SizedBox(height: 16),
                  _buildNavigationButton(
                      context, 'Аудіо (з мережі)', const AudioScreen()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButton(
      BuildContext context, String title, Widget screen) {

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ElevatedButton(
      onPressed: () =>
          Navigator.push(context, MaterialPageRoute(builder: (_) => screen)),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(AppSpacing.paddingDefault),
        backgroundColor: AppStyles.purpleButton,
      ),
      child: Text(title,
        style: isDark ? AppStyles.buttonDark(context) : AppStyles.buttonLight(context),
      ),
    );
  }
}
