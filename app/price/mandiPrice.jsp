<script>
var request=new XMLHttpRequest();
request.open("GET","https://api.data.gov.in/resource/9ef84268-d588-465a-a308-a864a43d0070?api-key=579b464db66ec23bdd000001850c76ce49e246686075684ef0e11614&format=json&offset=0&limit=9999");
request.onload=()=>{
    data=JSON.parse(request.responseText);
    wbdata=data["records"].filter(e=>e.district.match(/Medinipur.*/))
    console.log(wbdata)
    //document.write(data["records"]);
    for(i=0;i< wbdata.length;i++)
    {
        for(k in wbdata[i])
        document.writeln(k+": "+wbdata[i][k]+"<br>");
    }
}
request.send();
</script>