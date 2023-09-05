import 'package:flutter/material.dart';
import '../model/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.01,
      ),
      height:MediaQuery.of(context).size.height*0.7,
      child: transactions.isEmpty?Column(children:[
              Text(
                "No transaction added yet ...!!!",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Container(
                margin:EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03,
                ),
                  height: MediaQuery.of(context).size.height * 0.25,
                child: Image.asset('assets/image/waiting.png',fit:BoxFit.cover),
                

              ),
      ]): ListView.builder(
        itemBuilder: (ctx,index){
          return Card(
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '\$${transactions[index].amount.toStringAsFixed(2)}',
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color:  Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transactions[index].title,
                      // ignore: prefer_const_constructors
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      DateFormat.yMMMd().add_Hm().format(transactions[index].date),
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}
