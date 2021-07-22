import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:code_task/Controllers/controllers.dart';

void main() {
  test("Parsing and Modeling user diagnoses network response", () {
    final decodedJSON = jsonDecode(_rawResponse);
    expect(decodedJSON, isA<Map<String, dynamic>>());

    final model = UserProblemsResponse.fromJson(decodedJSON);
    expect(model.problems, isNotEmpty);
    expect(model.problems.first.diabetes, isNotEmpty);

    final firstDrug = model.problems.first.diabetes.first.medications.first;
    expect(firstDrug.name, "Gilenya");
    expect(firstDrug.strength, "500 mg");
  });
}

String _rawResponse = '''
{
    "problems": [
        {
            "Diabetes": [
                {
                    "medications": [
                        {
                            "name": "Gilenya",
                            "dose": "",
                            "strength": "500 mg"
                        },
                        {
                            "name": "Brilinta",
                            "dose": "",
                            "strength": "200 mg"
                        },
                        {
                            "name": "Asprin",
                            "dose": "",
                            "strength": "50 mg"
                        },
                        {
                            "name": "Naproxen",
                            "dose": "",
                            "strength": "400 mg"
                        }
                    ],
                    "labs": [
                        {
                            "missing_field": "missing_value"
                        }
                    ]
                }
            ]
        }
    ]
}
''';
