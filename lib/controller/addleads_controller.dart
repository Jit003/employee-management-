import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AddLeadsController extends GetxController {

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();
  final comNameController = TextEditingController();
  final comCategoryController = TextEditingController();
  // Dropdown values
  var selectedMonth = ''.obs;
  var selectedSuccessRatio = ''.obs;
  // Date picker
  var selectedDate = Rxn<DateTime>();

  void setDate(DateTime date){
    selectedDate.value = date;
  }

  // Dropdown options
  final expectedMonth = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];
  final successPer = ['10%','20%'];

}