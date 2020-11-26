import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:soedja_freelance/revamp/modules/category/models/category_model.dart';
import 'package:soedja_freelance/revamp/modules/feeds/bloc/feed_state.dart';
import 'package:soedja_freelance/revamp/modules/feeds/models/feeds_model.dart';
import 'package:soedja_freelance/revamp/modules/feeds/services/feeds_services.dart';

class FeedBloc extends FeedServices {
  FeedServices feedServices = new FeedServices();

  BehaviorSubject<GetListFeedState> _subjectGetList =
      BehaviorSubject<GetListFeedState>();

  BehaviorSubject<LikeListState> _subjectLikeList =
      BehaviorSubject<LikeListState>();

  BehaviorSubject<BookmarkListState> _subjectBookmarkList =
      BehaviorSubject<BookmarkListState>();
  BehaviorSubject<SearchListState> _subjectSearchList =
      BehaviorSubject<SearchListState>();
  BehaviorSubject<VideoListState> _subjectVideoList =
      BehaviorSubject<VideoListState>();
  BehaviorSubject<GetExploreState> _subjectGetExplore =
      BehaviorSubject<GetExploreState>();
  BehaviorSubject<UpdateInterestState> _subjectInterest =
      BehaviorSubject<UpdateInterestState>();
  BehaviorSubject<BannerStudioState> _subjectBannerStudio =
      BehaviorSubject<BannerStudioState>();
  BehaviorSubject<PortfolioListState> _subjectPortfolioList =
      BehaviorSubject<PortfolioListState>();
  BehaviorSubject<UpdateViewerState> _subjectPortfolioViewer =
      BehaviorSubject<UpdateViewerState>();
  BehaviorSubject<PortfolioDetailState> _subjectPortfolioDetail =
      BehaviorSubject<PortfolioDetailState>();

  Stream<GetListFeedState> get getList => _subjectGetList.stream;

  Stream<LikeListState> get getLikes => _subjectLikeList.stream;

  Stream<BookmarkListState> get getBookmarks => _subjectBookmarkList.stream;

  Stream<SearchListState> get getSearchList => _subjectSearchList.stream;

  Stream<VideoListState> get getVideoList => _subjectVideoList.stream;

  Stream<GetExploreState> get getExplore => _subjectGetExplore.stream;

  Stream<UpdateInterestState> get getInterest => _subjectInterest.stream;

  Stream<BannerStudioState> get getBannerStudio => _subjectBannerStudio.stream;
  Stream<UpdateViewerState> get getViewerStatus => _subjectPortfolioViewer.stream;
  Stream<PortfolioDetailState> get getDetail => _subjectPortfolioDetail.stream;

  Stream<PortfolioListState> get getPortfolioUser =>
      _subjectPortfolioList.stream;

  BehaviorSubject<bool> _stanby = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get getStanby => _stanby.stream;

