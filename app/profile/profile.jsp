<%@ taglib uri= "http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri= "http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri= "http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t"%>

<c:catch var="exception">
  <c:set var="dbUri"  value="<%=new java.net.URI(System.getenv(\"DATABASE_URL\")) %>"/>

  <sql:setDataSource
    var="connection" driver="org.postgresql.Driver" url="jdbc:postgresql://${dbUri.getHost()}:${dbUri.getPort()}${dbUri.getPath()}?sslmode=require" user="${dbUri.getUserInfo().split(\":\")[0]}" password="${dbUri.getUserInfo().split(\":\")[1]}" />
  <sql:query dataSource="${connection}" var="result">
    select * from users where id=?
    <sql:param value="${Integer.parseInt(sessionScope.userid)}" />
  </sql:query>
</c:catch>
<c:if test="${not empty exception}">
  <c:set var="errormessage" value="Something went wrong"/>

</c:if>


<t:wrapper>
  <jsp:attribute name="header">
    <title>My Account</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/profile/profile.css">
  </jsp:attribute>
  <jsp:body>
    <div class="profile-header">
      User Profile
    </div>
    <c:if test="${result.rowCount>0}">
      <div class="row">
        <div class="col-4 col-sm-4 col-xs-12">
          <div class="profile-overview">
            <div class="profile-pic">
              <img src="${fn:replace(result.rows[0].dp,'https://agrivio-assets.s3.amazonaws.com/','https://o8zks6ll3b.execute-api.us-east-1.amazonaws.com/production/')}?width=128" alt="Profile Pic">
            </div>
            <div class="username">
              ${result.rows[0].firstname} ${result.rows[0].lastname}
            </div>
            <div class="premium-sticker" style="">
              ${ result.rows[0].premium ?"Premium":"Basic" }
            </div>
          </div>
          <div class="account-action mobile-hidden">
            <div class="">
              <a href="#">Change Password</a>
            </div>
            <div class="">
              <a href="#">Change Mobile No</a>
            </div>
          </div>
        </div>
        <div class="col-8 col-sm-8 col-xs-12">
          <div class="profile-details">

            <div class="personal-info">
              <header>
                Account Details
              </header>
              <div class="row  profile-data">
                <div class="col-4 col-sm-4 col-xs-4">
                  Name
                </div>
                <div class="col-8 col-sm-8 col-xs-8">
                  ${result.rows[0].firstname} ${result.rows[0].lastname}
                </div>

              </div>
              <div class="row  profile-data">
                <div class="col-4 col-sm-4 col-xs-4">
                  Mobile
                </div>
                <div class="col-8 col-sm-8 col-xs-8">
                  ${result.rows[0].mobile}
                </div>
              </div>
              <div class="row profile-data">
                <div class="col-4 col-sm-4 col-xs-4">
                  Email
                </div>
                <div class="col-8 col-sm-8 col-xs-8">
                  ${result.rows[0].email}
                </div>
              </div>
              <div class="row  profile-data">
                <div class="col-4 col-sm-4 col-xs-4">
                  Password
                </div>
                <div class="col-8 col-sm-8 col-xs-8">
                  XXXXXXXX
                </div>

              </div>
              <div class="row profile-data">
                <div class="col-4 col-sm-4 col-xs-4">
                  Premium
                </div>
                <div class="col-8 col-sm-8 col-xs-8">
                  ${ result.rows[0].premium?"Subscribed":"Not Subscribed" }
                </div>
              </div>
            </div>
          </div>
          <div class="account-action desktop-hidden tablet-hidden">
            <div class="">
              <a href="#">Change Password</a>
            </div>
            <div class="">
              <a href="#">Change Mobile No</a>
            </div>
          </div>
        </div>
      </div>
      <div class="modal-container">
        <div class="modal-content">
          <form method="post" action="${pageContext.request.contextPath}/profile/upload-dp" enctype="multipart/form-data" >
            <header>
              <h2>Edit Profile Pic</h2>
              <span class="close">&times;</span>
            </header>
            <hr>
            <section>
              <div class="file-upload-area">
                <div id="dnd-file-upload">
                  <div>
                    Drag and drop a file here <br> Or
                  </div>
                  <div>
                    <label for="upload-user-file">Browse files</label>
                    <input type="file" id="upload-user-file" name="file" accept="image/*">
                  </div>
                </div>
                <div id="uploading-div">
                  Uploading ...
                </div>
                <div class="file-preview-div">
                  <img src="" id="file-preview">
                </div>
              </div>
            </section>
            <hr>
            <footer>
              <div class="form-input">
                <input name="folder" value="profile/${sessionScope.userid}" hidden="true">
                <input type="button" name="" value="Reset" id="reset-file-upload-btn">
                <input type="submit" id="submit-btn" value="Save"  disabled>
              </div>
            </footer>
          </form>
        </div>
      </div>
      <script>

        function clearFileInput() {
          let input=document.querySelector('#upload-user-file');
          let newInput=document.createElement("input");
          newInput.type="file";
          newInput.name=input.name;
          newInput.id=input.id;
          newInput.accept=input.accept;
          newInput.onchange=input.onchange;
          input.parentNode.replaceChild(newInput,input);
          document.querySelector("#dnd-file-upload").style.display='block';
          document.querySelector(".file-preview-div").style.display='none';
          document.querySelector("#uploading-div").style.display='none';
          document.querySelector('#submit-btn').disabled=true;
        }
        document.querySelector('.profile-pic').onclick=()=>{
          document.querySelector('.modal-container').style.display="block";
        };
        document.querySelector('.modal-container').onclick=evt=>{
          console.log(evt.target==document.querySelector('.modal-container') )
          console.log(evt.target==document.querySelector('.close') )
          if(evt.target==document.querySelector('.modal-container') || evt.target==document.querySelector('.close')){
          document.querySelector('#submit-btn').disabled=true;
          clearFileInput();
            document.querySelector('.modal-container').style.display="none";
          }
        }

        // file upload

        let show_file_preview=function () {
          document.querySelector("#dnd-file-upload").style.display='none';
          document.querySelector("#uploading-div").style.display='none';
          document.querySelector(".file-preview-div").style.display='block';
        }
        let file_uploading=function () {
          document.querySelector("#dnd-file-upload").style.display='none';
          document.querySelector("#uploading-div").style.display='block';
          document.querySelector(".file-preview-div").style.display='none';
        }
        document.querySelector('#reset-file-upload-btn').onclick= clearFileInput;
        let file_upload_area =document.querySelector(".file-upload-area");
        file_upload_area.ondragenter = file_upload_area.ondragover=evt=>{
          evt.preventDefault();
          event.target.classList.add('dragover')
        }
        file_upload_area.ondragleave = file_upload_area.ondragend=evt=>{
          event.target.classList.remove('dragover')
        }
        file_upload_area.ondrop=evt=>{
          evt.preventDefault();
          document.querySelector('#upload-user-file').files=evt.dataTransfer.files;
          event.target.classList.remove('dragover');
          readFile();

        }

        document.querySelector('#upload-user-file').onchange=readFile;

        function readFile(){
            file_uploading();
            let reader=new FileReader();
            reader.onload=event=>{
              let img=new Image();
                img.src=event.target.result;
                img.onload=()=>{
                  document.getElementById('file-preview').src=event.target.result;
                  show_file_preview();
                  document.querySelector('#submit-btn').disabled=false;
                }
                img.onerror=()=>{
                  alert("Something went wrong");
                  clearFileInput();
                }
            }
            reader.readAsDataURL(document.querySelector('#upload-user-file').files[0]);
          
        
        }

        
      </script>

    </c:if>
  </jsp:body>
</t:wrapper>
