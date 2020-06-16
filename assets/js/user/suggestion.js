function get_suggestion() {
  var request=new XMLHttpRequest();
  request.open("GET",location.protocol+"//"+location.host+"/suggestion/crop?lat=23&lon=88");
  request.onload=()=>{
      var data=JSON.parse(request.responseText);
      console.log(data);
  }
  request.send();

}
