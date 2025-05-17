class FlareCluster {
  final DateTime start;
  final DateTime end;
  final int duration;

  FlareCluster({
    required this.start,
    required this.end,
    required this.duration,
  });

  factory FlareCluster.fromJson(Map<String, dynamic> json) {
    return FlareCluster(
      start: DateTime.parse(json['start']),
      end: DateTime.parse(json['end']),
      duration: json['duration'],
    );
  }
}
