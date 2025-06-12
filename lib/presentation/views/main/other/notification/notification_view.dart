import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/presentation/widgets/notification_card.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: ListView.builder(
        itemCount: 3,
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) {
            return NotificationCard();
          }
      ),
    );
  }
}
