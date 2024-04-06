import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/model/input_model.dart';
import 'package:personal_expense_tracker/modules/expense%20tracker/resources/routes/route_name.dart';

import '../controller/input_controller.dart';
import 'package:intl/intl.dart';

class InputScreen extends StatelessWidget {
  final inputController = Get.put(InputController());
  final TextEditingController titleTextController = TextEditingController();
  final TextEditingController amountTextController = TextEditingController();
  final TextEditingController descTextController = TextEditingController();

  InputScreen({super.key});
  void dispose() {
    titleTextController.dispose();
    amountTextController.dispose();

    descTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back)),
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text("ADD EXPENSE"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleTextController,
              maxLength: 15,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: amountTextController,
              maxLength: 6,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount',
              ),
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
              controller: descTextController,
              maxLength: 50,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                var id = inputController.uuid.v1();
                var title = titleTextController.text;
                var dateTime = inputController.date.value;
                double amount;
                if (amountTextController.text.isNotEmpty) {
                  amount = double.parse(amountTextController.text);
                } else {
                  debugPrint('Amount field is empty');

                  amount = -1.0;
                }

                var description = descTextController.text;
                final input = InputModel(
                    id: id,
                    title: title,
                    amount: amount,
                    dateTime: dateTime,
                    description: description);
                inputController.addInput(input);
              },
              child: 
               Text('Submit'),
              ),
            
          ],
        ),
      ),
    );
  }
}
