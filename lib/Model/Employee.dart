class Employee {
  final int id;
  final String EmployeeNumber;
  final String Name;
  final String Designation;
  final String Nationality;
  final String Project;
  final String ContactNumber;
  final String Landline;
  final String EmailAddress;
  final String JoiningDate;
  final String GlobalNumber;

  Employee({
    this.id,
    this.Name,
    this.Designation,
    this.Nationality,
    this.Project,
    this.ContactNumber,
    this.Landline,
    this.EmailAddress,
    this.JoiningDate,
    this.EmployeeNumber,
    this.GlobalNumber,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      Name: json['name'],
      Designation: json['designation'],
      Nationality: json['nationality'],
      Project: json['project'],
      ContactNumber: json['contactNumber'],
      Landline: json['landline'],
      EmailAddress: json['emailAddress'],
      JoiningDate: json['joiningDate'],
      EmployeeNumber: json['employeeNumber'],
      GlobalNumber: json['globalNumber'],
    );
  }

  Map<String, dynamic> toJson() => {
        // 'id': id,
        'name': Name,
        'designation': Designation,
        'nationality': Nationality,
        'project': Project,
        'contactNumber': ContactNumber,
        'landline': Landline,
        'emailAddress': EmailAddress,
        'joiningDate': JoiningDate,
        'employeeNumber': EmployeeNumber,
        'globalNumber': GlobalNumber,
      };
}
