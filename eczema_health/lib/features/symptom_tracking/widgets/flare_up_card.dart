import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:eczema_health/data/models/analysis_models.dart';

class FlareUpCard extends StatelessWidget {
  final FlareCluster? currentFlare;
  final FlareCluster? lastFlare;
  final bool isActiveFlare;

  const FlareUpCard({
    Key? key,
    this.currentFlare,
    this.lastFlare,
    this.isActiveFlare = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (isActiveFlare && currentFlare != null) {
      // We have an active flare
      return _buildActiveFlare(context, currentFlare!);
    } else if (lastFlare != null) {
      // No active flare but we have a previous one
      return _buildLastFlare(context, lastFlare!);
    } else {
      // No flares yet
      return _buildNoFlares(context);
    }
  }

  Widget _buildActiveFlare(BuildContext context, FlareCluster flare) {
    final now = DateTime.now();
    final daysActive = now.difference(flare.start).inDays;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'ACTIVE FLARE',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              const Spacer(),
              Icon(Icons.error_outline, color: Colors.red.shade400),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Eczema Flare Active',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildInfoItem(
                context,
                'Duration',
                '$daysActive days',
                Icons.timelapse,
              ),
              const SizedBox(width: 16),
              _buildInfoItem(
                context,
                'Severity',
                'High',
                Icons.warning_amber_rounded,
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLastFlare(BuildContext context, FlareCluster flare) {
    final daysSince = DateTime.now().difference(flare.end).inDays;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'RECOVERED',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              const Spacer(),
              Icon(Icons.check_circle_outline, color: Colors.green.shade400),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '$daysSince days since last flare-up',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Last flare ended on ${DateFormat('MMMM d, yyyy').format(flare.end)}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildInfoItem(
                context,
                'Last Duration',
                '${flare.duration} days',
                Icons.timelapse,
              ),
              const SizedBox(width: 16),
              _buildInfoItem(
                context,
                'Current Status',
                'Healthy',
                Icons.favorite,
                color: Colors.green,
              ),
            ],
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () {
              // Navigate to prevention tips
            },
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 44),
            ),
            child: const Text('View Prevention Tips'),
          ),
        ],
      ),
    );
  }

  Widget _buildNoFlares(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'No Flare-Ups Detected',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Keep tracking your symptoms to identify flare patterns',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () {
              // Navigate to symptom tracking
            },
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 44),
            ),
            child: const Text('Start Tracking Symptoms'),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(
    BuildContext context,
    String label,
    String value,
    IconData icon, {
    Color color = Colors.blue,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
