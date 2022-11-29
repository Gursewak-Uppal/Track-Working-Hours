class TaskData {
  TaskData({
    required this.id,
    required this.startAt,
    required this.endAt,
  });

  String? id;
  DateTime startAt;
  DateTime endAt;

  factory TaskData.fromMap(Map<String, dynamic> json) => TaskData(
        id: json["id"],
        startAt: json["start_at"],
        endAt: json["end_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "start_at": startAt,
        "end_at": endAt,
      };
}
