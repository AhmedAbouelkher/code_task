class UserProblemsResponse {
  UserProblemsResponse({
    required this.problems,
  });

  final List<Problem> problems;

  factory UserProblemsResponse.fromJson(Map<String, dynamic> json) => UserProblemsResponse(
        problems: List<Problem>.from(json["problems"].map((x) => Problem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "problems": List<dynamic>.from(problems.map((x) => x.toJson())),
      };
}

class Problem {
  Problem({
    required this.diabetes,
  });

  final List<Diabetes> diabetes;

  factory Problem.fromJson(Map<String, dynamic> json) => Problem(
        diabetes: List<Diabetes>.from(json["Diabetes"].map((x) => Diabetes.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Diabetes": List<dynamic>.from(diabetes.map((x) => x.toJson())),
      };
}

class Diabetes {
  Diabetes({
    required this.medications,
    required this.labs,
  });

  final List<Medication> medications;
  final List<Lab> labs;

  factory Diabetes.fromJson(Map<String, dynamic> json) => Diabetes(
        medications: List<Medication>.from(json["medications"].map((x) => Medication.fromJson(x))),
        labs: List<Lab>.from(json["labs"].map((x) => Lab.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "medications": List<dynamic>.from(medications.map((x) => x.toJson())),
        "labs": List<dynamic>.from(labs.map((x) => x.toJson())),
      };
}

class Lab {
  Lab({
    required this.missingField,
  });

  final String missingField;

  factory Lab.fromJson(Map<String, dynamic> json) => Lab(
        missingField: json["missing_field"],
      );

  Map<String, dynamic> toJson() => {
        "missing_field": missingField,
      };
}

class Medication {
  Medication({
    required this.name,
    required this.dose,
    required this.strength,
  });

  final String name;
  final String dose;
  final String strength;

  factory Medication.fromJson(Map<String, dynamic> json) => Medication(
        name: json["name"],
        dose: json["dose"],
        strength: json["strength"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "dose": dose,
        "strength": strength,
      };
}
