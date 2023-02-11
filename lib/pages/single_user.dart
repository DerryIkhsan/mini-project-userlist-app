import 'package:flutter/material.dart';
import 'package:flutter_mini_project_arkamaya/theme.dart';
import '../repo/usersRepo.dart';
import '../model/users.dart';

class SingleUser extends StatefulWidget {
  String id;

  SingleUser({required this.id});

  @override
  State<SingleUser> createState() => _SingleUserState();
}

class _SingleUserState extends State<SingleUser> {
  Users users = Users(
    id: 0,
    avatar: '',
    email: '',
    firstName: '',
    lastName: '',
    support: '',
  );

  late String usersId = widget.id;
  // var users;

  UsersRepo usersRepo = UsersRepo();

  getUser() async {
    users = await usersRepo.usersDetails(id: widget.id);

    print(users.avatar);

    setState(() {});
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleColor,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 30,
              width: (MediaQuery.of(context).size.width),
              child: SizedBox(
                child: Center(
                  child: Container(
                    width: 170,
                    child: Text(
                      'Single User',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                child: Container(
                  height: (MediaQuery.of(context).size.height * 0.55),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(height: 75),
                        Text(
                          '${(users.firstName ?? '') + ' ' + (users.lastName ?? '')}',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${users.email}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withOpacity(.6),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Support',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Wrap(
                                children: [
                                  Text('${users.support}',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black.withOpacity(.6),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.15,
              width: (MediaQuery.of(context).size.width),
              child: SizedBox(
                child: Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                        image: NetworkImage("${users.avatar}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
