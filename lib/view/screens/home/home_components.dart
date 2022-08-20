import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/model/cart/cart_Model.dart';
import 'package:la_vie/view/resources/assets_manager.dart';
import 'package:la_vie/view/resources/style_manager.dart';
import 'package:la_vie/view/resources/values_manager.dart';
import 'package:la_vie/view/screens/authorize/verify_otp_screen.dart';
import 'package:la_vie/view/screens/view_product/view_product_screen.dart';
import 'package:la_vie/view/widgets/components.dart';
import 'package:la_vie/view_model/app/functions.dart';
import 'package:la_vie/view_model/authorize_cubit/authorize_cubit.dart';
import 'package:la_vie/view_model/cart_cubit/cart_cubit.dart';
import 'package:la_vie/view_model/cart_cubit/cart_cubit.dart';
import 'package:la_vie/view_model/shared_pref/cache_helper.dart';
import 'package:la_vie/view_model/shared_pref/cache_manager.dart';
import '../../../model/home/plant_model.dart';
import '../../../model/home/product_model.dart';
import '../../../model/home/seed_model.dart';
import '../../../model/home/tool_model.dart';
import '../../../view_model/dio_network/end_points.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/string_manager.dart';
import '../../widgets/components.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../navigation_screen.dart';

class HomeCard extends StatefulWidget {
  var data;

  HomeCard({Key? key, required this.data}) : super(key: key);

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    var type;

    if (widget.data.type == 'PLANT') {
      type = widget.data.plant;
    } else if (widget.data.type == 'SEED') {
      type = widget.data.seed;
    } else if (widget.data.type == 'TOOL') {
      type = widget.data.tool;
    }

    return Card(
      child: InkWell(
        onTap: () async{
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  ViewProductScreen(data: widget.data, quantity: count)),
          );
            setState((){

            count = result;
            });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CustomNetworkImage(image: type.imageUrl!),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.cardPadding,
                  right: AppPadding.cardPadding,
                  bottom: AppPadding.cardPadding),
              child: Column(
                children: [
                  Space(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${type.name!.toUpperCase()} ",
                      style: getMediumStyle(color: ColorManager.black),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Space(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          '${widget.data.price} EGP    '.toUpperCase(),
                          style: getRegularStyle(fontSize: FontSize.f14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: ColorManager.greyLight,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            if (count > 0) {
                              setState(() {
                                count--;
                              });
                            }
                          },
                          icon: const Icon(
                            Icons.remove,
                            color: ColorManager.grey,
                            size: 14,
                          ),
                        ),
                      ),
                      Text(
                        '  $count  ',
                        style: getMediumStyle(fontSize: FontSize.f14),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: ColorManager.greyLight,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            setState(() {
                              count++;
                            });
                          },
                          icon: const Icon(
                            Icons.add,
                            color: ColorManager.grey,
                            size: 14,
                          ),
                          color: ColorManager.greyLight,
                        ),
                      ),
                    ],
                  ),
                  Space(),
                  BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                    CartCubit cartCubit = BlocProvider.of(context);
                      return Center(
                          child: CustomButton(
                            text: 'Add To Card',
                            function: () {
                              cartCubit.addToCart(
                                CartModel(
                                  id: widget.data.productId,
                                  name: type.name,
                                  image: type.imageUrl,
                                  price: widget.data.price,
                                  count: count,
                                ),
                              );
                              //print(cartCubit.cartList.length);
                            },
                            fontSize: FontSize.f14,
                            height: 35,
                          ));
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class SeedCard extends StatelessWidget {
//   Seed seed;
//
//   SeedCard({Key? key, required this.seed}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return CardBody(name: '${seed.name}', image: '${seed.imageUrl}');
//   }
// }
//
// class ToolCard extends StatelessWidget {
//   Tool tool;
//
//   ToolCard({Key? key, required this.tool}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return CardBody(name: '${tool.name}', image: '${tool.imageUrl}');
//   }
// }
//
// class CardBody extends StatelessWidget {
//   String name, image;
//
//   CardBody({required this.name, required this.image, Key? key})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: InkWell(
//         //onTap: () => navigateTo(context: context, widget: ViewProductScreen(data: ,)),
//         child: Padding(
//           padding: const EdgeInsets.all(AppPadding.cardPadding),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Expanded(
//                 child: CustomNetworkImage(image: image),
//               ),
//               Space(),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   name.toUpperCase(),
//                   style: getMediumStyle(color: ColorManager.black),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               Space(),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: Text(
//                       '70 EGP    '.toUpperCase(),
//                       style: getRegularStyle(fontSize: FontSize.f14),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       color: ColorManager.greyLight,
//                       borderRadius: BorderRadius.circular(2),
//                     ),
//                     child: IconButton(
//                       padding: EdgeInsets.zero,
//                       constraints: const BoxConstraints(),
//                       onPressed: () {},
//                       icon: const Icon(
//                         Icons.remove,
//                         color: ColorManager.grey,
//                         size: 16,
//                       ),
//                     ),
//                   ),
//                   Text(
//                     '  1  ',
//                     style: getMediumStyle(color: ColorManager.black),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       color: ColorManager.greyLight,
//                       borderRadius: BorderRadius.circular(2),
//                     ),
//                     child: IconButton(
//                       padding: EdgeInsets.zero,
//                       constraints: const BoxConstraints(),
//                       onPressed: () {},
//                       icon: const Icon(
//                         Icons.add,
//                         color: ColorManager.grey,
//                         size: 16,
//                       ),
//                       color: ColorManager.greyLight,
//                     ),
//                   ),
//                 ],
//               ),
//               Space(),
//               Center(
//                   child: CustomButton(
//                 text: 'Add To Card',
//                 function: () {},
//                 fontSize: FontSize.f16,
//                 height: 35,
//               ))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
