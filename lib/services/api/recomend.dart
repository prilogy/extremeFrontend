part of api;


Future<dynamic> Recomended(int page, int pageSize) async{
  Map<String,int> data = Map<String,int>();
      data['page']= page;
      data['pageSize'] = pageSize;
  var response = await dio.get(
    '/video/recommended',
    options: Options(headers: {
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjYiLCJyb2xlIjoidXNlciIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvZXhwaXJhdGlvbiI6IjgvMTQvMjAyMCA1OjUwOjMzIFBNIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbG9jYWxpdHkiOiJydSIsIkN1cnJlbmN5IjoiRVVSIiwibmJmIjoxNTk1Njc3MTk5LCJleHAiOjE1OTYyODE5OTksImlhdCI6MTU5NTY3NzE5OX0.n2IciappLewea8TNLpSrvbaRO6hpjdsqSVfwMvPdM58",
    }),
    queryParameters: data,
  );
  //int videoId = response.data[0]['id'];
  int videoId = 3;

  /* Возврат всех рекомендаций */
  // return response.data; 
  /* */
  var model = await dio.get(
    '/video/' + videoId.toString(),
    options: Options(headers: {
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjYiLCJyb2xlIjoidXNlciIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvZXhwaXJhdGlvbiI6IjgvMTQvMjAyMCA1OjUwOjMzIFBNIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbG9jYWxpdHkiOiJydSIsIkN1cnJlbmN5IjoiRVVSIiwibmJmIjoxNTk1Njc3MTk5LCJleHAiOjE1OTYyODE5OTksImlhdCI6MTU5NTY3NzE5OX0.n2IciappLewea8TNLpSrvbaRO6hpjdsqSVfwMvPdM58",
    }),
  );
  print(model.data);
  return model.data;
}