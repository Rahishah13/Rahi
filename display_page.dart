import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisplayPage extends StatefulWidget {
  @override
  _DisplayPageState createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _phone = '';
  String _birthdate = '';



  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? '';
      _email = prefs.getString('email') ?? '';
      _phone = prefs.getString('phone') ?? '';
      _birthdate = prefs.getString('birthdate') ?? '';
    });
  }

  void _editData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _name);
    await prefs.setString('email', _email);
    await prefs.setString('phone', _phone);
    await prefs.setString('birthdate', _birthdate);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display Page')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: $_name'),
            Text('Email: $_email'),
            Text('Phone: $_phone'),
            Text('Birth Date: $_birthdate'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        TextEditingController _editNameController =
                        TextEditingController(text: _name);
                        TextEditingController _editEmailController =
                        TextEditingController(text: _email);
                        TextEditingController _editPhoneController =
                        TextEditingController(text: _phone);
                        TextEditingController _editBirthdateController =
                        TextEditingController(text: _birthdate);

                        void _saveEditedData() async {
                          if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            setState(() {
                              _name = _editNameController.text;
                              _email = _editEmailController.text;
                              _phone = _editPhoneController.text;
                              _birthdate = _editBirthdateController.text;
                            });
                            await prefs.setString('name', _name);
                            await prefs.setString('email', _email);
                            await prefs.setString('phone', _phone);
                            await prefs.setString('birthdate', _birthdate);

                            _editData();
                          }
                          Navigator.pop(context);
                         }


                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _editNameController,
                                  decoration: InputDecoration(labelText: 'Name'),

                                ),
                                TextFormField(
                                  controller: _editEmailController,
                                  decoration: InputDecoration(labelText: 'Email'),

                                ),
                                TextFormField(
                                  controller: _editPhoneController,
                                  decoration: InputDecoration(labelText: 'Phone'),

                                ),
                                TextFormField(
                                  controller: _editBirthdateController,
                                  decoration: InputDecoration(labelText: 'Birth Date'),

                                ),
                                SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: _saveEditedData,
                                  child: Text('Update'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
              child: Text('View'),
            ),
          ],
        ),
      ),
    );
  }
}

