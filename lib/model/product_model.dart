class ProductModel{
  String name;
  String code;
  int cant;
  DateTime createdAt;
  ProductModel({this.name, this.code, this.cant, this.createdAt});

 List<ProductModel> exampleData(){
     List<ProductModel> data = [
       new ProductModel(name: "Petroleo",code: "PT-89", cant: 40, createdAt: DateTime.now()),
       new ProductModel(name: "Petroleo",code: "PT-89", cant: 40, createdAt: DateTime.now()),
       new ProductModel(name: "Petroleo",code: "PT-89", cant: 40, createdAt: DateTime.now()),
       new ProductModel(name: "Petroleo",code: "PT-89", cant: 40, createdAt: DateTime.now()),
       new ProductModel(name: "Petroleo",code: "PT-89", cant: 40, createdAt: DateTime.now()),
       new ProductModel(name: "Petroleo",code: "PT-89", cant: 40, createdAt: DateTime.now()),
     ];

     return data;
  }
}