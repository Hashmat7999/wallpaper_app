import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children:    [
          UserAccountsDrawerHeader(accountName:const Text('Hashmat ullah',
              style: TextStyle(
              color: Colors.black,
              fontSize: 18,
                fontWeight: FontWeight.bold,
            ),
          ),
            accountEmail:const Text('Hashmathangu9294@gmail.com',
                   style: TextStyle(
                   fontSize: 18,
                   color: Colors.black,
                   fontWeight: FontWeight.bold,
                   )
                  ),
                currentAccountPicture:CircleAvatar(
                  child: ClipOval(
                     clipBehavior: Clip.antiAlias,
                     child:Image.network('https://www.whatsappimages.in/wp-content/uploads/2021/12/New-HD-Cute-Stylish-Dpz-Pics-Images.jpg',
                     fit: BoxFit.fill,
                       width: 89,
                    )
                    ),
                  ),
                     decoration: const BoxDecoration(
                     image: DecorationImage(
                       opacity: 150,
                       scale: 433,
                       invertColors: false,
                       fit: BoxFit.fill,
                       alignment: Alignment.center,
                       image: AssetImage(
                       'assets/background.jpg.jpg',
                    ),
                  ),
                ),
          ),
        ],
      )
    );
  }
}
