import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/model/input_model.dart';

import '../controller/input_controller.dart';
import 'package:intl/intl.dart';

class InputScreen extends StatelessWidget {
  final inputController = Get.put(InputController());
  final TextEditingController tamouController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  InputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text("ADD EXPENSE"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              maxLength: 15,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              onChanged: (value) => inputController.title.value = value,
            ),
            const SizedBox(height: 16.0),
            TextField(
              maxLength: 6,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount',
              ),
              onChanged: (value) =>
                  inputController.amount.value = double.parse(value),
            ),
            const SizedBox(height: 16.0),
            Obx(
              () => TextButton(
                onPressed: () => showDatePicker(
                  context: context,
                  initialDate: inputController.date.value,
                  firstDate: DateTime(2023),
                  lastDate: DateTime.now(),
                ).then((pickedDate) {
                  if (pickedDate != null) {
                    inputController.date.value = pickedDate;
                  }
                }),
                child: Text(
                  'Expense Date: ${DateFormat('yyyy-MM-dd').format(inputController.date.value)}',
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              maxLength: 50,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
              onChanged: (value) => inputController.description.value = value,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                var id = inputController.uuid.v1();
                var title = inputController.title.value;
                var dateTime = inputController.date.value;
                var amount = inputController.amount.value;
                var description = inputController.description.value;
                final input = InputModel(
                    id: id,
                    title: title,
                    amount: amount,
                    dateTime: dateTime,
                    description: description);
                inputController.addInput(input);

                // TODO: Handle form submission (e.g., save data)
                Get.snackbar(
                  'Submitted',
                  'Amount: ${inputController.amount.value}, Date: ${DateFormat('yyyy-MM-dd').format(inputController.date.value)}, Description: ${inputController.description.value}',
                );
              },
              child: Obx(
                () => inputController.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : Text('Submit'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
