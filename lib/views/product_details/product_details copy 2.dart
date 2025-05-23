import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.productId,
    required this.price,
  });
  final String imageUrl, name, productId;
  final int price;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Material(
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: MySliverAppBar(expandedHeight: 200.0),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      listCardWidget(
                          text1: 'Full Name:', text2: 'George John Carter'),
                      listCardWidget(
                          text1: 'Father\'s Name:', text2: 'John Carter'),
                      listCardWidget(text1: 'Gender:', text2: 'Male'),
                      listCardWidget(text1: 'Marital Status:', text2: 'Single'),
                      listCardWidget(text1: 'Email:', text2: 'jane123@123.com'),
                      listCardWidget(text1: 'Username:', text2: 'misty123'),
                      listCardWidget(text1: 'Phone:', text2: '0987654321'),
                      listCardWidget(text1: 'Country', text2: 'India'),
                      listCardWidget(text1: 'City', text2: 'Hyderabad'),
                      listCardWidget(text1: 'Pincode:', text2: '500014'),
                      listCardWidget(text1: 'Company:', text2: 'All Shakes'),
                      listCardWidget(text1: 'Website:', text2: 'allshakes.com'),
                      listCardWidget(text1: 'Position', text2: 'Manager'),
                      listCardWidget(text1: 'LinkedIn Id:', text2: 'misty123'),
                      listCardWidget(
                          text1: 'Interest:', text2: 'Swimming,Cycling'),
                    ],
                  )),
            ]),
          )
        ],
      ),
    ));
  }

  Widget listCardWidget({required String text1, required text2}) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
                fit: FlexFit.tight,
                child: Text(
                  text1,
                  style: const TextStyle(fontSize: 18),
                )),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Text(
                text2,
                style: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MySliverAppBar({required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff8360c3),
                Color(0xff2ebf91),
              ],
            ),
          ),
        ),
        Positioned(
          left: 16,
          top: kToolbarHeight / 2 - shrinkOffset / 4,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Positioned(
          left: 16,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: Opacity(
              opacity: shrinkOffset / expandedHeight,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.asset(
                  'assets/shoe1.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        CircleAvatarWidget(
            expandedHeight: expandedHeight, shrinkOffset: shrinkOffset)
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class MySliverAppBars extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MySliverAppBars({required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff8360c3),
                Color(0xff2ebf91),
              ],
            ),
          ),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Opacity(
              opacity: shrinkOffset / expandedHeight,
              child: const Text(
                'My Profile',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 23,
                ),
              ),
            ),
          ),
        ),
        CircleAvatarWidget(
          expandedHeight: expandedHeight,
          shrinkOffset: shrinkOffset,
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class CircleAvatarWidget extends StatelessWidget {
  const CircleAvatarWidget({
    super.key,
    required this.expandedHeight,
    required this.shrinkOffset,
  });

  final double expandedHeight;
  final double shrinkOffset;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: expandedHeight / 4 - shrinkOffset,
      left: MediaQuery.of(context).size.width / 4,
      child: Opacity(
        opacity: (1 - shrinkOffset / expandedHeight),
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          child: SizedBox(
            height: expandedHeight,
            width: MediaQuery.of(context).size.width / 2,
            child: CircularProfileAvatar(
              '',
              radius: 100,
              backgroundColor: Colors.transparent,
              // borderColor: Colors.yellow,
              // borderWidth: 4,
              child: Image.asset(
                'assets/shoe1.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
