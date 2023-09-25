import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:list_view_builder/msg_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController controller=TextEditingController();
  List<MsgModel> msgs=[];

  bool isVisible=true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text("List View Code"),backgroundColor: Colors.orange,actions: [
            InkWell(
              onTap: (){
                print("on/off");



                isVisible=!isVisible;

                setState(() {

                });

              },
              child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(isVisible?Icons.visibility_off:Icons.visibility)),
            )
          ],),
          body: _mainBody(),));
  }


  Widget _mainBody(){
    return Column(
      children: [

        Visibility(
            visible: isVisible,
            child: inputWidget()),
        getList(),


      ],
    );
  }

  Widget inputWidget(){
    return Container(
      padding: EdgeInsets.all(10),
      height: 65,
      child: Row(
        children: [
          sendButton(Colors.deepOrange,"left"),
          SizedBox(width: 10,),
          Expanded(
            child: TextField(
              controller: controller,
            ),
          ),
          SizedBox(width: 10,),
          sendButton(Colors.deepPurple,"right"),


        ],
      ),
    );
  }


  Widget sendButton(Color btnClr,String sender){
    return  InkWell(
      onTap: (){
        String msg=controller.text;
        print("msg : $msg");
        msgs.add(MsgModel(msg: msg, sender: sender,d: DateTime.now()));

        controller.clear();

        print("Msgs : ${msgs}" );
        
        setState(() {});
      },
      child: Container(
        height: 45,
        width: 45,
        child: Icon(Icons.send,color: Colors.white,size: 16,),
        decoration: BoxDecoration(
            color: btnClr,
            borderRadius: BorderRadius.circular(50)
        ),
      ),
    );
  }


  Widget getList(){
    return Expanded(child: Container(

     child: ListView.builder(

         itemCount: msgs.length,
         itemBuilder: (ctx,index){


       return msgItem(msgs[index]);

     }),

    ));
  }
  




  Widget msgItem(MsgModel model){
    
    return InkWell(

      onDoubleTap: (){
        print("double tap");

        msgs.remove(model);
        setState(() {});

      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.maxFinite,
            child: CachedNetworkImage(
                imageUrl: "https://picsum.photos/400/300",
                fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            width: double.maxFinite,
            child: Image.network(
              "https://picsum.photos/400/300",
              fit: BoxFit.fitWidth,
            ),
          ),
          Row(
            mainAxisAlignment: model.sender=="left"?MainAxisAlignment.start:MainAxisAlignment.end,
            children: [
              if(model.sender=="right")SizedBox(width: 100,),
              Flexible(
                child: Container(
                  margin: EdgeInsets.all(10),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: model.sender=="left"?Colors.deepOrange:Colors.deepPurple,
                  ),
                  padding: EdgeInsets.all(10),
                 child: Text("${model.msg} \n${model.d}",style: TextStyle(color: Colors.white),),

                ),
              ),
              if(model.sender=="left")SizedBox(width: 100,),
            ],
          ),
        ],
      ),
    );
    
  }
  

}
