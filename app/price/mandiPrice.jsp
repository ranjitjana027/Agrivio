<script>
var request=new XMLHttpRequest();
request.open("GET","https://api.data.gov.in/resource/9ef84268-d588-465a-a308-a864a43d0070?api-key=579b464db66ec23bdd000001850c76ce49e246686075684ef0e11614&format=json&offset=0&limit=9999");
request.onload=()=>{
    pdata=JSON.parse(request.responseText);
    sts=(pdata["records"].map(m=>m.state))
    sts=(new Set(sts))
    console.log(sts)

    for (var str of sts) {
        var opt = document.createElement('option');
        opt.text =str;
        opt.value = str;
        document.querySelector('#state').append(opt);
    }
    document.querySelector('#state').value = 'West Bengal'
    //document.write(data["records"]);
    wbdata = pdata["records"].filter(e => e.state.match(/.*Bengal/))
    stateSelect(wbdata);

    document.querySelector('#state').onchange = evt =>{
        state=evt.target.value;
        wbdata = pdata["records"].filter(e => e.state.match(state))
        stateSelect(wbdata);
    }

    function stateSelect(wbdata)
    {
        console.log(wbdata)
        if (state != "") {
            while (document.getElementById('price-list').rows.length > 1)
                document.getElementById('price-list').deleteRow(-1)
            district = new Set(wbdata.map(m => m.district));
            for (i = 0; i < wbdata.length; i++) {
                //district.add(wbdata[i]["district"]);
                var tr = document.createElement('tr');
                for (k in wbdata[i]) {
                    if (k != 'timestamp' && k != 'state') {
                        var td = document.createElement("td");
                        td.innerHTML = wbdata[i][k];
                        tr.append(td);
                    }
                }
                document.querySelector('#price-list').append(tr);
                //console.log(k+": "+wbdata[i][k]+"<br>");
            }
            document.querySelector('#price-list').hidden = false;

            while (document.getElementById('district').length > 1){
                var e=document.getElementById('district');
                e.removeChild(e.lastChild);
                }
            console.log(district)
            for (i of district) {
                var opt = document.createElement('option');
                opt.text = i;
                opt.value = i;
                document.querySelector('#district').append(opt);
            }
            document.querySelector('#choose-district').hidden = false;
            console.log(wbdata);
            document.querySelector('#district').onchange = evt => {
                console.log(evt.target.value);

                if (evt.target.value != "")
                    dist = evt.target.value;
                else
                    dist = ".*"
                {
                    ddata = wbdata.filter(e => e.district.match(dist));
                    console.log(ddata)
                    while (document.getElementById('price-list').rows.length > 1)
                        document.getElementById('price-list').deleteRow(-1)
                    for (i = 0; i < ddata.length; i++) {

                        var tr = document.createElement('tr');
                        for (k in ddata[i]) {
                            if (k != 'timestamp' && k != 'state') {
                                var td = document.createElement("td");
                                td.innerHTML = ddata[i][k];
                                tr.append(td);
                            }
                        }
                        document.querySelector('#price-list').append(tr);
                        //console.log(k+": "+wbdata[i][k]+"<br>");
                    }
                }
            }
        }

    }

    
}
request.send();
</script>
<style>
    table{
        border-collapse: collapse;
        background-color: rgb(0, 53, 40);
        width: 100%;
    }
    td{
        border: solid #d0bc8b;
        color: aliceblue;
        text-align: center;
        
    }
    th{
        border: solid  #e2dfcb;
        color:#90ed14;
        
    }
</style>
<body>
    <!--div id="google_translate_element" style="display:inline-block; float: right; ">
    
    </div>
    
    <script type="text/javascript">
        function googleTranslateElementInit() {
            new google.translate.TranslateElement({ pageLanguage: 'en' }, 'google_translate_element');
        }
    </script>
    
    <script type="text/javascript"
        src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script-->
    <div style="display:inline-block; width: 250px;">
        <label for="state">State: </label>
        <select id="state">
            <option value="">Select State</option>
        </select>
    </div>
    <div id="choose-district" hidden style="display:inline-block;">
        <label for="district">District:</label>
        <select name="district" id="district">
            <option value="">Select District</option>
        
        </select>
    </div>
    
    <table id="price-list" hidden>
        <tr><th>District</th><th>Market</th><th>Commodity</th><th>Variety</th><th>Arrival Date</th><th>Max Price</th><th>Min Price</th><th>Modal Price</th></tr>
    </table>
</body>