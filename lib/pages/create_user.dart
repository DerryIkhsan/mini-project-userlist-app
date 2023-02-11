import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme.dart';
import '../repo/usersRepo.dart';
import '../model/users.dart';

class CreateUser extends StatefulWidget {
  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  UsersRepo usersRepo = UsersRepo();
  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Create',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: (MediaQuery.of(context).size.height * 0.65),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: Column(
                        children: [
                          UserField(
                            label: 'Name',
                            controller: nameController,
                            icon: Icon(Icons.person),
                          ),
                          UserField(
                            label: 'Job',
                            controller: jobController,
                            icon: Icon(Icons.work),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(purpleColor),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  // menampilkan alert created ketika form sudah tervalidasi
                                  nameController.text = '';
                                  jobController.text = '';
                                  _formKey.currentState!.reset(); // reset form
                                  FocusScope.of(context)
                                      .unfocus(); // dismiss input keyboard

                                  setState(() {});

                                  Users users = await usersRepo.usersCreate(
                                      name: nameController.text,
                                      job: jobController.text);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor:
                                          Colors.green.withOpacity(.8),
                                      content: showCreated(
                                          id: users.id.toString(),
                                          cratedAt: users.createdAt.toString()),
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                'Save',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container showCreated({required String id, required String cratedAt}) {
    return Container(
      padding: EdgeInsets.all(5),
      width: 400,
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '''
              Data has been created : 
              ID : $id
              cratedAt: $cratedAt
            ''',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class UserField extends StatelessWidget {
  String label;
  TextEditingController controller;
  Icon icon;

  UserField({
    required this.label,
    required this.controller,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: controller,
          validator: (value) {
            if (value!.isEmpty || value == null) {
              return 'Please input your $label';
            }

            return null;
          },
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))
          ],
          decoration: InputDecoration(
            hintText: 'Please input your $label',
            border: OutlineInputBorder(),
            prefixIcon: icon,
          ),
        ),
      ],
    );
  }
}
