import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/constant/images.dart';
import 'package:flutter_ecommerce_app/presentation/widgets/other_item_card.dart';
import 'package:sizer/sizer.dart';

class OtherView extends StatelessWidget {
  const OtherView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: GestureDetector(
              onTap: (){},
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24.sp,
                    backgroundImage: AssetImage(kUserAvatar),
                    backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(width: 12,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Bobby Max", style: Theme.of(context).textTheme.titleLarge,),
                      Text("email@example.com", style: Theme.of(context).textTheme.titleLarge,),
                    ],
                  )
                ],
              ),
            ),

            // child: GestureDetector(
            //   onTap: (){},
            //   child: Row(
            //     children: [
            //       CircleAvatar(
            //         radius: 24.sp,
            //         backgroundColor: Colors.transparent,
            //         backgroundImage: AssetImage(kUserAvatar),
            //       ),
            //       const SizedBox(width: 12,),
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text("Login to account", style: Theme.of(context).textTheme.titleLarge,),
            //         ],
            //       )
            //     ],
            //   ),
            // ),
          ),
          SizedBox(height: 2.5.h,),
          OtherItemCard(
            title: "Profile",
            onClick: (){},
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: OtherItemCard(
              title: "Orders",
              onClick: (){},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: OtherItemCard(
              title: "Delivery Info",
              onClick: (){},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: OtherItemCard(
              title: "Settings",
              onClick: (){},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: OtherItemCard(
              title: "Notifications",
              onClick: (){},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: OtherItemCard(
              title: "About",
              onClick: (){},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: OtherItemCard(
              title: "Sign Out",
              onClick: (){},
            ),
          ),
          SizedBox(height: (MediaQuery.of(context).padding.bottom + 50),)
        ],
      ),
    );
  }
}
