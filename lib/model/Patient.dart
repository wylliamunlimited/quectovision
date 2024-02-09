class Patient {
  final String name;
  final int age;
  final String gender;
  final double? weight; // in kg
  final double? height; // in cm

  Patient({
    required this.name,
    required this.age,
    required this.gender,
    this.weight = 0,
    this.height = 0,
  });
}
