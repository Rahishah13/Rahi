import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisplayPage extends StatefulWidget {
  final Map<String, String> userData;

  DisplayPage({required this.userData});

  @override
  _DisplayPageState createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  final _formKey = GlobalKey<FormState>();
  List<Map<String, String>> _userDataList = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }
  void _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? userDataStrings = prefs.getStringList('userDataList');
    List<Map<String, String>> loadedDataList = [];
    if (userDataStrings != null) {
      for (String userDataString in userDataStrings) {
        Map<String, String> userDataMap = jsonDecode(userDataString);
        loadedDataList.add(userDataMap);
      }
    }
    setState(() {
      _userDataList = loadedDataList; // Assuming _userDataList is of type List<Map<String, String>>
    });
  }




  void _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> userDataStrings = [];
    for (Map<String, String> userData in _userDataList) {
      String userDataString = jsonEncode(userData);
      userDataStrings.add(userDataString);
    }
    await prefs.setStringList('userDataList', userDataStrings);
  }

  void _editUserData(int index, Map<String, String> userData) {
    setState(() {
      _userDataList[index] = userData;
    });
    _saveData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display Page')),
      body: ListView.builder(
        itemCount: _userDataList.length,
        itemBuilder: (context, index) {
          Map<String, String> userData = _userDataList[index];
          return ListTile(
            title: Text('Name: ${userData['name']}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Email: ${userData['email']}'),
                Text('Phone: ${userData['phone']}'),
                Text('Birth Date: ${userData['birthdate']}'),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return EditUserDataForm(
                      userData: userData,
                      onSave: (updatedUserData) {
                        _editUserData(index, updatedUserData);
                        Navigator.pop(context);
                      },
                    );
                  },
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return UserDataForm(
                onSave: (newUserData) {
                  setState(() {
                    _userDataList.add(newUserData);
                  });
                  _saveData();
                  Navigator.pop(context);
                },
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class UserDataForm extends StatefulWidget {
  final Function(Map<String, String>) onSave;

  UserDataForm({required this.onSave});

  @override
  _UserDataFormState createState() => _UserDataFormState();
}

class _UserDataFormState extends State<UserDataForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _birthdateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an email';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a phone number';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _birthdateController,
              decoration: InputDecoration(labelText: 'Birth Date'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a birth date';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Map<String, String> userData = {
                    'name': _nameController.text,
                    'email': _emailController.text,
                    'phone': _phoneController.text,
                    'birthdate': _birthdateController.text,
                  };
                  widget.onSave(userData);
                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

class EditUserDataForm extends StatefulWidget {
  final Map<String, String> userData;
  final Function(Map<String, String>) onSave;

  EditUserDataForm({required this.userData, required this.onSave});

  @override
  _EditUserDataFormState createState() => _EditUserDataFormState();
}

class _EditUserDataFormState extends State<EditUserDataForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _birthdateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userData['name']);
    _emailController = TextEditingController(text: widget.userData['email']);
    _phoneController = TextEditingController(text: widget.userData['phone']);
    _birthdateController = TextEditingController(text: widget.userData['birthdate']);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _birthdateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _birthdateController,
                decoration: InputDecoration(labelText: 'Birth Date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a birth date';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Map<String, String> updatedUserData = {
                      'name': _nameController.text,
                      'email': _emailController.text,
                      'phone': _phoneController.text,
                      'birthdate': _birthdateController.text,
                    };
                    widget.onSave(updatedUserData);
                  }
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

