part of api;



class Helper {
  static Future<List<Models.Content>> getBanner() async{
      try{
        var response = await dio.get('/helper/banner');
      // print('getbanner print (data[entity][content]): \n ' + response.data[0]['entity']['content'].toString());
       var entity = response.data[0]['entity'];
        var entities = List<Models.Content>();
      response.data.forEach((v) {
         print('content: \n' + v.toString());
        entities.add(Models.Content.fromJson(v['entity']['content']));
      });
        return entities;

      } on DioError catch (e) {
      print(e);
      return null;
    }
  }
}