class BookingModel {
  final String id;
  final String providerName;
  final String service;
  final String status;
  final DateTime date;
  final String time;
  final String? primaryAction;
  final String? secondaryAction;

  const BookingModel({
    required this.id,
    required this.providerName,
    required this.service,
    required this.status,
    required this.date,
    required this.time,
    this.primaryAction,
    this.secondaryAction,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] as String? ?? '',
      providerName: json['providerName'] as String? ?? '',
      service: json['service'] as String? ?? '',
      status: json['status'] as String? ?? '',
      date: DateTime.tryParse(json['date'] as String? ?? '') ?? DateTime.now(),
      time: json['time'] as String? ?? '',
      primaryAction: json['primaryAction'] as String?,
      secondaryAction: json['secondaryAction'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'providerName': providerName,
        'service': service,
        'status': status,
        'date': date.toIso8601String(),
        'time': time,
        'primaryAction': primaryAction,
        'secondaryAction': secondaryAction,
      };
}

class CreateBookingRequest {
  final String providerId;
  final String service;
  final DateTime date;
  final String time;
  final String? notes;

  const CreateBookingRequest({
    required this.providerId,
    required this.service,
    required this.date,
    required this.time,
    this.notes,
  });

  Map<String, dynamic> toJson() => {
        'providerId': providerId,
        'service': service,
        'date': date.toIso8601String(),
        'time': time,
        if (notes != null) 'notes': notes,
      };
}
