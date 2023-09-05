import 'dart:convert';
import 'dart:ffi';

List<Expense> expenseFromMap(String str) => List<Expense>.from(json.decode(str).map((x) => Expense.fromMap(x)));

String expenseToMap(List<Expense> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Expense {
    Expense({
        this.eId="no id",
        required
        this.eDate,
        this.eDes="no des",
        this.ePrice="0",
        this.userId="no userID",
        this.cid="no catId",
    });

    String eId;
    DateTime eDate;
    String eDes;
    String ePrice;
    String userId;
    String cid;

    factory Expense.fromMap(Map<String, dynamic> json) => Expense(
        eId: json["e_id"]??"no eid",
        eDate: DateTime.parse(json["e_date"]??DateTime.now()),
        eDes: json["e_des"]??"no des",
        ePrice: json["e_price"]??"0",
        userId: json["userId"]??"no userId",
        cid: json["cid"]??"no cateId",
    );

    Map<String, dynamic> toMap() => {
        "e_des": eDes,
        "e_price":  ePrice,
        "cid": cid,
    };
}
