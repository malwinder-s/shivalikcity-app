import 'package:flutter/material.dart';
import 'package:housingsociety/services/auth.dart';
import 'package:housingsociety/shared/constants.dart';

class EditPassword extends StatefulWidget {
  @override
  _EditPasswordState createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  String currentPassword = '';
  String updatedPassword = '';
  String updatedPasswordReEntered = '';
  String snackBarText;
  bool obscureTextCurrent = true;
  bool obscureTextUpdated = true;
  bool obscureTextupdatedReEntered = true;

  Color visibiltyIconColorCurrent = Colors.grey;
  Color visibiltyIconColorUpdated = Colors.grey;
  Color visibiltyIconColorUpdatedReEntered = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  obscureText: obscureTextCurrent,
                  decoration: InputDecoration(
                    labelText: 'Current Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureTextCurrent = !obscureTextCurrent;
                          visibiltyIconColorCurrent =
                              obscureTextCurrent ? Colors.grey : kAmaranth;
                        });
                      },
                      icon: Icon(
                        Icons.visibility,
                        color: visibiltyIconColorCurrent,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      currentPassword = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  obscureText: obscureTextUpdated,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureTextUpdated = !obscureTextUpdated;
                          visibiltyIconColorUpdated =
                              obscureTextUpdated ? Colors.grey : kAmaranth;
                        });
                      },
                      icon: Icon(
                        Icons.visibility,
                        color: visibiltyIconColorUpdated,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      updatedPassword = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  obscureText: obscureTextupdatedReEntered,
                  decoration: InputDecoration(
                    labelText: 'New Password, again',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureTextupdatedReEntered =
                              !obscureTextupdatedReEntered;
                          visibiltyIconColorUpdatedReEntered =
                              obscureTextupdatedReEntered
                                  ? Colors.grey
                                  : kAmaranth;
                        });
                      },
                      icon: Icon(
                        Icons.visibility,
                        color: visibiltyIconColorUpdatedReEntered,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      updatedPasswordReEntered = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: currentPassword != '' &&
                updatedPassword != '' &&
                updatedPasswordReEntered != ''
            ? true
            : false,
        child: Builder(
          builder: (BuildContext context) => FloatingActionButton(
            onPressed: () async {
              if (updatedPassword != updatedPasswordReEntered) {
                final snackbar = SnackBar(
                  content: Text('Passwords do not match'),
                  backgroundColor: kAmaranth,
                  duration: Duration(seconds: 1, milliseconds: 50),
                  behavior: SnackBarBehavior.floating,
                );
                Scaffold.of(context).showSnackBar(snackbar);
              } else if (updatedPassword.length < 4) {
                final snackbar = SnackBar(
                  content: Text('Password must be atleast 4 charachters long'),
                  backgroundColor: kAmaranth,
                  duration: Duration(seconds: 1, milliseconds: 50),
                  behavior: SnackBarBehavior.floating,
                );
                Scaffold.of(context).showSnackBar(snackbar);
              } else {
                dynamic result = await AuthService()
                    .updatePassword(currentPassword, updatedPassword);
                if (result == 'Password updated successfully') {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      elevation: 50,
                      backgroundColor: kSpaceCadet,
                      title: Text(
                        'Password updated successfully',
                      ),
                      actions: [
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                          },
                          child: Text(
                            'Okay',
                            style: TextStyle(),
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  final snackbar = SnackBar(
                    content: Text(result.toString()),
                    backgroundColor: kAmaranth,
                    duration: Duration(seconds: 1, milliseconds: 50),
                    behavior: SnackBarBehavior.floating,
                  );
                  Scaffold.of(context).showSnackBar(snackbar);
                }
              }
            },
            backgroundColor: kAmaranth,
            child: Icon(
              Icons.save,
            ),
          ),
        ),
      ),
    );
  }
}
