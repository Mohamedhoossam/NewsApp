import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news/webview/webview.dart';

Widget DefultButton({
  Color background=Colors.blue,
  double width=double.infinity,
  required String text,
  required VoidCallback function,
  double radius =0.0,
  bool isUpperCase=true,})=>Container(

  width: width,
  child:
  MaterialButton(onPressed:function,
    child: Text(isUpperCase?text.toUpperCase():text,style: const TextStyle(fontSize: 25.0,fontStyle: FontStyle.normal,color: Colors.white),),),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: background,
  ),
);

Widget DefultTextFormFiled({
  double radius =10.0,
  IconData?  prefix,
  IconData?  suffix,
  String? labelText,hintText,
  FormFieldValidator<String>? validate,
  TextInputType? type,
  TextEditingController? control,
  VoidCallback? onpress,
  Color labelColor=Colors.grey,
  double labelFontSize=15,
  String? labelFontFamily,
  FontWeight? fontweight,
  bool scure = false,
  bool lockKeyboard=false,
  GestureTapCallback? ontap,
  ValueChanged<String>? change,
  required BuildContext context,

})=>  TextFormField(
  decoration:InputDecoration(
    border: const OutlineInputBorder(
      // borderSide: BorderSide(color: Colors.amberAccent,width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(20.0),),


    ),


    //علشان لما يحصل خطء اغير اللون بشكل معين
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),


    //    علشان لما ادخل بيلنات اغير لون الخط
    // focusedBorder: OutlineInputBorder(
    //   borderSide: BorderSide(color: Colors.amber.shade700, width: 1.0),
    //   borderRadius: BorderRadius.all(Radius.circular(10.0)),
    // ),


    prefixIcon: Icon(prefix,),
    suffixIcon: suffix!=null?IconButton(onPressed: onpress, icon: Icon(suffix)):null,
    labelText: labelText,
    labelStyle: TextStyle(color:labelColor,fontSize:labelFontSize,fontFamily:labelFontFamily,  ),

    hintText :hintText,
    //counterStyle:const TextStyle(color: Colors.red) ,
    hintStyle: TextStyle(color:labelColor,fontSize:labelFontSize,fontFamily:labelFontFamily,fontWeight: fontweight  ),




  ) ,
  keyboardType: type,
  controller:control ,
  validator: validate,
  obscureText: scure,
  style: Theme.of(context).textTheme.bodyText1,
  readOnly: lockKeyboard,
  onTap:ontap ,
  onChanged: change,

  //strutStyle: ,



);


Widget  separator()=>Padding(
  padding: const EdgeInsetsDirectional.only(start: 20.0),
  child: Container(
    color: Colors.grey,
    width: double.infinity,
    height: 1.0,
  ),
);
void navigateTo(context,widget)=>Navigator.push(

  context, MaterialPageRoute(
  builder: (context)=>widget,
),



);
Widget screenBuilder( list,context,{ isSearch=false,required RefreshCallback refresh,required Key key,})=>ConditionalBuilder(
  condition:list.isNotEmpty ,
  builder:(context)=> RefreshIndicator(


    onRefresh: ()=>refresh(),
    triggerMode:RefreshIndicatorTriggerMode.anywhere ,
    edgeOffset: 10,
    key: key,
    child: ListView.separated(
      itemBuilder: (context,index)=> InkWell(
        onTap: (){
         navigateTo(context,  WebViewScreen(list[index]['url']));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),

          child: SizedBox(
            height: 170.0,
            //width: 150.0,
            child: Row(
              children:  [
                Container(
                  width: 120.0,
                  height: 120.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image:  DecorationImage(
                          image: NetworkImage('${list[index]['urlToImage']==null?list[index]['urlToImage']='https://www.generationsforpeace.org/wp-content/uploads/2018/07/empty.jpg':list[index]['urlToImage']=list[index]['urlToImage']}'),
                          fit: BoxFit.cover
                      )
                  ),

                ),
                const SizedBox(width: 10.0,),
                Expanded(
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Expanded(child:
                      Text(list[index]['title'],
                        style: Theme.of(context).textTheme.bodyText1,
                        )
                        ,),
                       Text(list[index]['publishedAt'],style: const TextStyle(color: Colors.grey),),

                    ],),
                )



              ],
            ),
          ),
        ),
      ),
      separatorBuilder:(context,index)=> separator(),
      itemCount: list.length,
      physics:const BouncingScrollPhysics() ,
    ),
  ),

  fallback:(context)=>isSearch?Container():const Center(child: CircularProgressIndicator()) ,

);
Widget screenBuilder1( list,context,{ isSearch=false})=>ConditionalBuilder(
  condition:list.isNotEmpty ,
  builder:(context)=> ListView.separated(
    itemBuilder: (context,index)=> InkWell(
      onTap: (){
        navigateTo(context,  WebViewScreen(list[index]['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),

        child: Container(
          height: 170.0,
          //width: 150.0,
          child: Row(
            children:  [
              Container(
                width: 120.0,
                height: 120.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image:  DecorationImage(
                        image: NetworkImage('${list[index]['urlToImage']==null?list[index]['urlToImage']='https://www.generationsforpeace.org/wp-content/uploads/2018/07/empty.jpg':list[index]['urlToImage']=list[index]['urlToImage']}'),
                        fit: BoxFit.cover
                    )
                ),

              ),
              const SizedBox(width: 10.0,),
              Expanded(
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Expanded(child:
                    Text(list[index]['title'],
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                      ,),
                    Text(list[index]['publishedAt'],style: const TextStyle(color: Colors.grey),),

                  ],),
              )



            ],
          ),
        ),
      ),
    ),
    separatorBuilder:(context,index)=> separator(),
    itemCount: list.length,
    physics:const BouncingScrollPhysics() ,
  ),

  fallback:(context)=>isSearch?Container():const Center(child: CircularProgressIndicator()) ,

);