  requestGetList(BuildContext context, int limit, int page, String title) {
    FeedListPayload payload = new FeedListPayload(
      title: title,
      limit: limit.toString(),
      page: page.toString(),
    );

    try {
      _subjectGetList.sink
          .add(GetListFeedState.onLoading("Loading get list ..."));

      FeedServices().getFeedsList(context, payload).then((response) {
        if (response.code == "success") {
          _subjectGetList.sink.add(GetListFeedState.onSuccess(response));
        } else {
          _subjectGetList.sink.add(GetListFeedState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectGetList.sink.add(GetListFeedState.onError(e.toString()));
    }
  }

  requestGetLikes(
      BuildContext context, String portfolioId, int limit, int page) {
    FeedListPayload payload = new FeedListPayload(
      limit: limit.toString(),
      page: page.toString(),
    );

    try {
      _subjectLikeList.sink
          .add(LikeListState.onLoading("Loading get list ..."));

      FeedServices()
          .getLikeList(context, portfolioId, payload)
          .then((response) {
        if (response.code == "success") {
          _subjectLikeList.sink.add(LikeListState.onSuccess(response));
        } else {
          _subjectLikeList.sink.add(LikeListState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectLikeList.sink.add(LikeListState.onError(e.toString()));
    }
  }

  requestGetBookmark(BuildContext context, int limit, int page) {
    FeedListPayload payload = new FeedListPayload(
      limit: limit.toString(),
      page: page.toString(),
    );

    try {
      _subjectBookmarkList.sink
          .add(BookmarkListState.onLoading("Loading get list ..."));

      FeedServices().getBookmarkList(context, payload).then((response) {
        if (response.code == "success") {
          _subjectBookmarkList.sink.add(BookmarkListState.onSuccess(response));
        } else {
          _subjectBookmarkList.sink
              .add(BookmarkListState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectBookmarkList.sink.add(BookmarkListState.onError(e.toString()));
    }
  }

  requestSearchList(BuildContext context, int limit, int page, String title) {
    FeedListPayload payload = new FeedListPayload(
      title: title,
      limit: limit.toString(),
      page: page.toString(),
    );

    try {
      _subjectSearchList.sink
          .add(SearchListState.onLoading("Loading get list ..."));

      FeedServices().getFeedsList(context, payload).then((response) {
        if (response.code == "success") {
          _subjectSearchList.sink.add(SearchListState.onSuccess(response));
        } else {
          _subjectSearchList.sink
              .add(SearchListState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectSearchList.sink.add(SearchListState.onError(e.toString()));
    }
  }

  requestGetVideoList(BuildContext context, int limit, int page) {
    FeedListPayload payload = new FeedListPayload(
      limit: limit.toString(),
      page: page.toString(),
      isVideo: 1,
    );

    try {
      _subjectVideoList.sink
          .add(VideoListState.onLoading("Loading get list ..."));

      FeedServices().getFeedsList(context, payload).then((response) {
        if (response.code == "success") {
          _subjectVideoList.sink.add(VideoListState.onSuccess(response));
        } else {
          _subjectVideoList.sink.add(VideoListState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectVideoList.sink.add(VideoListState.onError(e.toString()));
    }
  }

  requestGetExplore(
      {BuildContext context,
      int limit,
      int page,
      Category category,
      String subCategory,
      String typeCategory}) {
    FeedListPayload payload = new FeedListPayload(
      limit: limit.toString(),
      page: page.toString(),
    );

    String sub = subCategory != "Semua" ? subCategory : "";
    String type = typeCategory != "Semua" ? typeCategory : "";

    try {
      _subjectGetExplore.sink
          .add(GetExploreState.onLoading("Loading get list ..."));

      FeedServices()
          .getExploreFeeds(context, payload, category, sub, type)
          .then((response) {
        if (response.code == "success") {
          _subjectGetExplore.sink.add(GetExploreState.onSuccess(response));
        } else {
          _subjectGetExplore.sink
              .add(GetExploreState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectGetExplore.sink.add(GetExploreState.onError(e.toString()));
    }
  }

  requestUpdateInterest(BuildContext context, List<Category> categoryList) {
    List<String> interest = [];
    for (Category category in categoryList) {
      if (category.selected) {
        interest.add(category.category.replaceAll("Jasa ", ""));
      }
    }

    try {
      _subjectInterest.sink.add(UpdateInterestState.onLoading("Loading ..."));

      FeedServices().updateInterest(context, interest).then((response) {
        if (response.code == "success") {
          _subjectInterest.sink.add(UpdateInterestState.onSuccess(response));
        } else {
          _subjectInterest.sink
              .add(UpdateInterestState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectInterest.sink.add(UpdateInterestState.onError(e.toString()));
    }
  }

  requestStudioBanner(BuildContext context) {
    try {
      _subjectBannerStudio.sink.add(BannerStudioState.onLoading("Loading ..."));

      FeedServices().getStudioBanner(context).then((response) {
        if (response.code == "success") {
          _subjectBannerStudio.sink.add(BannerStudioState.onSuccess(response));
        } else {
          _subjectBannerStudio.sink
              .add(BannerStudioState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectBannerStudio.sink.add(BannerStudioState.onError(e.toString()));
    }
  }

  requestPortfolioUser(BuildContext context, int limit, int page, String id) {
    FeedListPayload payload = new FeedListPayload(
      limit: limit.toString(),
      page: page.toString(),
    );

    try {
      _subjectPortfolioList.sink.add(PortfolioListState.onLoading("Loading ..."));

      FeedServices().getPortfolioList(context, id, payload).then((response) {
        if (response.code == "success") {
          _subjectPortfolioList.sink.add(PortfolioListState.onSuccess(response));
        } else {
          _subjectPortfolioList.sink
              .add(PortfolioListState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectPortfolioList.sink.add(PortfolioListState.onError(e.toString()));
    }
  }

  requestGetDetail(BuildContext context, String id) {
    try {
      _subjectPortfolioDetail.sink.add(PortfolioDetailState.onLoading("Loading ..."));

      FeedServices().getPortfolioDetail(context, id).then((response) {
        if (response.code == "success") {
          _subjectPortfolioDetail.sink.add(PortfolioDetailState.onSuccess(response));
        } else {
          _subjectPortfolioDetail.sink
              .add(PortfolioDetailState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectPortfolioDetail.sink.add(PortfolioDetailState.onError(e.toString()));
    }
  }

  requestUpdateViewer(BuildContext context, String id) {
    try {
      _subjectPortfolioViewer.sink.add(UpdateViewerState.onLoading("Loading ..."));

      FeedServices().updateViewer(context, id).then((response) {
        if (response.code == "success") {
          _subjectPortfolioViewer.sink.add(UpdateViewerState.onSuccess(response));
        } else {
          _subjectPortfolioViewer.sink
              .add(UpdateViewerState.onError(response.message));
        }
      });
    } catch (e) {
      _subjectPortfolioViewer.sink.add(UpdateViewerState.onError(e.toString()));
    }
  }

  unStandBy() async {
    _stanby.sink.add(false);
    _subjectGetList.sink.add(GetListFeedState.unStanby());
    _subjectLikeList.sink.add(LikeListState.unStanby());
    _subjectBookmarkList.sink.add(BookmarkListState.unStanby());
    _subjectSearchList.sink.add(SearchListState.unStanby());
    _subjectVideoList.sink.add(VideoListState.unStanby());
    _subjectGetExplore.sink.add(GetExploreState.unStanby());
    _subjectInterest.sink.add(UpdateInterestState.unStanby());
    _subjectBannerStudio.sink.add(BannerStudioState.unStanby());
    _subjectPortfolioList.sink.add(PortfolioListState.unStanby());
    _subjectPortfolioViewer.sink.add(UpdateViewerState.unStanby());
    _subjectPortfolioDetail.sink.add(PortfolioDetailState.unStanby());
  }

  void dispose() {
    _subjectGetList?.close();
    _subjectLikeList?.close();
    _subjectBookmarkList?.close();
    _subjectSearchList?.close();
    _subjectVideoList?.close();
    _subjectGetExplore?.close();
    _subjectInterest?.close();
    _subjectBannerStudio?.close();
    _subjectPortfolioList?.close();
    _subjectPortfolioViewer?.close();
    _subjectPortfolioDetail?.close();
    _stanby?.drain(false);
  }
}
