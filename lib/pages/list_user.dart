import 'package:flutter/material.dart';
import 'package:flutter_mini_project_arkamaya/pages/create_user.dart';
import 'package:flutter_mini_project_arkamaya/pages/single_user.dart';
import 'package:flutter_mini_project_arkamaya/theme.dart';
import 'about.dart';
import '../repo/usersRepo.dart';
import '../model/users.dart';

class ListUser extends StatefulWidget {
  @override
  State<ListUser> createState() => _ListUserState();
}

class _ListUserState extends State<ListUser> {
  List<Users> listUsers = [];
  UsersRepo usersRepo = UsersRepo();
  final List<Widget> _pages = [
    ListUser(),
    CreateUser(),
    About(),
  ];

  // ambil data users list
  getUsersList() async {
    listUsers = await usersRepo.usersList();

    setState(() {});
  }

  @override
  void initState() {
    if (this.mounted) {
      super.initState();
      getUsersList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'List Users',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    UsersList(listUsers: listUsers),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UsersList extends StatelessWidget {
  const UsersList({
    Key? key,
    required this.listUsers,
  }) : super(key: key);

  final List<Users> listUsers;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(
        height: 10,
        child: Divider(
          color: Colors.white,
        ),
      ),
      shrinkWrap: true,
      itemCount: listUsers.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            // navigator to users details
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    SingleUser(id: listUsers[index].id.toString()),
              ),
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          listUsers[index].avatar ?? '',
                        ),
                      ),
                      borderRadius: BorderRadius.circular(60),
                    ),
                  ),
                  index.isOdd ? OnlineBadge() : Container(),
                ],
              ),
              SizedBox(
                width: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${(listUsers[index].firstName ?? '') + ' ' + (listUsers[index].lastName ?? '')}',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${listUsers[index].email}',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class OnlineBadge extends StatelessWidget {
  const OnlineBadge({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 15,
      right: 0,
      child: Container(
        width: 15,
        height: 15,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
