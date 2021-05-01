class AppUser {
  String userId;
  String userName;
  String email;
  String profilePic;
  int numberOfCourseEnrolled;
  bool premiumUser;
  String memberShipValidTill;

  AppUser({
    this.userId,
    this.userName,
    this.email,
    this.numberOfCourseEnrolled,
    this.profilePic,
    this.premiumUser,
    this.memberShipValidTill,
  });

  AppUser.fromMap(Map<dynamic, dynamic> map) {
    this.userId = map['userId'] ?? '';
    this.userName = map['userName'] ?? '';
    this.email = map['email'] ?? '';
    this.profilePic = map['profilePic'];
    this.premiumUser = map['premiumUser'];
    this.numberOfCourseEnrolled = map['totalCoursesEnrolled'];
    this.memberShipValidTill = map['memberShipValidTill'];
  }
}
