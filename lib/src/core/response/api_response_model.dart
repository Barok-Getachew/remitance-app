class ApiResponseModel<T> {
  static U fromJson<U>(
      Map<String, dynamic> json, U Function(Map<String, dynamic>) fromJsonU) {
    return fromJsonU(json['data']);
  }

  static List<U> fromJsonList<U>(
      Map<String, dynamic> json, U Function(Map<String, dynamic>) fromJsonU) {
    List<U> list = [];
    for (var jsonItem in json['data']) {
      list.add(fromJsonU(jsonItem));
    }
    return list;
  }
}
