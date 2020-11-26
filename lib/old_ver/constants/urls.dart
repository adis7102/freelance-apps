class BaseUrl {
  static const SoedjaAPI = 'https://dev-api.soedja.com';
  static const SoedjaUrl = 'dev-api.soedja.com';
}

class Url {
  static const loginFreelance = '/auth/login';
  static const registerFreelance = '/auth/register';
  static const requestActivate = '/auth/resend_activation';
  static const validateOtp = '/auth/validate_otp';
  static const generatePin = '/auth/reset_pin/change';
  static const requestResetPin = '/auth/reset_pin/request';
  static const sendResetPin = '/auth/reset_pin/change';
  static const changePin = '/auth/reset_pin/change_pin';

  static const getProfile = '/profiles/get_by_user_id';
  static const getFeedsProfile = '/feed/follow/get_profiles/';

  static const feedList = '/feed';
  static const feedLike = '/feed/like/create';
  static const removeLike = '/feed/like/remove/';
  static const bookmarkList = '/feed/bookmark/get_all';
  static const feedBookmark = '/feed/bookmark/create';
  static const removeBookmark = '/feed/bookmark/remove/';
  static const feedComment = '/feed/comment/create';
  static const profilesList = '/feed/follow/get_all_profiles';
  static const profilesFollow = '/feed/follow/create';
  static const removeFollow = '/feed/follow/remove/';

  static const updateProfile = '/profiles/portfolio/update/';
  static const updateInterest = '/feed/update_interest';

  static const createPortfolio = '/profiles/portfolio/create';
  static const updatePortfolio = '/profiles/portfolio/update/';
  static const uploadPictures = '/profiles/portfolio/upload_pictures/';
  static const removePictures = '/profiles/portfolio/remove_picture/';

  static const exploreList = '/feed/discover/get_all';

  static const commentList = '/feed/comment/get/';

  static const categoryList = '/category';
  static const subCategoryList = '/sub_category/';
  static const typeCategoryList = '/type_category/';

  static const provinceList = '/settings/area/province';
  static const regencyList = '/settings/area/regency';
  static const districtList = '/settings/area/district';
  static const villageList = '/settings/area/village';

  static const professionList = '/settings/profession';

  static const notification = '/notification/mobile/inbox';
  static const updateToken = '/notification/mobile/update_token';
  static const readNotification = '/notification/mobile/is_read';
  static const portfolioList = '/profiles/portfolio/get/';

  static const getFollows = '/feed/follow/get_statistic/';
  static const updateProfileFreelance = '/profiles';
  static const updateAvatar = '/profiles/upload_picture';

  static const getFollower = '/feed/follow/get_follower';
  static const getFollowing = '/feed/follow/get_following';
}
