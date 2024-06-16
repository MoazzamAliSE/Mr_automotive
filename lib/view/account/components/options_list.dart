import 'package:auto_motive/Data/shared%20pref/shared_pref.dart';
import 'package:auto_motive/view/appointments/appointment_with_clients.dart';
import 'package:auto_motive/view/appointments/appointment_with_mechanics.dart';
import 'package:auto_motive/view/common%20widgets/options_card.dart';
import 'package:auto_motive/view/my_orders/my_orders.dart';
import 'package:auto_motive/view/reviecved_orders/received_orders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OptionsList extends StatelessWidget {
  const OptionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        OptionsCard
          (
          icon: Icons.shopping_cart,
          title: 'My Order Details',
          onTap: () =>Get.to(()=>MyOrders()),
        ),
        OptionsCard(
          icon: Icons.shopping_cart,
          title: 'Received Orders',
          onTap: () {
            Get.to(()=>ReceivedOrders());
          },
        ),
        OptionsCard(
          icon: Icons.calendar_today,
          title: 'Appointment with Mechanic',
          onTap: () {
            Get.to(()=>AppointmentWithMechanic());
          },
        ),
        OptionsCard(
          icon: Icons.calendar_today,
          title: 'Appointment with Clients',
          onTap: () {
            Get.to(()=>AppointmentWithClients());
          },
        ),
        // OptionsCard(
        //   icon: Icons.shopping_cart,
        //   title: 'Order Details',
        //   onTap: () {},
        // ),
        OptionsCard(
          icon: Icons.help,
          title: 'Help and Support',
          onTap: () {},
        ),
        OptionsCard(
          icon: Icons.logout,
          title: 'Logout',
          onTap: () {
            showGeneralDialog(context: context, pageBuilder: (context, animation, secondaryAnimation) {
              return AlertDialog(
                surfaceTintColor: Colors.white,
                title: const Text('Warning',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14),),
                content: const Text('Are your sure to logout from this account',style: TextStyle(color: Colors.black),),
                actions: [
                  TextButton(onPressed: () => Get.back(), child:  const Text('Cancel',style: TextStyle(color: Colors.black),)),
                  TextButton(onPressed: (){
                    UserPref.removeUser();
                  }, child:  const Text('Ok',style: TextStyle(color: Colors.red),)),
                ],
              );
            },);
          },
        ),
      ],
    );
  }
}
