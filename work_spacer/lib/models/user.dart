enum Role{
  Senior,
  OfficeAdministrator,
  Executive,
  Mid,
  Junior,
  Intern
}

class User {

  final String name;
  final String surname;
  Role role;

  User({
    required this.name,
    required this.surname,
    required this.role
  });
}