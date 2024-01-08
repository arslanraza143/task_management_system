enum UserRole { Admin, Manager, User }

class AppUser  {
  late String id;
  late String email;
  late String phone;
  late UserRole role;

  AppUser ({required this.id, required this.email, required this.phone, required this.role});
}
