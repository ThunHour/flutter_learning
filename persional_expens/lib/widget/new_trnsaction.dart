import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleInput = TextEditingController();

  final amountInput = TextEditingController();

  clearTransition() {
    titleInput.clear();
    amountInput.clear();
  }

  void submitData() {
    final enteredTitle = titleInput.text;
    final enteredAmount = double.parse(amountInput.text);
    if (enteredAmount <= 0 || enteredTitle.isEmpty) {
      return;
    }
    widget.addTx(
      titleInput.text,
      double.parse(amountInput.text),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              controller: titleInput,
              onSubmitted: (_) => submitData,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount',
              ),
              controller: amountInput,
              onSubmitted: (_) => submitData,
            ),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: clearTransition,
                  icon: Icon(Icons.clear),
                  label: Text("Clear"),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.redAccent),
                  ),
                ),
                TextButton(
                  child: Text('Add Tracsaction'),
                  style: TextButton.styleFrom(
                    primary: Colors.purple,
                  ),
                  onPressed: submitData,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
