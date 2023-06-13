import 'dart:convert';

class Student {
  int rollNo;
  double fee;
  String name;

  Student({
    required this.rollNo,
    required this.fee,
    required this.name,
  });
  /*
      The copyWith method creates a new Student object
   */
  Student copyWith({
    int? rollNo,
    double? fee,
    String? name,
  }) {
    return Student(
      rollNo: rollNo ?? this.rollNo,
      fee: fee ?? this.fee,
      name: name ?? this.name,
    );
  }

  /*
     The toMap method converts the Student object
      into a map representation.
   */
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rollNo': rollNo,
      'fee': fee,
      'name': name,
    };
  }

  /*
      The fromMap factory method creates a Student object from a map representation, where the property values are retrieved from the map using the corresponding keys.
   */
  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      rollNo: map['rollNo'] as int,
      fee: map['fee'] as double,
      name: map['name'] as String,
    );
  }

  /*
     The toJson method converts the Student object 
     into a JSON string representation
      using the json.encode function.
   */
  String toJson() => json.encode(toMap());
   
   /*
     The fromJson factory method creates a Student object
      from a JSON string representation, where the JSON string
       is first decoded using the json.decode function.
    */
  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source) as Map<String, dynamic>);
    
    /*
      The toString method provides a string representation 
      of the Student object, displaying the property values.
     */
  @override
  String toString() =>
      'StudentModelClass(rollNo: $rollNo, fee: $fee, name: $name)';

  @override
  bool operator ==(covariant Student other) {
    if (identical(this, other)) return true;

    return other.rollNo == rollNo && other.fee == fee && other.name == name;
  }

  @override
  int get hashCode => rollNo.hashCode ^ fee.hashCode ^ name.hashCode;
}
