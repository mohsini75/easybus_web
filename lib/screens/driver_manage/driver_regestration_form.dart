import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DriverRegForm extends StatefulWidget {
  final User? rUser;
  DriverRegForm(@required this.rUser);
  //const DriverRegForm({Key? key}) : super(key: key);

  @override
  _DriverRegFormState createState() => _DriverRegFormState();
}

class _DriverRegFormState extends State<DriverRegForm> {
  TextEditingController emailControl = new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController cnic = new TextEditingController();
  TextEditingController contact = new TextEditingController();
  String newa = '';
  List<String> panic = <String>[
    'select Route',
    '1',
    '2',
    '3 ',
    '4 ',
  ];

  String newPanicValue = 'select Route';
  /////////////////////////////////////////////////////////////////////////
  List<String> panic1 = <String>[
    'Select vehicle',
    'RID-754',
    'RIA-965',
    'RSA-857',
    'RIK-145',
  ];

  String newPanicValue1 = 'Select vehicle';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        SizedBox(height: 20),
        Center(
          child: Container(
            width: 300,
            height: 60,
            child: TextFormField(
              controller: name,
              textAlign: TextAlign.center,
              onSaved: (value) {
                name.text = value!;
              },
              validator: (value) {
                RegExp regEx = new RegExp(r'^.{3,}$');
                if (value!.isEmpty) {
                  return ("Name is required for login");
                }
                if (!regEx.hasMatch(value)) {
                  return ("Please Enter Valid name");
                }
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                // prefixIcon: Icon(Icons.vpn_key),
                hintText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                contentPadding: EdgeInsets.all(16),
                fillColor: Color(0xffaa9976),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Center(
          child: Container(
            width: 300,
            height: 60,
            child: TextFormField(
              controller: cnic,
              textAlign: TextAlign.center,
              onSaved: (value) {
                cnic.text = value!;
              },
              validator: (value) {
                RegExp regEx = new RegExp(r'^.{2,}$');
                if (value!.isEmpty) {
                  return ("this field is required for login");
                }
                if (!regEx.hasMatch(value)) {
                  return ("Please Enter Valid Role");
                }
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                // prefixIcon: Icon(Icons.vpn_key),
                hintText: 'Cnic',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                contentPadding: EdgeInsets.all(16),
                fillColor: Color(0xffaa9976),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Center(
          child: Container(
            width: 300,
            height: 60,
            child: TextFormField(
              controller: contact,
              textAlign: TextAlign.center,
              onSaved: (value) {
                contact.text = value!;
              },
              validator: (value) {
                RegExp regEx = new RegExp(r'^.{2,}$');
                if (value!.isEmpty) {
                  return ("this Field Is required for login");
                }
                if (!regEx.hasMatch(value)) {
                  return ("Please Enter Valid ID");
                }
              },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone),
                hintText: 'Contact',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                contentPadding: EdgeInsets.all(16),
                fillColor: Color(0xffaa9976),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Center(
          child: Container(
            width: 300,
            height: 40,
            color: Color(0xffaa9976),
            child: DropdownButton<String>(
              onChanged: (String? newValue) {
                setState(() {
                  newPanicValue = newValue!;
                  newa = newValue;
                });
              },
              onTap: () {},
              isExpanded: true,
              value: newPanicValue,
              items: panic.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Center(
          child: Container(
            width: 300,
            height: 40,
            color: Color(0xffaa9976),
            child: DropdownButton<String>(
              onChanged: (String? newValue) {
                setState(() {
                  newPanicValue1 = newValue!;
                  newa = newValue;
                });
              },
              onTap: () {},
              isExpanded: true,
              value: newPanicValue1,
              items: panic1.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Center(
          child: TextButton(
            onPressed: () {
              // Navigator.pushReplacement(context,
              //     MaterialPageRoute(builder: (context) => ));
              // Fluttertoast.showToast(msg: 'Create');
              //print(widget.rUser!.uid,name,cnic,contact,),
              FirebaseFirestore.instance.collection("users").add({
                'id': widget.rUser!.uid,
                'name': name.text,
                'cnic': cnic.text,
                'email': widget.rUser!.email,
                'role': 'driver',
                'contact': contact.text,
                'routeNo': newPanicValue,
                'vehicle': newPanicValue1,
              });
              Navigator.of(context, rootNavigator: true).pop('dialog');
              Fluttertoast.showToast(msg: 'Driver Added!');
            },
            child: Text("Create Driver", style: TextStyle(fontSize: 20)),
          ),
          // // signUp(emailControl.text, passwordControl.text);
        )
      ],
    );
  }
}