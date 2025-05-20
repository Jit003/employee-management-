import 'package:flutter/material.dart';
import 'package:kredipal/constant/app_color.dart';
import 'package:kredipal/widgets/custom_button.dart';
import 'package:kredipal/widgets/custom_text_field_addlead.dart';

class AddLeadsPage extends StatelessWidget {
  const AddLeadsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Lead'),
        backgroundColor: AppColor.appBarColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 10),
            buildTextField(label: 'Name', icon: Icons.person),
            buildTextField(label: 'Phone', icon: Icons.phone, keyboardType: TextInputType.phone),
            buildTextField(label: 'Email', icon: Icons.email, keyboardType: TextInputType.emailAddress),
            buildTextField(label: 'Address', icon: Icons.location_on),
            buildTextField(label: 'Company', icon: Icons.business),
            buildTextField(label: 'Lead Source', icon: Icons.source),
            buildTextField(label: 'Remarks', icon: Icons.note, maxLines: 3),

            const SizedBox(height: 25),
            CustomButton(text: 'Save Lead', onPressed: (){})
          ],
        ),
      ),
    );
  }
}
