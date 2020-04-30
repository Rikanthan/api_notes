class ApiResponse<T>
{
  T data;
  bool error;
  String errormessage;

  ApiResponse({this.data,this.errormessage,error=false});

}