// ignore_for_file: public_member_api_docs, sort_constructors_first

class FriendRequest {
  final String senderId;
  final String receiverId;
  final String senderName;
  final String receiverName;
  final String senderPhotoUrl;
  final String receiverPhotoUrl;

  const FriendRequest({
    required this.senderId,
    required this.receiverId,
    required this.senderName,
    required this.receiverName,
    required this.senderPhotoUrl,
    required this.receiverPhotoUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'senderName': senderName,
      'receiverName': receiverName,
      'senderPhotoUrl': senderPhotoUrl,
      'receiverPhotoUrl':receiverPhotoUrl,
    };
  }
  // Phương thức từJson để chuyển đổi một map thành một đối tượng FriendRequest
  static FriendRequest fromJson(Map<String, dynamic> json) {
    return FriendRequest(
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      senderName: json['senderName'],
      receiverName: json['receiverName'],
      senderPhotoUrl: json['senderPhotoUrl'],
      receiverPhotoUrl: json['receiverPhotoUrl'],
    );
  }
  
}
