<%@ taglib uri= "http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri= "http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t"%>

<c:if test="${pageContext.request.method=='POST' and not empty param.date and not empty param.subject and not empty param.amount }">
  <c:catch var="exception">
    <c:set var="dbUri"  value="<%=new java.net.URI(System.getenv(\"DATABASE_URL\")) %>"/>

    <sql:setDataSource
      var="connection" driver="org.postgresql.Driver" url="jdbc:postgresql://${dbUri.getHost()}:${dbUri.getPort()}${dbUri.getPath()}?sslmode=require" user="${dbUri.getUserInfo().split(\":\")[0]}" password="${dbUri.getUserInfo().split(\":\")[1]}" />
    <c:choose>
      <c:when test="${not empty param.id}">
        <sql:update dataSource="${connection}" var="count">
          update balance_sheet set subject=lower(?), t_date=to_date(?,'YYYY-MM-DD'),amount=?,type=?,comment=? where user_id=? and id=?
          <sql:param value="${param.subject}"/>
          <sql:param value="${param.date}" />
          <sql:param value="${Double.parseDouble(param.amount)}" />
          <sql:param value="${param.type}" />
          <sql:param value="${param.comment}" />
          <sql:param value="${ Integer.parseInt(sessionScope.userid)}" />
          <sql:param value="${ Integer.parseInt(param.id)}" />
        </sql:update>
      </c:when>
      <c:otherwise>
        <sql:update dataSource="${connection}" var="count">
          insert into balance_sheet (subject,t_date,amount,type,comment,user_id) values (lower(?),to_date(?,'YYYY-MM-DD'),?,?,?,?)
          <sql:param value="${param.subject}"/>
          <sql:param value="${param.date}" />
          <sql:param value="${Double.parseDouble(param.amount)}" />
          <sql:param value="${param.type}" />
          <sql:param value="${param.comment}" />
          <sql:param value="${ Integer.parseInt(sessionScope.userid)}" />
        </sql:update>
      </c:otherwise>
    </c:choose>

  </c:catch>

  <c:if test="${not empty exception}">
    <c:set var="errorMessage" value="Something went wrong"/>
    ${exception.message}
  </c:if>
  <c:redirect url="${pageContext.request.requestURI}" />
</c:if>
<c:if test="${pageContext.request.method=='GET'}">
  <c:catch var="exception">
    <c:set var="dbUri"  value="<%=new java.net.URI(System.getenv(\"DATABASE_URL\")) %>"/>

    <sql:setDataSource
      var="connection" driver="org.postgresql.Driver" url="jdbc:postgresql://${dbUri.getHost()}:${dbUri.getPort()}${dbUri.getPath()}?sslmode=require" user="${dbUri.getUserInfo().split(\":\")[0]}" password="${dbUri.getUserInfo().split(\":\")[1]}" />
    <sql:query dataSource="${connection}" var="subjects">
      select distinct subject from balance_sheet where user_id=?
      <sql:param value="${Integer.parseInt(sessionScope.userid)}"/>
    </sql:query>
  </c:catch>
  <c:if test="${not empty exception}">
    <c:set var="errorMessage" value="Something went wrong"/>
    ${exception.message}
  </c:if>
