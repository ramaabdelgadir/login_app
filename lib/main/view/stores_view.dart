import 'package:flutter/material.dart';
import 'package:login_app/external/theme/app_colors.dart';
import 'package:login_app/main/controller/stores_controller.dart';
import 'package:login_app/stores/view/single_store_view.dart';

class StoresView extends StatelessWidget {
  StoresView({super.key});
  final StoresController _controller = StoresController();

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return BlocBuilder<StoresBloc, StoresState>(
      bloc: widget.controller.storesBloc,
      builder: (context, state) {
        switch(state.runtimeType){
          case StoresGetDataLoadingState:
            return Column(
               mainAxisAlignment: MainAxisAlignment.center,
                children: [
                CustomLoading(),
              ],
            );
          case StoresGetDataSuccessState:
           state = state as StoresGetDataSuccessState;
           final List storesList = state.storesList; 

            return Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              color: Colors.white,
              child: CustomScrollView(
                scrollDirection: Axis.vertical,
                slivers: <Widget>[
                  SliverToBoxAdapter(child: SizedBox(height: 20)),
                  SliverGrid.builder(
                    itemCount: storesList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                    ),
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () async{
                           await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SingleStoreView(storeModel: storesList[i],),
                            ),
                          );
                          
                        widget.controller.getStoresData();
                        },
                        child: CustomStoreCard(storeModel:storesList[i]),
                      );
                    },
                  ),
                ],
              ),
            );
          default:
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("an Error Occure"),
            ],
          )],);

        }
      },
=======
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      color: Colors.white,
      child: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: <Widget>[
          SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverGrid.builder(
            itemCount: 50,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemBuilder: (context, i) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SingleStoreView()),
                  );
                },
                child: CustomStoreCard(image: _controller.getRandomImage()),
              );
            },
          ),
        ],
      ),
>>>>>>> parent of 09f513f (still error in adding-to/removing-from favo)
    );
  }
}

class CustomStoreCard extends StatelessWidget {
  CustomStoreCard({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [BoxShadow(blurRadius: 0.5, color: Colors.black26)],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              image,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.storesCardColor.withOpacity(0.6),
            ),
          ),
          Positioned(
            bottom: 9,
            left: 8,
            right: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  //TODO: store name
                  "'Store Name'",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 14),
                    SizedBox(width: 4),
                    Text(
                      "4.5", //TODO: store rating
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
