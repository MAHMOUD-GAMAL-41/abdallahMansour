class CategoriesModel {
  late bool Status;
  late CategoriesDataModel data;

  CategoriesModel.FromJson(Map<String, dynamic> json) {
    Status = json['status'];
    data = CategoriesDataModel.FromJson(json['data']);
  }
}

class CategoriesDataModel {


  late String firstPageUrl, lastPageUrl;
  late int currentPage, from,lastPage;
  late List<DataModel> data=[];

  CategoriesDataModel.FromJson(Map<String, dynamic> json) {
    currentPage=json['current_page'];
    firstPageUrl=json['first_page_url'];
    lastPageUrl=json['last_page_url'];
    lastPage=json['last_page'];
    from=json['from']; 
    json['data'].forEach((element){
      data.add(DataModel.FromJson(element));
    });
  }
}

class DataModel{
  late String name,image;
  late int id;
  DataModel.FromJson(Map<String, dynamic> json){
    name = json['name'];
    id = json['id'];
    image = json['image'];
  }
}
