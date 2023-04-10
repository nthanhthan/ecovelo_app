class BasePaginationReq<T> {
  T? request;
  int page;
  int size;

  BasePaginationReq({
    this.request,
    this.page = 1,
    this.size = 12,
  });

  void onLoadingMore() => page++;

  void onRefresh() => page = 1;

  void onLoadMoreFailed() {
    if (page > 1) {
      page--;
    }
  }

  Map<String, dynamic> toRequest(Map<String, dynamic>? moreData) {
    Map<String, dynamic> requestData = <String, dynamic>{
      "page": page,
      "per_page": size,
    };
    if (moreData != null) {
      requestData.addAll(moreData);
    }
    return requestData;
  }
}
