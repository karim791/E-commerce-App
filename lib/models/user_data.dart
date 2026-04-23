
class UserData {
  final String userId;
  final String username;
  final String email;
  final String createAt;

  UserData({
    required this.userId,
    required this.username,
    required this.email,
    required this.createAt,
  });
 
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'username': username,
      'email': email,
      'createAt': createAt,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      userId: map['userId'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      createAt: map['createAt'] as String,
    );
  }

}
