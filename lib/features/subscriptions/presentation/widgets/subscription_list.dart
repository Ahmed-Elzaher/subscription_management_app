import 'package:flutter/material.dart';
import '../../data/models/subscription_model.dart';
import 'subscription_item.dart';

class SubscriptionList extends StatelessWidget {
  final List<SubscriptionModel> subscriptions;

  const SubscriptionList({super.key, required this.subscriptions});

  @override
  Widget build(BuildContext context) {
    // لو اللستة فاضية (زي قسم الـ Cloud مثلاً) نظهر رسالة شيك
    if (subscriptions.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Text(
            "No plans found in this category",
            style: TextStyle(color: Colors.white24, fontSize: 14),
          ),
        ),
      );
    }

    return ListView.builder(
      // التعديل: Padding خفيف عشان أول كارت ميبقاش لازق في التصنيفات
      padding: const EdgeInsets.only(top: 8, bottom: 20),
      shrinkWrap: true,
      // Physics: الـ Scroll الأساسي موجود في الـ SubscriptionScreen
      physics: const NeverScrollableScrollPhysics(),
      itemCount: subscriptions.length,
      itemBuilder: (context, index) {
        return SubscriptionItem(subscription: subscriptions[index]);
      },
    );
  }
}
