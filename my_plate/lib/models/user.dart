class Users {
  String id;
  String name;
  String email;
  String password;

  Users(

      {required this.email, required this.id, required this.name, required this.password});

  Users.fromMap(Map <String, dynamic> snapshot,String id) :
        id = id,
        email = snapshot['email'] ?? '',
        name = snapshot['name'] ?? '',
        password = snapshot['password'] ?? '';


}