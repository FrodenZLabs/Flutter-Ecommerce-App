import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/domain/entities/cart/cart_item.dart';
import 'package:shimmer/shimmer.dart';

class CartItemCard extends StatelessWidget {
  final CartItem? cartItem;
  final Function()? onFavouriteToggle;
  final Function()? onClick;
  final Function()? onLongCLick;
  final bool isSelected;

  const CartItemCard({super.key, this.cartItem, this.onFavouriteToggle, this.onClick, this.onLongCLick, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: cartItem == null
          ? Shimmer.fromColors(
          baseColor: Colors.grey.shade100,
          highlightColor: Colors.white,
          child: buildBody(context)
      ) : buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      onLongPress: onLongCLick,
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.grey.shade50, blurRadius: 1)]
                ),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Card(
                    color: Colors.white,
                    elevation: 2,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: cartItem == null
                    ? Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Container(color: Colors.grey.shade300,),
                    )
                        : Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: CachedNetworkImage(
                        imageUrl: cartItem!.product.images.first,
                        placeholder: (context, url) => Container(color: Colors.white,),
                        errorWidget: (context, url, error) => const Center(child: Icon(Icons.error),),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(4, 8, 4, 0),
                        child: SizedBox(
                          child: cartItem == null
                          ? Container(
                            width: 150,
                            height: 18,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8)
                            ),
                          ) : SizedBox(
                            child: Text(
                              cartItem!.product.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 18,
                              child: cartItem == null
                              ? Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(8)
                                ),
                              )
                              : Text(
                                "Kshs. ${cartItem!.priceTag.price.toString()}",
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
              )
            ],
          )
        ],
      ),
    );
  }
}
