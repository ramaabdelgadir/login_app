import 'package:flutter/material.dart';
import 'package:login_app/external/theme/app_colors.dart';

class SingleStoreView extends StatefulWidget {
  const SingleStoreView({super.key});

  @override
  State<SingleStoreView> createState() => _SingleStoreViewState();
}

class _SingleStoreViewState extends State<SingleStoreView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12))),
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        title: Text(
              "'Store Titile'",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
      leading: IconButton(onPressed: ()=>Navigator.pop(context), icon: Icon(Icons.arrow_back,color: Colors.white,))
,      actions: [
          ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset('assets/images/logo.png', height: 50),
           ),    
            ],
      ),
    );
  }
}