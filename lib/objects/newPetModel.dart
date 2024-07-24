class NewPet {
  String userLogin;
  String petName;
  String type;
  String petAge;
  String petGender;
  List<String> colors;
  String breed;
  String petSize;
  String bio;
  String prompt1;
  String prompt2;
  String contactEmail;
  String location;
  List<String> images;
  String adoptionFee;

  NewPet({
    this.userLogin = '',
    this.petName = '',
    this.type = '',
    this.petAge = '',
    this.petGender = '',
    this.colors = const ['', '', ''],
    this.breed = '',
    this.petSize = '',
    this.bio = '',
    this.prompt1 = '',
    this.prompt2 = '',
    this.contactEmail = '',
    this.location = '',
    this.images = const ['', '', ''],
    this.adoptionFee = '',
  });

  // Convert a NewPet object into a Map object
  Map<String, dynamic> toJson() {
    return {
      'userLogin': userLogin,
      'petName': petName,
      'type': type,
      'petAge': petAge,
      'petGender': petGender,
      'colors': colors,
      'breed': breed,
      'petSize': petSize,
      'bio': bio,
      'prompt1': prompt1,
      'prompt2': prompt2,
      'contactEmail': contactEmail,
      'location': location,
      'images': images,
      'adoptionFee': adoptionFee,
    };
  }

  // Create a NewPet object from a Map object
  factory NewPet.fromJson(
      Map<String, dynamic> json) {
    return NewPet(
      userLogin: json['userLogin'] ?? '',
      petName: json['petName'] ?? '',
      type: json['type'] ?? '',
      petAge: json['petAge'] ?? '',
      petGender: json['petGender'] ?? '',
      colors: json['colors'] != null
          ? List<String>.from(json['colors'])
          : ['', '', ''],
      breed: json['breed'] ?? '',
      petSize: json['petSize'] ?? '',
      bio: json['bio'] ?? '',
      prompt1: json['prompt1'] ?? '',
      prompt2: json['prompt2'] ?? '',
      contactEmail: json['contactEmail'] ?? '',
      location: json['location'] ?? '',
      images: json['images'] != null
          ? List<String>.from(json['images'])
          : ['', '', ''],
      adoptionFee: json['adoptionFee'] ?? '',
    );
  }
}
