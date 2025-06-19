import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/domain/usecases/product/get_product_usecase.dart';
import 'package:flutter_ecommerce_app/presentation/blocs/category/category_bloc.dart';
import 'package:flutter_ecommerce_app/presentation/blocs/filter/filter_cubit.dart';
import 'package:flutter_ecommerce_app/presentation/blocs/product/product_bloc.dart';
import 'package:flutter_ecommerce_app/presentation/widgets/input_form_button.dart';
import 'package:flutter_ecommerce_app/presentation/widgets/input_range_slider.dart';

class FilterView extends StatelessWidget {
  const FilterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter"),
        actions: [
          IconButton(
              onPressed: (){
                context.read<FilterCubit>().reset();
              },
              icon: Icon(Icons.refresh)
          )
        ],
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 10),
            child: Text(
              "Categories",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              return ListView.builder(
                shrinkWrap: true,
                  itemCount: state.categories.length,
                  physics: NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  itemBuilder: (context, index) => Row(
                    children: [
                      Text(
                        state.categories[index].name,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      BlocBuilder<FilterCubit, FilterProductParams>(
                          builder: (context, filterState) {
                            return Checkbox(
                                value: filterState.categories.contains(state.categories[index]) || filterState.categories.isEmpty,
                                onChanged: (bool? value) {
                                  context.read<FilterCubit>().updateCategory(category: state.categories[index]);
                                }
                            );
                          }
                      )
                    ],
                  )
              );
            }
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 10),
            child: Text(
              "Price Range",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          BlocBuilder<FilterCubit, FilterProductParams>(
            builder: (context, state) {
              return InputRangeSlider(initMax: 1000, initMin: 100);
            }
          )
        ],
      ),
      bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Builder(
                builder: (context){
                  return InputFormButton(
                    onClick: (){
                      context.read<ProductBloc>().add(GetProducts(context.read<FilterCubit>().state));
                      Navigator.of(context).pop();
                    },
                    color: Colors.black87,
                    titleText: "Continue",
                  );
                }
            ),
          ),
      ),
    );
  }
}
