class MainRoutePath{

  String userId = '';
  bool isUnknown = false;

  MainRoutePath();
  MainRoutePath.user(this.userId);
  MainRoutePath.unknown() : isUnknown = true;
}