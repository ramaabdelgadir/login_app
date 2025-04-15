import 'package:flutter/material.dart';
import 'package:login_app/external/theme/app_colors.dart';
import 'package:login_app/main/controller/stores_controller.dart';
import 'package:login_app/stores/view/single_store_view.dart';

class StoresView extends StatelessWidget {
  
  StoresView({super.key});
  final StoresController _controller= StoresController(); 
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      color: Colors.white,
      child: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: 
               Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                 children: [
                  SizedBox(height: 20),
                   Container(
                           height : 200,
                           width : 200,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.all(Radius.circular(25),
                             ),
                             boxShadow: [
                               BoxShadow(blurRadius: 0.5,color: Colors.black26)
                             ]
                   
                           ),
                           child:Stack(children: [
                             Container(
                               height: 200,
                               width: double.infinity,
                               child: ClipRRect(
                                 borderRadius: BorderRadius.circular(25),
                                 child: Image.network(_controller.getRandomImage(),fit: BoxFit.cover,)),
                             ),
                             Container(height: 200,width: double.infinity,
                             decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: AppColors.storesCardColor.withOpacity(0.6),),

                             ),
                             Container(height: 200,width: double.infinity,
                             child: Center(child: Text("'Store Name'",style: TextStyle(color: Colors.white,fontSize: 16),),),
                             )
                           ]
                   ) ,
                         ),
                         SizedBox(height: 5,)
                 ],
               )
          
          ),
        SliverGrid.builder(
          itemCount: 50,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 2,
            mainAxisSpacing:2 ), itemBuilder: (context,i){
          return    InkWell( 
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SingleStoreView()));
              
            },
            child: CustomStoreCard(
              image: _controller.getRandomImage(),
            ),
          ) ;
        })
        ],
      ),
    );
    
}
}

class CustomStoreCard extends StatelessWidget {
   CustomStoreCard({
    super.key,
    required this.image
  });
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
        height : double.infinity,
        width : double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(blurRadius: 0.5,color: Colors.black26)
          ]

        ),
        child:Stack(children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(image,fit: BoxFit.cover,)),
          ),
          Container(height: double.infinity,width: double.infinity,
          decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(15),
            color:  AppColors.storesCardColor.withOpacity(0.6),),
          ),
          Container(height: double.infinity,width: double.infinity,
          child: Center(child: Text("'Store Name'",style: TextStyle(color: Colors.white,fontSize: 16),),),
          )
        ]
) ,
      );
  }
}