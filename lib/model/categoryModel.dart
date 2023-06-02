class CategoryModel {
  String id;
  String title;

  CategoryModel({required this.id, required this.title});

  factory CategoryModel.fromJson(Map map) {
    return CategoryModel(id: map['id'], title: map['title']);
  }
}
