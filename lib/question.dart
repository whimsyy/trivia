import 'dart:convert';

import 'package:flutter/foundation.dart';

class Question {
  String id;
  String question;
  List<String> options;
  String answer;
  Question({
    this.id,
    this.question,
    this.options,
    this.answer,
  });

  Question copyWith({
    String id,
    String question,
    List<String> options,
    String answer,
  }) {
    return Question(
      id: id ?? this.id,
      question: question ?? this.question,
      options: options ?? this.options,
      answer: answer ?? this.answer,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'options': options,
      'answer': answer,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['\$id'],
      question: map['question'],
      options: List<String>.from(map['options']),
      answer: map['answer'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) => Question.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Question(id: $id, question: $question, options: $options, answer: $answer)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Question &&
      other.id == id &&
      other.question == question &&
      listEquals(other.options, options) &&
      other.answer == answer;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      question.hashCode ^
      options.hashCode ^
      answer.hashCode;
  }
}


getCsv() async {

 //create an element rows of type list of list. All the above data set are stored in associate list
//Let associate be a model class with attributes name,gender and age and associateList be a list of associate model class.


 List<List<dynamic>> rows = List<List<dynamic>>();
  for (int i = 0; i <associateList.length;i++) {

//row refer to each column of a row in csv file and rows refer to each row in a file
    List<dynamic> row = List();
    row.add(associateList[i].name);
    row.add(associateList[i].gender);
    row.add(associateList[i].age);
    rows.add(row);
  }

 await SimplePermissions.requestPermission(Permission. WriteExternalStorage);
  bool checkPermission=await SimplePermissions.checkPermission(Permission.WriteExternalStorage);
  if(checkPermission) {

//store file in documents folder

    String dir = (await getExternalStorageDirectory()).absolute.path + "/documents";
    file = "$dir";
    print(LOGTAG+" FILE " + file);
    File f = new File(file+"filename.csv");

// convert rows to String and write as csv file

    String csv = const ListToCsvConverter().convert(rows);
    f.writeAsString(csv);
  }


}
