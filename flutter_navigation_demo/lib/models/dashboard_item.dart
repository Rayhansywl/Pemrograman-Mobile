class DashboardItem {
  final int id;
  final String title;
  final String description;

  DashboardItem({
    required this.id,
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
      };

  factory DashboardItem.fromJson(Map<String, dynamic> json) => DashboardItem(
        id: json['id'],
        title: json['title'],
        description: json['description'],
      );
}

class DetailsResult {
  final bool delete;
  final DashboardItem? editedItem;
  DetailsResult({required this.delete, this.editedItem});
}
