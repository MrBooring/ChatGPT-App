class ChatModel {
  final String content;
  final String role;

  ChatModel({required this.content, required this.role});

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      ChatModel(content: json['msg'], role: json['chatIndex']);

  Map<String, dynamic> toJson() => {
        'role': role,
        'content': content,
      };
}
