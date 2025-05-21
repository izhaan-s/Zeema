import 'package:flutter/material.dart';

class LifestyleLogScreen extends StatelessWidget {
  const LifestyleLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lifestyle Tracking',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Illustration or icon
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Icon(
                Icons.food_bank_outlined,
                size: 80,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 32),
            // Coming soon text
            Text(
              'Coming Soon',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
            ),
            const SizedBox(height: 16),
            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Track diet, hydration, sleep, and stress to identify potential triggers.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.grey[600],
                      height: 1.4,
                    ),
              ),
            ),
            const SizedBox(height: 48),
            // Preview of features
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  _buildFeatureRow(
                    context,
                    Icons.water_drop_outlined,
                    'Hydration Tracking',
                  ),
                  const SizedBox(height: 16),
                  _buildFeatureRow(
                    context,
                    Icons.bedtime_outlined,
                    'Sleep Quality Monitoring',
                  ),
                  const SizedBox(height: 16),
                  _buildFeatureRow(
                    context,
                    Icons.restaurant_outlined,
                    'Food & Diet Logging',
                  ),
                  const SizedBox(height: 16),
                  _buildFeatureRow(
                    context,
                    Icons.mood_outlined,
                    'Stress Level Assessment',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureRow(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: Colors.grey[600],
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[700],
              ),
        ),
      ],
    );
  }
}
