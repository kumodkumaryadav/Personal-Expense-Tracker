// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controller/input_controller.dart';
import '../../model/input_model.dart';

class UpdateScreen extends StatelessWidget {
  final InputController inputController = Get.put(InputController());
  final TextEditingController titleTextController = TextEditingController();
  final TextEditingController amountTextController = TextEditingController();
  final TextEditingController descTextController = TextEditingController();

  UpdateScreen({
    Key? key,
  }) : super(key: key);
  Map<String, dynamic>? arguments;
  @override
  Widget build(BuildContext context) {
    if (Get.arguments != null) {
      arguments = Get.arguments;
    }
    int index = arguments!['index'];
    var data = inputController.inputs[index];
    String stringId = arguments!['stringId'];

    inputController.updateDate.value = data.dateTime.toIso8601String();
    // DateTime dateData = data.dateTime;

    titleTextController.text = data.title;
    amountTextController.text = data.amount.toString();
    descTextController.text = data.description;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text("UPDATE EXPENSE"),
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
                        currentDate:
                            DateTime.parse(inputController.updateDate.value))
                    .then((pickedDate) {
                  if (pickedDate != null) {
                    inputController.updateDate.value =
                        pickedDate.toIso8601String();
                  }
                }),
                child: Text(
                  'Expense Date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(inputController.updateDate.toString()))}',
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
                // var id = data.id;

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
                InputModel updatedInput = InputModel(
                    id: data.id,
                    title: titleTextController.text,
                    amount: amount,
                    dateTime: DateTime.parse(inputController.updateDate.value),
                    description: description);
                inputController.updateInput(index, data.id, updatedInput);
                // inputController.updateInput(data.id, updatedInput);
              },
              child: Obx(
                () => inputController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : const Text('Update'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
