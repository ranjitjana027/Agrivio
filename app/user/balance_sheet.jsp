<%@ taglib uri= "http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri= "http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t"%>

<c:if test="${pageContext.request.method=='POST' and not empty param.date and not empty param.subject and not empty param.amount }">
  <c:catch var="exception">
    <c:set var="dbUri"  value="<%=new java.net.URI(System.getenv(\"DATABASE_URL\")) %>"/>

    <sql:setDataSource
      var="connection" driver="org.postgresql.Driver" url="jdbc:postgresql://${dbUri.getHost()}:${dbUri.getPort()}${dbUri.getPath()}?sslmode=require" user="${dbUri.getUserInfo().split(\":\")[0]}" password="${dbUri.getUserInfo().split(\":\")[1]}" />

    <sql:update dataSource="${connection}" var="count">
      insert into balance_sheet (subject,t_date,amount,type,comment,user_id) values (?,to_date(?,'YYYY-MM-DD'),?,?,?,?)
      <sql:param value="${param.subject}"/>
      <sql:param value="${param.date}" />
      <sql:param value="${Double.parseDouble(param.amount)}" />
      <sql:param value="${param.type}" />
      <sql:param value="${param.comment}" />
      <sql:param value="${ Integer.parseInt(sessionScope.userid)}" />
    </sql:update>
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
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/user/balance_sheet.css">
  </jsp:attribute>
  <jsp:body>
    <h2>Balance Sheet</h2>
    <div class="balance-sheet">
      <c:forEach items="${subjects.rows}" var="i">
        <div class="crop-sheet">
          <h2 subject="crop-a">${i.subject}</h2>
          <span class="add-item" title="Add a row">&CirclePlus;</span>
          <table>
            <tr>
              <th>Date </th>
              <th>Type</th>
              <th>Amount</th>
              <th>Comment</th>
            </tr>
            <sql:query dataSource="${connection}" var="result">
              select * from balance_sheet where user_id=? and subject=?
              <sql:param value="${Integer.parseInt(sessionScope.userid)}"/>
              <sql:param value="${i.subject}"/>
            </sql:query>
            <c:set var="sum" value="0"/>
            <c:forEach var="j" items="${result.rows}">
              <c:set var="sum" value="${sum+((j.type=='credit')?j.amount: -j.amount)}"/>
              <tr t_id="${j.id}" class="${j.type}">
                <td>${j.t_date}</td>
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
    <h3 onclick="document.querySelector('.modal-container').style.display='flex'"> <a style="color:cadetblue;" href="javascript:void(0)">Add Another Crop</a></h3>
    </div>
    <div class="modal-container">
      <div class="modal-content">
        <span class="close">&times;</span>
        <div class="">
          <form class="" method="post">
            <h2>Add a Transaction</h2>
            <div class="form-input">
              <label for="t_subject">Crop</label>
              <input type="text" name="subject"  required id="t_subject" autofocus>
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
              <textarea name="comment" placeholder="Comment, if any." rows="4"  id="t_comment"></textarea>
            </div>
            <div class="form-input">
              <input type="submit" name="" value="Save">
            </div>
          </form>
        </div>
      </div>
    </div>
    <script type="text/javascript">
      document.querySelectorAll('.add-item').forEach((item, i) => {
        item.addEventListener('click',()=>{
          document.querySelector('#t_subject').value=item.parentNode.querySelector('h2').getAttribute('subject');
          document.querySelector('.modal-container').style.display='flex';
        });
      });

      document.querySelector('.modal-container').onclick=evt=>{
        console.log(evt.target==document.querySelector('.modal-container') )
        console.log(evt.target==document.querySelector('.close') )
        if(evt.target==document.querySelector('.modal-container') || evt.target==document.querySelector('.close')){
          document.querySelector('.modal-container').style.display="none";
        }
      }

    </script>

  </jsp:body>
</t:wrapper>
