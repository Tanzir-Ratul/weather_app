import 'package:flutter/material.dart';

class NetworkImageSet extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final String? errorImage;
  final double? height;
  final double? width;

  const NetworkImageSet({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.errorImage,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      height: height,
      width: width,
      imageUrl.trim(),
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return  const Icon(
          Icons.error, // You can choose a different icon here
          size: 20, // Customize the size of the icon
          color: Colors.red, // Customize the icon color
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child; // The image has loaded
        }
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
    );
  }
}
