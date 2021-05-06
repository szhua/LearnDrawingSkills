import 'package:flutter/material.dart';

var routes = {
  "app1": MyApp(),
};

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    onGenerateRoute: (settings) {
      if (routes[settings.name] != null) {
        return MaterialPageRoute(
          builder: (context) {
            return MyApp();
          },
          settings: settings,
        );
      }
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => Scaffold(
          body: Center(
            child: Text("404"),
          ),
        ),
      );
    },
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState2();
  }
}

class MyAppState2 extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              pinned: true,
              delegate: SliverCustomHeaderDelegate(
                  collapsedHeight: 50,
                  expandedHeight: 200,
                  coverImgUrl: "assets/test.jpeg",
                  title: "This is Tilte",
                  paddingTop: MediaQuery.of(context).padding.top)),
          SliverList(delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Container(
                height: 40,
                color: Colors.primaries[index % Colors.primaries.length],
              );
            },
          ))
        ],
      ),
    );
  }
}

class MyAppState extends State<MyApp> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var tabbarcontroller = TabController(length: 2, vsync: this);

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
              title: Text("This is Title"),
              background: Container(
                width: double.infinity,
                child: Image.asset("assets/test.jpeg"),
              )),
        ),
        SliverPersistentHeader(
          // 可以吸顶的TabBar
          pinned: true,
          delegate: StickyTabBarDelegate(
              TabBar(
                labelColor: Colors.black,
                controller: tabbarcontroller,
                tabs: <Widget>[
                  Tab(text: 'Home'),
                  Tab(text: 'Profile'),
                ],
              ),
              tabbarcontroller),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return Container(
            height: 40,
            color: Colors.primaries[index % Colors.primaries.length],
          );
        }, childCount: 100))
      ],
    ));
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabController tabController;
  final TabBar child;
  StickyTabBarDelegate(this.child, this.tabController);

  @override
  double get minExtent => child.preferredSize.height;

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      Container(
        color: Colors.white,
        child: child,
      );
}

class SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double collapsedHeight;
  final double expandedHeight;
  final double paddingTop;
  final String coverImgUrl;
  final String title;

  SliverCustomHeaderDelegate({
    this.collapsedHeight,
    this.expandedHeight,
    this.paddingTop,
    this.coverImgUrl,
    this.title,
  });

  Color makeStickyHeaderBgColor(shrinkOffset) {
    final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255)
        .clamp(0, 255)
        .toInt();
    return Color.fromARGB(alpha, 255, 255, 255);
  }

  Color makeStickyHeaderTextColor(shrinkOffset, isIcon) {
    if (shrinkOffset <= 50) {
      return isIcon ? Colors.white : Colors.transparent;
    } else {
      final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255)
          .clamp(0, 255)
          .toInt();
      return Color.fromARGB(alpha, 0, 0, 0);
    }
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: this.maxExtent,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // 背景图
          Container(
            child: Image.asset(this.coverImgUrl, fit: BoxFit.cover),
            width: double.infinity,
          ),
          // 收起头部
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              color: this.makeStickyHeaderBgColor(shrinkOffset), // 背景颜色
              child: SafeArea(
                bottom: false,
                child: Container(
                  height: this.collapsedHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      if (!Navigator.canPop(context))
                        Container()
                      else
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: this.makeStickyHeaderTextColor(
                                shrinkOffset, true), // 返回图标颜色
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      Text(
                        this.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: this.makeStickyHeaderTextColor(
                              shrinkOffset, false), // 标题颜色
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.share,
                          color: this.makeStickyHeaderTextColor(
                              shrinkOffset, true), // 分享图标颜色
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed("app1");
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => this.expandedHeight;

  @override
  double get minExtent => this.collapsedHeight + paddingTop;

  @override
  bool shouldRebuild(covariant SliverCustomHeaderDelegate oldDelegate) {
    return this.collapsedHeight != oldDelegate.collapsedHeight &&
        this.expandedHeight != oldDelegate.expandedHeight &&
        this.title != oldDelegate.title &&
        this.coverImgUrl != oldDelegate.coverImgUrl &&
        this.paddingTop != oldDelegate.paddingTop;
  }
}

class A {
  void refr() {}

  String name;
}
