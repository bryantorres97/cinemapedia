import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
          color: themeColors.primary,
        );
    return SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            height: 50,
            width: double.infinity,
            child: Row(
              children: [
                Icon(
                  Icons.local_movies_outlined,
                  color: themeColors.primary,
                ),
                const SizedBox(width: 10),
                Text(
                  'Cinemapedia',
                  style: titleStyle,
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      color: themeColors.primary,
                    )),
              ],
            ),
          ),
        ));
  }
}
