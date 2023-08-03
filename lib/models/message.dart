class Message {
  String? id;
  String? userId;
  String? text;
  // String? createdAt;
  int? createdAt;
  bool? unread;

  Message({
    this.id,
    this.text,
    this.userId,
    this.createdAt,
  });

  Message.fromJson(Map<String, dynamic> json) {
    print("jsonMessage = $json");
    id = json['_id'];
    userId = json['userId'];
    text = json['text'];
    createdAt = json['createdAt'];
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

    return json;
  }
}
