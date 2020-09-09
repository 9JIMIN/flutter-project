import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DetailAppBar extends StatefulWidget {
  final title;
  final product;
  DetailAppBar(this.title, this.product);

  @override
  _DetailAppBarState createState() => _DetailAppBarState();
}

class _DetailAppBarState extends State<DetailAppBar> {
  int carousel = 0;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: widget.title ? Text('${widget.product.title}') : null,
      actions: [
        IconButton(
          icon: Icon(Icons.share),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {},
        ),
      ],
      expandedHeight: 300,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: widget.product.id,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                    enableInfiniteScroll: false,
                    viewportFraction: 1,
                    initialPage: 0,
                    aspectRatio: 1,
                    onPageChanged: (index, _) {
                      setState(() {
                        carousel = index;
                      });
                    }),
                items: widget.product.imageUrls.map<Widget>((url) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(url, fit: BoxFit.fitWidth),
                  );
                }).toList(),
              ),
              widget.product.imageUrls.length > 1
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: widget.product.imageUrls.map<Widget>((url) {
                        int index = widget.product.imageUrls.indexOf(url);
                        return Container(
                          width: 8.0,
                          height: 8.0,
                          margin: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 3,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: carousel == index
                                ? Colors.white
                                : Colors.white54,
                          ),
                        );
                      }).toList(),
                    )
                  : SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
