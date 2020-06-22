<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t"%>

<c:if test="${pageContext.request.method=='POST' and not empty param.title and not empty param.target and not empty param.code}">

  <c:catch var="exception">

        <c:set var="dbUri"  value="<%=new java.net.URI( System.getenv(\"DATABASE_URL\") ) %>"/>
        <sql:setDataSource
          var="connection" driver="org.postgresql.Driver" url="jdbc:postgresql://${dbUri.getHost()}:${dbUri.getPort()}${dbUri.getPath()}?sslmode=require" user="${dbUri.getUserInfo().split(\":\")[0]}" password="${dbUri.getUserInfo().split(\":\")[1]}" />

        <sql:update dataSource="${connection}" var="count">
          insert into ads (title,target,code) values (?,lower(?),?);
          <sql:param value="${param.title}" />
          <sql:param value="${param.target}" />
          <sql:param value="${param.code}" />
        </sql:update>
        <c:choose>
          <c:when test="${count>0}">
            <c:set var="message" >
              Successfully updated user details
            </c:set>
          </c:when>
          <c:otherwise>
            <c:set var="errormessage" >
              Encounter error while updating user details
            </c:set>
          </c:otherwise>
        </c:choose>

  </c:catch>

  <c:if test="${not empty exception}" >
  <c:set var="errormessage" >
    Something went wrong
  </c:set>
  </c:if>
</c:if>

<t:admin-wrapper>
  <jsp:attribute name="header">
    <title>Advertisements</title>
    <link rel="stylesheet" href='${pageContext.request.contextPath}/assets/css/admin/ads.css'>
    <script src="${pageContext.request.contextPath}/assets/js/lib/custom-select.js" charset="utf-8"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/lib/form-label-animation.css">
  </jsp:attribute>
  <jsp:body>

    <div class="page-header">Advertisements <span id="add-item" title="Add an Advertisement">&CirclePlus;</span> </div>
    <c:if test="${ not empty errormessage}">
      <div class="errormessage">
        <span style="background-color: white; box-shadow: 2px 2px 10px 2px #000000; padding: 5px 15px; "> ${errormessage}.
        <span style="background-color: white; cursor:pointer;" onclick="this.parentNode.hidden=true;"> &#10007; </span></span>
      </div>
    </c:if>
    <c:if test="${ not empty message}">
      <div class="errormessage" style="color:green;">
        <span style="background-color: white; box-shadow: 2px 2px 10px 2px #000000; padding: 5px 15px; ">  ${message}.
        <span style="background-color: white; cursor:pointer;" onclick="this.parentNode.hidden=true;"> &#10004; </span></span>
      </div>
    </c:if>

    <ul class="ads-details">
      <c:catch var="exception">
          <c:set var="dbUri"  value="<%=new java.net.URI( System.getenv(\"DATABASE_URL\") ) %>"/>
          <sql:setDataSource
            var="connection" driver="org.postgresql.Driver" url="jdbc:postgresql://${dbUri.getHost()}:${dbUri.getPort()}${dbUri.getPath()}?sslmode=require" user="${dbUri.getUserInfo().split(\":\")[0]}" password="${dbUri.getUserInfo().split(\":\")[1]}" />

          <sql:query dataSource="${connection}" var="result">
            select id,title,target from ads;
          </sql:query>
      </c:catch>
      <c:if test="${result.rowCount>0}">
        <c:forEach items="${result.rows}" var="i">
          <li class="">
            <span><a href="${pageContext.request.contextPath}/admin/ads?id=${i.id}">${i.title}</a> </span> : <span class="target-pages">${i.target}</span>
          </li>
        </c:forEach>
      </c:if>
    </ul>

    <div class="modal" id="add-ads-modal">
        <div class="modal-content">
          <form  method="post">
            <span class="close" title="Close">&times;</span>
            <h2>Add Advertisement</h2>
            <div class="">
              <div class="form-input">
                <label for="title">Title</label>
                <input type="text" name="title" value="" required placeholder="Title" id="title" maxlength="100">
              </div>
              <div class="form-input">
                <label for="target">Target Page</label>
                <input type="text" name="target" required placeholder="Target Page" value="" id="target" list="pages">
                <datalist id="pages">
                  <option value="CropPrice">
                  <option value="Suggestion">
                  <option value="Guide">
                  <option value="Events">
                  <option value="AskExpert">
                  <option value="Plant">
                  <option value="Pest">
                </datalist>
              </div>
            </div>

            <div class="">
              <div style="padding:5px 15px;">
                <label for="code">HTML Code</label>
                <textarea name="code" rows="8"  id="code" required style="width:100%;"></textarea>
              </div>
            </div>
              <div class="form-button">
                <div class="btn-left">
                  <button type="reset" >Reset</button>
                </div>

                  <div class="btn-right">
                    <button type="submit">Save</button>
                  </div>
              </div>
          </form>

        </div>
    </div>
    <script type="text/javascript">

      document.querySelectorAll('.close').forEach(function (item) {
          item.onclick = (event) => {
              event.target.offsetParent.classList.remove("show-modal");
          };
      });

      window.addEventListener("click",evt=>{
          document.querySelectorAll('.modal').forEach(function (item) {
              if(evt.target==item)
                  item.classList.remove("show-modal");
      });
      });

      document.querySelector("#add-item").onclick=()=>{
        document.querySelector("#add-ads-modal").classList.add("show-modal");
      }
    </script>
  </jsp:body>
</t:admin-wrapper>
