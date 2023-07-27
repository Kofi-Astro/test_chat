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
    text = json['message'];
    createdAt = json['createdAt'];
  }
}
