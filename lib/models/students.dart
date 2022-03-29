class Students {
  late final int id;
  late final String name;
  late final int age;

  Students({required this.id, required this.name, required this.age});

  factory Students.fromJson(Map<String, dynamic> json) {
    return Students(
      id: json['id'],
      name: json['name'],
      age: json['age'],
    );
  }

  Map<String, dynamic> toJson() => {'name': name, 'age': age};
}
