class CallerInfo {
  String callerId;
  String name;
  String profilePic;

  CallerInfo({required this.callerId, required this.name, required this.profilePic});

  // Factory constructor to create a CallerInfo from a JSON map
  factory CallerInfo.fromJson(Map<String, dynamic> json) {
    return CallerInfo(
      callerId: json['callerId'],
      name: json['name'],
      profilePic: json['profilePic'],
    );
  }

  // Method to convert the CallerInfo instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'callerId': callerId,
      'name': name,
      'profilePic': profilePic,
    };
  }
}
