import 'package:flutter/material.dart';
import 'package:la_vie/view/resources/color_manager.dart';
import 'package:la_vie/view/resources/routes_manager.dart';
import 'package:la_vie/view/screens/blogs/single_blog_screen.dart';
import 'package:la_vie/view/widgets/components.dart';

import '../../resources/font_manager.dart';
import '../../resources/style_manager.dart';
import '../../resources/values_manager.dart';

class BlogsItem extends StatelessWidget {
  const BlogsItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(AppSize.borderRadius),
          onTap: () => navigateTo(context: context, widget: SingleBlogScreen()),
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.cardPadding),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSize.borderRadius),
                  child: SizedBox(
                    width: 146,
                    height: 133,
                    child: CustomNetworkImage(
                      image: 'widget.model.image',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Space(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '2 Days ago',
                        style: getMediumStyle(
                            fontSize: FontSize.f14,
                            color: ColorManager.primary),
                        maxLines: 1,
                      ),


                      Space(),
                      Text(
                        '5 Tips to treat plants',
                        style: getMediumStyle(fontSize: FontSize.f18),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Space(),
                      Text(
                        'leaf, in botany, any usually leaf, in botany, any usually ',
                        style: getMediumStyle(
                            fontSize: FontSize.f14,
                            color: ColorManager.grey),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
