class AllTaskList {
  String? status;
  String? message;
  List<Data>? data; // List of tasks

  AllTaskList({this.status, this.message, this.data});

  AllTaskList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};
    dataMap['status'] = status;
    dataMap['message'] = message;
    if (data != null) {
      dataMap['data'] = data!.map((v) => v.toJson()).toList();
    }
    return dataMap;
  }
}

class Data {
  int? id;
  int? teamLeadId;
  int? employeeId;
  String? title;
  String? description;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? progress;
  String? priority;
  String? activityTimeline;
  String? assignedDate;
  String? dueDate;
  String? attachments;
  Employee? employee;
  Employee? teamLead;

  Data(
      {this.id,
        this.teamLeadId,
        this.employeeId,
        this.title,
        this.description,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.progress,
        this.priority,
        this.activityTimeline,
        this.assignedDate,
        this.dueDate,
        this.attachments,
        this.employee,
        this.teamLead});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    teamLeadId = json['team_lead_id'];
    employeeId = json['employee_id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    progress = json['progress'];
    priority = json['priority'];
    activityTimeline = json['activity_timeline'];
    assignedDate = json['assigned_date'];
    dueDate = json['due_date'];
    attachments = json['attachments'];
    employee = json['employee'] != null ? Employee.fromJson(json['employee']) : null;
    teamLead = json['team_lead'] != null ? Employee.fromJson(json['team_lead']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};
    dataMap['id'] = id;
    dataMap['team_lead_id'] = teamLeadId;
    dataMap['employee_id'] = employeeId;
    dataMap['title'] = title;
    dataMap['description'] = description;
    dataMap['status'] = status;
    dataMap['created_at'] = createdAt;
    dataMap['updated_at'] = updatedAt;
    dataMap['progress'] = progress;
    dataMap['priority'] = priority;
    dataMap['activity_timeline'] = activityTimeline;
    dataMap['assigned_date'] = assignedDate;
    dataMap['due_date'] = dueDate;
    dataMap['attachments'] = attachments;
    if (employee != null) dataMap['employee'] = employee!.toJson();
    if (teamLead != null) dataMap['team_lead'] = teamLead!.toJson();
    return dataMap;
  }
}

class Employee {
  int? id;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? designation;
  dynamic department;
  String? profilePhoto;
  String? address;
  dynamic panCard;
  dynamic aadharCard;
  dynamic signature;
  dynamic createdBy;
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
    final Map<String, dynamic> dataMap = {};
    dataMap['id'] = id;
    dataMap['name'] = name;
    dataMap['email'] = email;
    dataMap['password'] = password;
    dataMap['phone'] = phone;
    dataMap['designation'] = designation;
    dataMap['department'] = department;
    dataMap['profile_photo'] = profilePhoto;
    dataMap['address'] = address;
    dataMap['pan_card'] = panCard;
    dataMap['aadhar_card'] = aadharCard;
    dataMap['signature'] = signature;
    dataMap['created_by'] = createdBy;
    dataMap['team_lead_id'] = teamLeadId;
    dataMap['created_at'] = createdAt;
    dataMap['updated_at'] = updatedAt;
    return dataMap;
  }
}
