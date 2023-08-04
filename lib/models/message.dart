class Message {
  String? id;
  String? userId;
  String? text;
  // String? createdAt;
  int? createdAt;
  // bool? unread;
  bool? unreadByHigherIdUser;
  bool? unreadByLowerIdUser;
  bool? unreadByMe;
  bool? unreadByOtherUser;

  Message(
      {this.id,
      this.text,
      this.userId,
      this.createdAt,
      this.unreadByMe,
      this.unreadByOtherUser});

  Message.fromJson(Map<String, dynamic> json) {
    print("jsonMessage = $json");
    id = json['_id'];
    userId = json['userId'];
    text = json['text'];
    createdAt = json['createdAt'];
    unreadByHigherIdUser = json['unreadByHigherIdUser'] ?? false;
    unreadByLowerIdUser = json['unreadByLowerIdUser'] ?? false;
    unreadByMe = json['unreadByMe'] ?? true;
    unreadByOtherUser = json['unreadByOtherUser'] ?? false;
  }

  // factory Message.fromJson(Map<String, dynamic> json) {
  //   var message = Message(id: );
  // }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['_id'] = id;
    json['userId'] = userId;
    json['text'] = text;
    json['createdAt'] = createdAt;
    json['unreadByLowerIdUser'] = unreadByLowerIdUser ?? false;
    json['unreadByHigherIdUser'] = unreadByHigherIdUser ?? false;
    json['unreadByMe'] = unreadByMe ?? false;
    json['unreadByOtherUser'] = unreadByOtherUser ?? false;

    return json;
  }
}