</c:if>
<t:wrapper>
  <jsp:attribute name="header">
    <title>Notebook</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/user/balance_sheet.css">
  </jsp:attribute>
  <jsp:body>
    <h2>Balance Sheet</h2>
    <div class="balance-sheet">
      <c:forEach items="${subjects.rows}" var="i">
        <div class="crop-sheet">
          <h2 subject="${i.subject}">${i.subject}</h2>
          <span class="add-item" title="Add a row">&CirclePlus;</span>
          <table subject="${i.subject}">
            <tr>
              <th> Date </th>
              <th>Type</th>
              <th>Amount</th>
              <th>Comment</th>
            </tr>
            <sql:query dataSource="${connection}" var="result">
              select * from balance_sheet where user_id=? and subject=?  and not removed order by t_date,id
              <sql:param value="${Integer.parseInt(sessionScope.userid)}"/>
              <sql:param value="${i.subject}"/>
            </sql:query>
            <c:set var="sum" value="0"/>
            <c:forEach var="j" items="${result.rows}">
              <c:set var="sum" value="${sum+((j.type=='credit')?j.amount: -j.amount)}"/>
              <tr t_id="${j.id}" class="${j.type}">
                <td> ${j.t_date}</td>
                <td>${j.type}</td>
                <td>${j.amount}</td>
                <td>${j.comment}</td>
              </tr>
            </c:forEach>
            <tr>
              <td>
                <b>Total</b>
              </td>
              <td></td>
              <td>
                <b>${sum}</b>
              </td>
            </tr>
          </table>
        </div>
      </c:forEach>


    </div>
    <div>
    <h3 onclick="document.querySelector('#manipulate_record').reset(); document.querySelector('.modal-container').style.display='block';" style="display:inline-block;"> <a style="color:cadetblue;" href="javascript:void(0)">Add Another Crop</a></h3>
    </div>
    <div class="modal-container">
      <div class="modal-content">

        <div class="">
          <form id="manipulate_record" method="post">
            <header>
              <h2>Edit Record</h2>
              <span class="close">&times;</span>
            </header>
            <hr>
            <section>
              <input name="id" readonly hidden>
              <div class="form-input">
                <label for="t_subject">Crop</label>
                <input type="text" name="subject"  required id="t_subject" placeholder="Crop" autofocus>
              </div>
              <div class="form-input">
                <label for="t_date">Date</label>
                <input type="date" name="date" value="" required id="t_date">
              </div>
              <div class="form-input">
                <label for="t_amount">Amount</label>
                <input type="number" name="amount" placeholder="Amount" value="" required id="t_amount">
              </div>
              <div class="form-input">
                <label for="t_type">Type</label>
                <select class="" name="type" id="t_type" required>
                  <option value="debit">Expenditure</option>
                  <option value="credit">Income</option>
                </select>
              </div>
              <div class="form-input">
                <label for="t_comment">Comment</label>
                <input name="comment" placeholder="Comment, if any." type="text"  id="t_comment">
              </div>
            </section>
            <hr>
            <footer>
              <div class="form-input">
                <input type="button" name="" value="Remove" onclick="remRec(this);">
                <input type="submit" id="submit-btn" value="Save" onclick="addRec(this);" disabled>
              </div>
            </footer>
          </form>
        </div>
      </div>
    </div>
    <script type="text/javascript">

    document.querySelector("#manipulate_record").oninput=()=>{
      document.querySelector('#submit-btn').disabled=false;
    }
      document.querySelectorAll('.add-item').forEach((item, i) => {
        item.addEventListener('click',()=>{
          document.querySelector("#manipulate_record").reset();
          document.querySelector('#submit-btn').disabled=true;
          document.querySelector('#t_subject').value=item.parentNode.querySelector('h2').getAttribute('subject');
          document.querySelector('.modal-container').style.display='block';
        });
      });

      document.querySelectorAll('tr:not(:first-child):not(:last-child)').forEach(item=>{
          item.addEventListener('click',evt=>{
              var form=document.querySelector("#manipulate_record");
              form.reset();
              document.querySelector('#submit-btn').disabled=true;
              form.id.value=item.getAttribute("t_id");
              form.subject.value=item.offsetParent.getAttribute('subject');
              var values=item.querySelectorAll('td');
              form.date.value=values[0].innerText;
              form.amount.value=values[2].innerText;
              var options=form.type.options;
              for(let i=0;i<options.length;i++){
                if(options[i]==values[1].innerText){
                  options[i].selected=true;
                }
              }
              form.comment.value=values[3].innerText;

              document.querySelector('.modal-container').style.display='block';
          });
      });

      document.querySelector('.modal-container').onclick=evt=>{
        console.log(evt.target==document.querySelector('.modal-container') )
        console.log(evt.target==document.querySelector('.close') )
        if(evt.target==document.querySelector('.modal-container') || evt.target==document.querySelector('.close')){
          document.querySelector('#submit-btn').disabled=true;
          document.querySelector('.modal-container').style.display="none";
        }
      }
      function addRec(button){
        var form=document.querySelector("#manipulate_record");
        if(form.reportValidity()){

          form.action=location.protocol+"//"+location.host+"/latest/balance-sheet";
          form.method="post";
          button.disabled=true;
          form.submit();
        }
        else{
          return false;
        }
      }

      function remRec(button){
        if(window.confirm("Are you sure to remove this record?")){
          var form=document.querySelector("#manipulate_record");
          form.action=location.protocol+"//"+location.host+"/balance-sheet/remove";
          form.method="get";
          button.disabled=true;
          form.submit();
        }
        else{
          return false;
        }

      }

    </script>

  </jsp:body>
</t:wrapper>
