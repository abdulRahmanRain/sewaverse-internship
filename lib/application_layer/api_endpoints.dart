class ApiEndpoints {
  static const String baseUrl = "https://jsonplaceholder.typicode.com";
  static const String posts = "$baseUrl/posts";
  static const String comment = "$baseUrl/posts/1/comments";
}

class ApiEndPointsSewa{
  static String baseUrl = "https://qasewaverse.vercel.app/api";
  static String featuredServiceGroups = "$baseUrl/home/featured-services";
  static String featuredService = "/home/featured-services";


  static String offeredServiceResponse(String id) {
    return "$baseUrl/public/offered-service/$id";
  }


}

class UserApi{
  static String baseUrl  = "https://jsonplaceholder.typicode.com";
  static String endPoint = "/todos/1";
}