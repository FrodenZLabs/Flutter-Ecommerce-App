import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/core/router/app_router.dart';
import 'package:flutter_ecommerce_app/domain/entities/cart/cart_item.dart';
import 'package:flutter_ecommerce_app/domain/entities/product/price_tag.dart';
import 'package:flutter_ecommerce_app/domain/entities/product/product.dart';
import 'package:flutter_ecommerce_app/presentation/blocs/cart/cart_bloc.dart';
import 'package:flutter_ecommerce_app/presentation/widgets/input_form_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsView extends StatefulWidget {
  final Product product;

  const ProductDetailsView({super.key, required this.product});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  int _currentIndex = 0;
  late PriceTag _selectedPriceTag;

  @override
  void initState() {
    _selectedPriceTag = widget.product.priceTags.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.message)),
          IconButton(onPressed: () {}, icon: Icon(Icons.share)),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: SizedBox(
              height: MediaQuery.of(context).size.width,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: double.infinity,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                items: widget.product.images.map((image) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Hero(
                        tag: widget.product.id,
                        child: CachedNetworkImage(
                          imageUrl: image,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.contain,
                                colorFilter: ColorFilter.mode(
                                  Colors.grey.shade50.withOpacity(0.5),
                                  BlendMode.softLight,
                                ),
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                            ),
                          ),
                          errorWidget: (context, url, error) => const Center(
                            child: Icon(
                              Icons.error_outline,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Align(
              alignment: Alignment.center,
              child: AnimatedSmoothIndicator(
                activeIndex: _currentIndex,
                count: widget.product.images.length,
                effect: ScrollingDotsEffect(
                  dotColor: Colors.grey.shade300,
                  maxVisibleDots: 7,
                  activeDotColor: Colors.grey,
                  dotHeight: 6,
                  dotWidth: 6,
                  activeDotScale: 1.1,
                  spacing: 6,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 14,
              top: 20,
              bottom: 4,
            ),
            child: Text(
              widget.product.name,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Wrap(
              children: widget.product.priceTags
                  .map(
                    (priceTag) => GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedPriceTag = priceTag;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: _selectedPriceTag.id == priceTag.id
                                ? 2.0
                                : 1.0,
                            color: Colors.grey,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(right: 4),
                        child: Column(
                          children: [
                            Text(priceTag.name),
                            Text("Kshs. ${priceTag.price.toString()}"),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 10,
              top: 16,
              bottom: MediaQuery.of(context).padding.bottom,
            ),
            child: Text(
              widget.product.description,
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Theme.of(context).colorScheme.primary,
        height: 80 + MediaQuery.of(context).padding.bottom,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + 10,
          top: 10,
          left: 20,
          right: 20,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Total",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                Text(
                  'Kshs. ${_selectedPriceTag.price}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: 120,
              child: InputFormButton(
                onClick: () {
                  context.read<CartBloc>().add(
                    AddProduct(
                      cartItem: CartItem(
                        product: widget.product,
                        priceTag: _selectedPriceTag,
                      ),
                    ),
                  );
                  Navigator.of(context).pop();
                },
                titleText: "Add to Cart",
                color: Colors.amberAccent.shade700,
              ),
            ),
            const SizedBox(width: 6),
            SizedBox(
              width: 90,
              child: InputFormButton(
                onClick: () {
                  Navigator.of(context).pushNamed(
                    AppRouter.orderCheckout,
                    arguments: [
                      CartItem(
                        product: widget.product,
                        priceTag: _selectedPriceTag,
                      ),
                    ],
                  );
                },
                titleText: "Buy",
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
