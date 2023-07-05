import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/display_page.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _birthdateController = TextEditingController();

  void _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', _nameController.text);
    prefs.setString('email', _emailController.text);
    prefs.setString('phone', _phoneController.text);
    prefs.setString('birthdate', _birthdateController.text);
  }

  void _navigateToDisplayPage() {
    Map<String, String> userData = {
      'name': _nameController.text,
      'email': _emailController.text,
      'phone': _phoneController.text,
      'birthdate': _birthdateController.text,
    };
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DisplayPage(userData: userData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form Page')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: 'Phone'),
              ),
              TextFormField(
                controller: _birthdateController,
                decoration: InputDecoration(labelText: 'Birth Date'),
                onTap: () async {
                  var datePicked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (datePicked != null) {
                    setState(() {
                      _birthdateController.text = datePicked.toString();
                    });
                  }
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _saveData();
                    _navigateToDisplayPage();
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:task/display_page.dart';
//
// class FormPage extends StatefulWidget {
//   @override
//   _FormPageState createState() => _FormPageState();
// }
//
// class _FormPageState extends State<FormPage> {
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController _nameController = TextEditingController();
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _phoneController = TextEditingController();
//   TextEditingController _birthdateController = TextEditingController();
//
//   void _saveData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('name', _nameController.text);
//     prefs.setString('email', _emailController.text);
//     prefs.setString('phone', _phoneController.text);
//     prefs.setString('birthdate', _birthdateController.text);
//   }
//
//   void _navigateToDisplayPage() {
//     Map<String, String> userData = {
//       'name': _nameController.text,
//       'email': _emailController.text,
//       'phone': _phoneController.text,
//       'birthdate': _birthdateController.text,
//     };
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => DisplayPage(userData: userData),
//       ),
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Form Page')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _nameController,
//                 decoration: InputDecoration(labelText: 'Name'),
//
//               ),
//               TextFormField(
//                 controller: _emailController,
//                 decoration: InputDecoration(labelText: 'Email'),
//
//               ),
//               TextFormField(
//                 controller: _phoneController,
//                 keyboardType: TextInputType.phone,
//                 decoration: InputDecoration(labelText: 'Phone'),
//
//               ),
//               TextFormField(
//                 controller: _birthdateController,
//                 decoration: InputDecoration(labelText: 'Birth Date'),
//                     onTap: () async {
//               var datePicked = await showDatePicker(
//               context: context,
//               initialDate: DateTime.now(),
//               firstDate: DateTime(1900),
//               lastDate: DateTime.now(),
//
//               );
//               if(datePicked != null){
//               setState(() {
//               _birthdateController.text=datePicked.toString();
//               });
//               }
//               }
//
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//     onPressed: () {
//     if (_formKey.currentState!.validate()) {
//     _saveData();
//     _navigateToDisplayPage(); // Navigate to DisplayPage with user data
//     }
//     },
//     child: Text('Save'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//
//

// class FormPage extends StatefulWidget {
//   @override
//   _FormPageState createState() => _FormPageState();
// }
//
// class _FormPageState extends State<FormPage> {
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController _nameController = TextEditingController();
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _phoneController = TextEditingController();
//   TextEditingController _birthdateController = TextEditingController();
//
//
//   void _saveData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('name', _nameController.text);
//     prefs.setString('email', _emailController.text);
//     prefs.setString('phone', _phoneController.text);
//     prefs.setString('birthdate', _birthdateController.text);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Form Page')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _nameController,
//                 decoration: InputDecoration(labelText: 'Name'),
//
//               ),
//               TextFormField(
//                 controller: _emailController,
//                 decoration: InputDecoration(labelText: 'Email'),
//
//               ),
//               TextFormField(
//                 controller: _phoneController,
//                 keyboardType: TextInputType.phone,
//                 decoration: InputDecoration(labelText: 'Phone'),
//
//               ),
//               TextFormField(
//                 controller: _birthdateController,
//                 decoration: InputDecoration(labelText: 'Birth Date'),
//                     onTap: () async {
//               var datePicked = await showDatePicker(
//               context: context,
//               initialDate: DateTime.now(),
//               firstDate: DateTime(1900),
//               lastDate: DateTime.now(),
//
//               );
//               if(datePicked != null){
//               setState(() {
//               _birthdateController.text=datePicked.toString();
//               });
//               }
//               }
//
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   _saveData();
//                     Navigator.pushNamed(context, '/display');
//                   },
//                   child: Text('Save'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
