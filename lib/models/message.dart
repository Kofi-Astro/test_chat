class Message {
  String? id;
  String? userId;
  String? text;
  String? createdAt;

  Message({
    this.id,
    this.text,
    this.userId,
    this.createdAt,
  });

  Message.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userId = json['userId'];
    text = json['text'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['_id'] = id;
    json['userId'] = userId;
    json['text'] = text;
    json['createdAt'] = createdAt;

    return json;
  }
}
