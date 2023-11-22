import 'package:flutter/material.dart';

class CommonLoadingPageDS extends StatelessWidget {
  final ValueNotifier<bool> isLoading;
  final Widget child;

  const CommonLoadingPageDS({
    required this.isLoading,
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        ValueListenableBuilder(
          valueListenable: isLoading,
          builder: (context, isLoading, child) => (isLoading)
              ? Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black38,
                  child: const CircularProgressIndicator(),
                )
              : const SizedBox(),
        ),
      ],
    );
  }
}
