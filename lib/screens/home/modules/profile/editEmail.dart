import 'package:flutter/material.dart';
import 'package:housingsociety/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:housingsociety/models/user.dart';
import 'package:housingsociety/shared/constants.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';

class EditEmail extends StatefulWidget {
  @override
  _EditEmailState createState() => _EditEmailState();
}

class _EditEmailState extends State<EditEmail> {
  String updatedEmail = '';
  String password = '';
  bool obscureText = true;
  Color visibiltyIconColor = Colors.grey;

  void unHidePassword() {
    setState(() {
      obscureText = !obscureText;
    });
    if (obscureText == true) {
      setState(() {
        visibiltyIconColor = Colors.grey;
      });
    } else {
      setState(() {
        visibiltyIconColor = kAmaranth;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit your email'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              initialValue: user.email,
              decoration: InputDecoration(
                labelText: 'New Email ID',
              ),
              onChanged: (value) {
                setState(() {
                  updatedEmail = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              obscureText: obscureText,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  onPressed: unHidePassword,
                  icon: Icon(
                    Icons.visibility,
                    color: visibiltyIconColor,
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: (updatedEmail != user.email && updatedEmail != '') &&
                password != '' &&
                password.length > 4
            ? true
            : false,
        child: FloatingActionButton(
          onPressed: () async {
            dynamic result =
                await AuthService().updateEmail(updatedEmail, password);
            print(result);
            if (result == null) {
              showModalActionSheet(
                context: context,
                actions: [
                  SheetAction(
                    label: 'An error occurred. Please try again!',
                    icon: Icons.error,
                    isDestructiveAction: true,
                  )
                ],
              );
            } else {
              Navigator.pop(context);
            }
          },
          child: Icon(Icons.save),
        ),
      ),
    );
  }
}
