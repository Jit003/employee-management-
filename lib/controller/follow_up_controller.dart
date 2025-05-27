import 'package:get/get.dart';

class FollowUpController extends GetxController {
  var selectedType = 'Call'.obs;
  var selectedDate = Rxn<DateTime>();

  final followUpTypes = ['Call', 'Message', 'Email', 'Meeting'];

  void setType(String type) {
    selectedType.value = type;
  }

  void setDate(DateTime date) {
    selectedDate.value = date;
  }

  void addFollowUp({
    required String leadId,
    required String type,
    required String note,
    required DateTime followUpDate,
  }) {
    // Save to DB or API call
    print("Lead: $leadId, Type: $type, Note: $note, Date: $followUpDate");
  }
}
