import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/constant/images.dart';
import 'package:flutter_ecommerce_app/core/router/app_router.dart';
import 'package:flutter_ecommerce_app/presentation/blocs/user/user_bloc.dart';
import 'package:flutter_ecommerce_app/presentation/widgets/other_item_card.dart';
import 'package:sizer/sizer.dart';

class OtherView extends StatelessWidget {
  const OtherView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: BlocBuilder<UserBloc, UserState>(
                  builder: (context, state){
                    if (state is UserLogged) {
                      return GestureDetector(
                        onTap: (){
                          Navigator.of(context).pushNamed(AppRouter.userProfile, arguments: state.user);
                        },
                        child: Row(
                          children: [
                            state.user.image != null ?
                              CachedNetworkImage(
                                imageUrl: state.user.image!,
                                imageBuilder: (context, image) => CircleAvatar(
                                  radius: 24.sp,
                                  backgroundImage: image,
                                  backgroundColor: Colors.transparent,
                                ),
                                errorWidget: (context, url, error) => CircleAvatar(
                                  radius: 24.sp,
                                  backgroundImage: AssetImage(kUserAvatar),
                                  backgroundColor: Colors.transparent,
                                ),
                              )
                                : CircleAvatar(
                              radius: 24.sp,
                              backgroundImage: AssetImage(kUserAvatar),
                              backgroundColor: Colors.transparent,
                            ),
                            const SizedBox(width: 8,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${state.user.firstName} ${state.user.lastName}",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Text(state.user.email)
                              ],
                            )
                          ],
                        ),
                      );
                    }  else {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(AppRouter.signIn);
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 24.sp,
                              backgroundImage: AssetImage(kUserAvatar),
                              backgroundColor: Colors.transparent,
                            ),
                            const SizedBox(width: 8,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Login to your account",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    }
              }),
            ),
            SizedBox(height: 4.h),

            OtherItemCard(title: "Profile", onClick: () {}),
            const SizedBox(height: 6),
            OtherItemCard(title: "Orders", onClick: () {}),
            const SizedBox(height: 6),
            OtherItemCard(title: "Delivery Info", onClick: () {}),
            const SizedBox(height: 6),
            OtherItemCard(title: "Settings", onClick: () {}),
            const SizedBox(height: 6),
            OtherItemCard(title: "Notifications", onClick: () {}),
            const SizedBox(height: 6),
            OtherItemCard(title: "About", onClick: () {}),
            const SizedBox(height: 6),
            BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
              if (state is UserLogged) {
                return OtherItemCard(
                  title: "Sign Out",
                  onClick: () {
                      context.read<UserBloc>().add(SignOutUser());
                  },
                );
              }  else {
                return SizedBox();
              }
            }),
            const SizedBox(height: 50),

            SizedBox(height: MediaQuery.of(context).padding.bottom + 30),
          ],
        ),
      ),
    );
  }
}
