class MenSize {
  final String size;
  final bool isSelected;

  MenSize({
    required this.size,
    required this.isSelected,
  });

  Map<String, dynamic> toJson() => {
        "size": size,
        "isSelected": isSelected,
      };
  static MenSize fromJson(Map<String, dynamic> json) => MenSize(
        size: json['size'],
        isSelected: json['isSelected'],
      );
}
