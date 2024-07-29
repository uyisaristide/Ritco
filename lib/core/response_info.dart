enum ResponseStatus {
  loading,
  failed,
  completed,
  none,
  saving,
  refreshing,
  empty,
  error,
  success
}

enum SellingMethod { asWhole, inSubUnits }

class Pagination {
  int currentPage;
  int lastPage;
  int itemsPerPage;
  int pageItems;
  int total;

  Pagination(
      {required this.currentPage,
        required this.lastPage,
        required this.itemsPerPage,
        required this.pageItems,
        required this.total});

  factory Pagination.fromJson(Map<String, dynamic> data) => Pagination(
      currentPage: data['currentPage'],
      lastPage: data['lastPage'],
      itemsPerPage: int.tryParse("${data['itemsPerPage']}") ?? 30,
      pageItems: data['pageItems'],
      total: data['total']);

  Map<String, dynamic> toJson() {
    return {
      'currentPage': currentPage,
      'lastPage': lastPage,
      'itemsPerPage': itemsPerPage,
      'pageItems': pageItems,
      'total': total,
    };
  }
}

class ResponseInfo<T> {
  String? token;
  String? message;
  DateTime? timestamp;
  List<String> errors;
  ResponseStatus status;
  int statusCode;
  bool requiresOtp;
  Pagination? pagination;

  T? data;

  String get errorMessage => message == null
      ? errors.isEmpty
      ? "Success"
      : errors[0]
      : message!;

  ResponseInfo(
      {this.token,
        this.message,
        this.timestamp,
        this.errors = const [],
        this.status = ResponseStatus.none,
        this.data,
        this.statusCode = 0,
        this.requiresOtp = false,
        this.pagination});

  factory ResponseInfo.from(ResponseInfo<T> info) => ResponseInfo(
      errors: info.errors,
      message: info.message,
      data: info.data,
      timestamp: info.timestamp,
      pagination: info.pagination,
      status: info.status,
      token: info.token,
      statusCode: info.statusCode,
      requiresOtp: info.requiresOtp);

  factory ResponseInfo.fromJson(Map<String, dynamic> data,
      {ResponseStatus status = ResponseStatus.none,
        T? defaultData,
        int code = 0}) =>
      ResponseInfo(
          token: data['token'],
          timestamp: data.containsKey("timestamp")
              ? DateTime.parse(data['timestamp'].replaceAll(",", ""))
              : DateTime.now(),
          message: data['message'],
          errors: data['errors'] == null ||
              !data['errors'].runtimeType.toString().contains("List")
              ? []
              : List<String>.from(data['errors']),
          requiresOtp: data['requiresOtp'] ?? false,
          status: status,
          data: defaultData,
          statusCode: code);
}
