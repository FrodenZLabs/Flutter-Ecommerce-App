import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/constant/images.dart';
import 'package:flutter_ecommerce_app/core/error/failures.dart';
import 'package:flutter_ecommerce_app/core/router/app_router.dart';
import 'package:flutter_ecommerce_app/domain/usecases/product/get_product_usecase.dart';
import 'package:flutter_ecommerce_app/presentation/blocs/filter/filter_cubit.dart';
import 'package:flutter_ecommerce_app/presentation/blocs/product/product_bloc.dart';
import 'package:flutter_ecommerce_app/presentation/blocs/user/user_bloc.dart';
import 'package:flutter_ecommerce_app/presentation/widgets/alert_card.dart';
import 'package:flutter_ecommerce_app/presentation/widgets/input_form_button.dart';
import 'package:flutter_ecommerce_app/presentation/widgets/product_card.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController scrollController = ScrollController();

  void _scrollListener(){
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;
    double scrollPercentage = 0.7;

    if(currentScroll > (maxScroll * scrollPercentage)){
      if (context.read<ProductBloc>().state is ProductLoaded) {
        context.read<ProductBloc>().add(const GetMoreProducts());
      }
    }
  }

  @override
  void initState() {
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(height: (MediaQuery.of(context).padding.top + 10),),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
                    if (state is UserLogged) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(AppRouter.userProfile, arguments: state.user,);
                                },
                                child: Text(
                                  "${state.user.firstName} ${state.user.lastName}",
                                  style: TextStyle(fontSize: 18.sp),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                            const Spacer(),
                            const SizedBox(width: 8,),
                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).pushNamed(AppRouter.userProfile, arguments: state.user,);
                              },
                              child: state.user.image != null ?
                                  CachedNetworkImage(
                                    imageUrl: state.user.image!,
                                    imageBuilder: (context, image) => CircleAvatar(
                                      radius: 18.sp,
                                      backgroundImage: image,
                                      backgroundColor: Colors.transparent,
                                    ),
                                    errorWidget: (context, url, error) => CircleAvatar(
                                      radius: 18.sp,
                                      backgroundImage: AssetImage(kUserAvatar),
                                      backgroundColor: Colors.transparent,
                                    ),
                                  )
                              : CircleAvatar(
                                radius: 18.sp,
                                backgroundImage: AssetImage(kUserAvatar),
                                backgroundColor: Colors.transparent,
                              ),
                            )
                          ],
                        ),
                      );
                    }  else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 8,),
                              Text("Welcome,",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.sp),),
                              Text("K-Labs Shop",style: TextStyle(fontWeight: FontWeight.normal, fontSize: 24.sp),),
                            ],
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).pushNamed(AppRouter.signIn);
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 24.0,
                                backgroundImage: AssetImage(kUserAvatar),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                          )
                        ],
                      );
                    }
                  }),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1.h, left: 6.w, right: 6.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: BlocBuilder<FilterCubit, FilterProductParams>(builder: (context, state) {
                          return TextField(
                            autocorrect: false,
                            controller: context.read<FilterCubit>().searchController,
                            onChanged: (val) => setState(() {}),
                            onSubmitted: (val) => context.read<ProductBloc>().add(GetProducts(FilterProductParams(keyword: val))),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 16.sp, bottom: 16.sp, top: 16.sp),
                              prefixIcon: const Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Icon(Icons.search),
                              ),
                              suffixIcon: context.read<FilterCubit>().searchController.text.isNotEmpty ?
                                Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: IconButton(
                                      onPressed: () {
                                        context.read<FilterCubit>().searchController.clear();
                                        context.read<FilterCubit>().update(keyword: '');
                                      },
                                      icon: Icon(Icons.clear)
                                  ),
                                ) : null,
                              border: OutlineInputBorder(),
                              hintText: "Search Product",
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white, width: 3.0),
                                borderRadius: BorderRadius.circular(16.sp)
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white, width: 3.0),
                                  borderRadius: BorderRadius.circular(16.sp)
                              )
                            ),
                          );
                        }),
                      ),
                      const SizedBox(width: 8,),
                      SizedBox(
                        width: 55,
                        child: BlocBuilder<FilterCubit, FilterProductParams>(builder: (context, state){
                          return Badge(
                            alignment: AlignmentDirectional.topEnd,
                            label: Text(context.read<FilterCubit>().getFiltersCount().toString(), style: TextStyle(color: Colors.black87),),
                            isLabelVisible: context.read<FilterCubit>().getFiltersCount() != 0,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: InputFormButton(
                              onClick: (){
                                Navigator.of(context).pushNamed(AppRouter.filter);
                              },
                              color: Colors.black87,
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 1.h,),
              ],
            ),
          ),
          Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
                  if (state is ProductLoaded && state.products.isEmpty) {
                    return AlertCard(
                      image: kEmpty,
                      message: "Products not found",
                    );
                  }

                  if (state is ProductError && state.products.isEmpty) {
                    if (state.failure is NetworkFailure) {
                      return AlertCard(
                        image: kNoConnection,
                        message: "Network failure\n Try again",
                        onClick: () {
                          context.read<ProductBloc>().add(
                              GetProducts(FilterProductParams(keyword: context.read<FilterCubit>().searchController.text))
                          );
                        },
                      );
                    }
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (state.failure is ServerFailure)
                            Image.asset(
                              'assets/status_image/internal-server-error.png',
                              width: MediaQuery.of(context).size.width * 0.7,
                            ),
                          if (state.failure is CacheFailure)
                            Image.asset(
                              'assets/status_image/no-connection.png',
                              width: MediaQuery.of(context).size.width * 0.7,
                            ),
                          Text("Products not found", style: TextStyle(color: Colors.grey.shade600),),
                          IconButton(
                              onPressed: () {
                                context.read<ProductBloc>().add(
                                    GetProducts(FilterProductParams(keyword: context.read<FilterCubit>().searchController.text))
                                );
                              },
                              icon: const Icon(Icons.refresh)
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
                        ],
                      ),
                    );
                  }

                  return RefreshIndicator(
                      child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 20,
                            childAspectRatio: 0.55
                          ),
                          controller: scrollController,
                          itemCount: state.products.length + ((state is ProductLoading) ? 10 : 0),
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.only(top: 18, left: 20, right: 20, bottom: (80 + MediaQuery.of(context).padding.bottom)),
                          itemBuilder: (BuildContext context, int index) {
                            if (state.products.length > index) {
                              return ProductCard(product: state.products[index],);
                            }  else {
                              return Shimmer.fromColors(
                                  baseColor: Colors.grey.shade100,
                                  highlightColor: Colors.white,
                                  child: const ProductCard()
                              );
                            }
                          }
                      ),
                      onRefresh: () async {
                        context.read<ProductBloc>().add(const GetProducts(FilterProductParams()));
                      }
                  );
                }),
              )
          )
        ],
      ),
    );
  }
}
