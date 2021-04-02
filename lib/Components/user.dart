class OurUser {
  OurUser({
    this.uid,
    this.name,
  });

  factory OurUser.fromMap(Map<String, dynamic> data) {
    return OurUser(
        uid: data['id'], name: data['name']);
  }

  final String uid;
  final String name;
}