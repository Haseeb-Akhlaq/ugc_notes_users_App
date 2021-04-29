class AppUser {
  String userId;
  String userName;
  String email;
  String profilePic;
  String numberOfCourseEnrolled;
  bool premiumUser;

  AppUser({
    this.userId,
    this.userName,
    this.email,
    this.numberOfCourseEnrolled,
    this.profilePic,
    this.premiumUser,
  });

  AppUser.fromMap(Map<dynamic, dynamic> map) {
    this.userId = map['userId'] ?? '';
    this.userName = map['userName'] ?? '';
    this.email = map['email'] ?? '';
    this.profilePic = map['profilePic'];
    this.premiumUser = map['premiumUser'];
    this.numberOfCourseEnrolled = map['totalCoursesEnrolled'];
  }
}
