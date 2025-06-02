class AllLeadsList {
  String? status;
  String? message;
  List<Data>? data;

  AllLeadsList({this.status, this.message, this.data});

  AllLeadsList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? employeeId;
  int? teamLeadId;
  String? name;
  String? phone;
  String? email;
  String? dob;
  String? location;
  String? companyName;
  String? leadAmount;
  String? salary;
  int? successPercentage;
  String? expectedMonth;
  String? remarks;
  String? status;
  String? createdAt;
  String? updatedAt;
  Employee? employee;
  Employee? teamLead;

  Data(
      {this.id,
        this.employeeId,
        this.teamLeadId,
        this.name,
        this.phone,
        this.email,
        this.dob,
        this.location,
        this.companyName,
        this.leadAmount,
        this.salary,
        this.successPercentage,
        this.expectedMonth,
        this.remarks,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.employee,
        this.teamLead});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    teamLeadId = json['team_lead_id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    dob = json['dob'];
    location = json['location'];
    companyName = json['company_name'];
    leadAmount = json['lead_amount'];
    salary = json['salary'];
    successPercentage = json['success_percentage'];
    expectedMonth = json['expected_month'];
    remarks = json['remarks'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    employee = json['employee'] != null
        ? new Employee.fromJson(json['employee'])
        : null;
    teamLead = json['team_lead'] != null
        ? new Employee.fromJson(json['team_lead'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employee_id'] = this.employeeId;
    data['team_lead_id'] = this.teamLeadId;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['dob'] = this.dob;
    data['location'] = this.location;
    data['company_name'] = this.companyName;
    data['lead_amount'] = this.leadAmount;
    data['salary'] = this.salary;
    data['success_percentage'] = this.successPercentage;
    data['expected_month'] = this.expectedMonth;
    data['remarks'] = this.remarks;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.employee != null) {
      data['employee'] = this.employee!.toJson();
    }
    if (this.teamLead != null) {
      data['team_lead'] = this.teamLead!.toJson();
    }
    return data;
  }
}

class Employee {
  int? id;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? designation;
  Null? department;
  String? profilePhoto;
  String? address;
  Null? panCard;
  Null? aadharCard;
  Null? signature;
  Null? createdBy;
  int? teamLeadId;
  String? createdAt;
  String? updatedAt;

  Employee(
      {this.id,
        this.name,
        this.email,
        this.password,
        this.phone,
        this.designation,
        this.department,
        this.profilePhoto,
        this.address,
        this.panCard,
        this.aadharCard,
        this.signature,
        this.createdBy,
        this.teamLeadId,
        this.createdAt,
        this.updatedAt});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    designation = json['designation'];
    department = json['department'];
    profilePhoto = json['profile_photo'];
    address = json['address'];
    panCard = json['pan_card'];
    aadharCard = json['aadhar_card'];
    signature = json['signature'];
    createdBy = json['created_by'];
    teamLeadId = json['team_lead_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['designation'] = this.designation;
    data['department'] = this.department;
    data['profile_photo'] = this.profilePhoto;
    data['address'] = this.address;
    data['pan_card'] = this.panCard;
    data['aadhar_card'] = this.aadharCard;
    data['signature'] = this.signature;
    data['created_by'] = this.createdBy;
    data['team_lead_id'] = this.teamLeadId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}