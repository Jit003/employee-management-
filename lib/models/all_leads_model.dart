class AllLeadsList {
  String? status;
  String? message;
  Data? data;

  AllLeadsList({this.status, this.message, this.data});

  AllLeadsList.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toString();
    message = json['message']?.toString();
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Leads>? leads;
  Aggregates? aggregates;
  FiltersApplied? filtersApplied;

  Data({this.leads, this.aggregates, this.filtersApplied});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['leads'] != null) {
      leads = <Leads>[];
      json['leads'].forEach((v) {
        leads!.add(new Leads.fromJson(v));
      });
    }
    aggregates = json['aggregates'] != null
        ? new Aggregates.fromJson(json['aggregates'])
        : null;
    filtersApplied = json['filters_applied'] != null
        ? new FiltersApplied.fromJson(json['filters_applied'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.leads != null) {
      data['leads'] = this.leads!.map((v) => v.toJson()).toList();
    }
    if (this.aggregates != null) {
      data['aggregates'] = this.aggregates!.toJson();
    }
    if (this.filtersApplied != null) {
      data['filters_applied'] = this.filtersApplied!.toJson();
    }
    return data;
  }
}

class Leads {
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
  String? leadType;
  String? voiceRecording;
  String? createdAt;
  String? updatedAt;
  bool? isPersonalLead;
  Employee? employee;
  TeamLead? teamLead;

  Leads(
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
        this.leadType,
        this.voiceRecording,
        this.createdAt,
        this.updatedAt,
        this.isPersonalLead,
        this.employee,
        this.teamLead});

  Leads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    teamLeadId = json['team_lead_id'];
    name = json['name'];
    phone = json['phone'].toString();
    email = json['email'];
    dob = json['dob'];
    location = json['location'];
    companyName = json['company_name'];
    leadAmount = json['lead_amount'].toString();
    salary = json['salary'].toString();
    successPercentage = json['success_percentage'];
    expectedMonth = json['expected_month'];
    remarks = json['remarks'];
    status = json['status'];
    leadType = json['lead_type'];
    voiceRecording = json['voice_recording'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isPersonalLead = json['is_personal_lead'];
    employee = json['employee'] != null
        ? new Employee.fromJson(json['employee'])
        : null;
    teamLead = json['team_lead'] != null
        ? new TeamLead.fromJson(json['team_lead'])
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
    data['lead_type'] = this.leadType;
    data['voice_recording'] = this.voiceRecording;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_personal_lead'] = this.isPersonalLead;
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
  String? department;
  String? profilePhoto;
  String? address;
  String? panCard;
  String? aadharCard;
  String? signature;
  String? createdBy;
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

class TeamLead {
  int? id;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? designation;
  String? department;
  String? profilePhoto;
  String? address;
  String? panCard;
  String? aadharCard;
  String? signature;
  String? createdBy;
  int? teamLeadId;
  String? createdAt;
  String? updatedAt;

  TeamLead(
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

  TeamLead.fromJson(Map<String, dynamic> json) {
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

class Aggregates {
  TotalLeads? totalLeads;
  TotalLeads? approvedLeads;
  DisbursedLeads? disbursedLeads;
  TotalLeads? pendingLeads;
  TotalLeads? rejectedLeads;

  Aggregates(
      {this.totalLeads,
        this.approvedLeads,
        this.disbursedLeads,
        this.pendingLeads,
        this.rejectedLeads});

  Aggregates.fromJson(Map<String, dynamic> json) {
    totalLeads = json['total_leads'] != null
        ? new TotalLeads.fromJson(json['total_leads'])
        : null;
    approvedLeads = json['approved_leads'] != null
        ? new TotalLeads.fromJson(json['approved_leads'])
        : null;
    disbursedLeads = json['disbursed_leads'] != null
        ? new DisbursedLeads.fromJson(json['disbursed_leads'])
        : null;
    pendingLeads = json['pending_leads'] != null
        ? new TotalLeads.fromJson(json['pending_leads'])
        : null;
    rejectedLeads = json['rejected_leads'] != null
        ? new TotalLeads.fromJson(json['rejected_leads'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.totalLeads != null) {
      data['total_leads'] = this.totalLeads!.toJson();
    }
    if (this.approvedLeads != null) {
      data['approved_leads'] = this.approvedLeads!.toJson();
    }
    if (this.disbursedLeads != null) {
      data['disbursed_leads'] = this.disbursedLeads!.toJson();
    }
    if (this.pendingLeads != null) {
      data['pending_leads'] = this.pendingLeads!.toJson();
    }
    if (this.rejectedLeads != null) {
      data['rejected_leads'] = this.rejectedLeads!.toJson();
    }
    return data;
  }
}

class TotalLeads {
  int? count;
  String? totalAmount;

  TotalLeads({this.count, this.totalAmount});

  TotalLeads.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    totalAmount = json['total_amount'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['total_amount'] = this.totalAmount;
    return data;
  }
}

class DisbursedLeads {
  int? count;
  int? totalAmount;

  DisbursedLeads({this.count, this.totalAmount});

  DisbursedLeads.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['total_amount'] = this.totalAmount;
    return data;
  }
}

class FiltersApplied {
  String? leadType;
  String? status;
  String? dateFilter;
  String? startDate;
  String? endDate;

  FiltersApplied(
      {this.leadType,
        this.status,
        this.dateFilter,
        this.startDate,
        this.endDate});

  FiltersApplied.fromJson(Map<String, dynamic> json) {
    leadType = json['lead_type'];
    status = json['status'];
    dateFilter = json['date_filter'].toString();
    startDate = json['start_date'].toString();
    endDate = json['end_date'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lead_type'] = this.leadType;
    data['status'] = this.status;
    data['date_filter'] = this.dateFilter;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    return data;
  }
}