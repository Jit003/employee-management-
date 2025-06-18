class DashboardModel {
  final String? status;
  final String? message;
  final DashboardData? data;

  DashboardModel({this.status, this.message, this.data});

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? DashboardData.fromJson(json['data']) : null,
    );
  }
}

class DashboardData {
  final User? user;
  final Aggregates? aggregates;
  final LeadTypeBreakdown? leadTypeBreakdown;

  DashboardData({this.user, this.aggregates, this.leadTypeBreakdown});

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      aggregates: json['aggregates'] != null ? Aggregates.fromJson(json['aggregates']) : null,
      leadTypeBreakdown: json['lead_type_breakdown'] != null
          ? LeadTypeBreakdown.fromJson(json['lead_type_breakdown'])
          : null,
    );
  }
}

class User {
  final String? name;
  final String? designation;

  User({this.name, this.designation});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      designation: json['designation'],
    );
  }
}

class Aggregates {
  final LeadStat? totalLeads;
  final LeadStat? approvedLeads;
  final LeadStat? disbursedLeads;
  final LeadStat? pendingLeads;
  final LeadStat? rejectedLeads;

  Aggregates({
    this.totalLeads,
    this.approvedLeads,
    this.disbursedLeads,
    this.pendingLeads,
    this.rejectedLeads,
  });

  factory Aggregates.fromJson(Map<String, dynamic> json) {
    return Aggregates(
      totalLeads: json['total_leads'] != null ? LeadStat.fromJson(json['total_leads']) : null,
      approvedLeads: json['approved_leads'] != null ? LeadStat.fromJson(json['approved_leads']) : null,
      disbursedLeads: json['disbursed_leads'] != null ? LeadStat.fromJson(json['disbursed_leads']) : null,
      pendingLeads: json['pending_leads'] != null ? LeadStat.fromJson(json['pending_leads']) : null,
      rejectedLeads: json['rejected_leads'] != null ? LeadStat.fromJson(json['rejected_leads']) : null,
    );
  }

}

class LeadStat {
  final int count;
  final dynamic totalAmount;

  LeadStat({required this.count, required this.totalAmount});

  factory LeadStat.fromJson(Map<String, dynamic> json) {
    return LeadStat(
      count: json['count'],
      totalAmount: json['total_amount'],
    );
  }
}

class LeadTypeBreakdown {
  final LeadCategory? personalLoan;
  final LeadCategory? businessLoan;
  final LeadCategory? homeLoan;
  final LeadCategory? creditCard;

  LeadTypeBreakdown({
    this.personalLoan,
    this.businessLoan,
    this.homeLoan,
    this.creditCard,
  });

  factory LeadTypeBreakdown.fromJson(Map<String, dynamic> json) {
    return LeadTypeBreakdown(
      personalLoan: json['personal_loan'] != null ? LeadCategory.fromJson(json['personal_loan']) : null,
      businessLoan: json['business_loan'] != null ? LeadCategory.fromJson(json['business_loan']) : null,
      homeLoan: json['home_loan'] != null ? LeadCategory.fromJson(json['home_loan']) : null,
      creditCard: json['credit_card'] != null ? LeadCategory.fromJson(json['credit_card']) : null,
    );
  }

}

class LeadCategory {
  final int count;
  final dynamic totalAmount;
  final List<Lead>? leads;

  LeadCategory({required this.count, required this.totalAmount, this.leads});

  factory LeadCategory.fromJson(Map<String, dynamic> json) {
    return LeadCategory(
      count: json['count'],
      totalAmount: json['total_amount'],
      leads: json['leads'] != null
          ? (json['leads'] as List<dynamic>).map((lead) => Lead.fromJson(lead)).toList()
          : [],
    );
  }

}

class Lead {
  final int id;
  final String name;
  final String leadAmount;
  final String status;
  final String createdAt;

  Lead({
    required this.id,
    required this.name,
    required this.leadAmount,
    required this.status,
    required this.createdAt,
  });

  factory Lead.fromJson(Map<String, dynamic> json) {
    return Lead(
      id: json['id'],
      name: json['name'],
      leadAmount: json['lead_amount'],
      status: json['status'],
      createdAt: json['created_at'],
    );
  }
}
