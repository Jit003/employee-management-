class AttendanceRecord {
  final int? id;
  final int? employeeId;
  final String? date;
  final String? checkIn;
  final String? checkOut;
  final String? checkInLocation;
  final String? checkOutLocation;
  final String? checkInCoordinates;
  final String? checkOutCoordinates;
  final String? checkinImage;
  final String? checkoutImage;
  final String? notes;
  final String? createdAt;
  final String? updatedAt;

  AttendanceRecord({
    this.id,
    this.employeeId,
    this.date,
    this.checkIn,
    this.checkOut,
    this.checkInLocation,
    this.checkOutLocation,
    this.checkInCoordinates,
    this.checkOutCoordinates,
    this.checkinImage,
    this.checkoutImage,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) {
    return AttendanceRecord(
      id: json['id'],
      employeeId: json['employee_id'],
      date: json['date'],
      checkIn: json['check_in'],
      checkOut: json['check_out'],
      checkInLocation: json['check_in_location'],
      checkOutLocation: json['check_out_location'],
      checkInCoordinates: json['check_in_coordinates'],
      checkOutCoordinates: json['check_out_coordinates'],
      checkinImage: json['checkin_image'],
      checkoutImage: json['checkout_image'],
      notes: json['notes'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee_id': employeeId,
      'date': date,
      'check_in': checkIn,
      'check_out': checkOut,
      'check_in_location': checkInLocation,
      'check_out_location': checkOutLocation,
      'check_in_coordinates': checkInCoordinates,
      'check_out_coordinates': checkOutCoordinates,
      'checkin_image': checkinImage,
      'checkout_image': checkoutImage,
      'notes': notes,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class AttendanceResponse {
  final String status;
  final String message;
  final AttendanceRecord? data;

  AttendanceResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory AttendanceResponse.fromJson(Map<String, dynamic> json) {
    return AttendanceResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? AttendanceRecord.fromJson(json['data']) : null,
    );
  }
}
