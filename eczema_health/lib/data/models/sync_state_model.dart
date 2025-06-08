class SyncStateModel {
  final String userId;
  final String entityName;
  final int rowId;
  final String operation;
  final DateTime lastUpdatedAt;
  final DateTime lastSynced;
  final int retryCount;
  final String error;

  SyncStateModel({
    required this.userId,
    required this.entityName,
    required this.rowId,
    required this.operation,
    required this.lastUpdatedAt,
    required this.lastSynced,
    required this.retryCount,
    required this.error,
  });
}
