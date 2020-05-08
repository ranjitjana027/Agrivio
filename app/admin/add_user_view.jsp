<script src="${pageContext.request.contextPath}/assets/js/lib/custom-select.js" charset="utf-8"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/lib/custom-select.css">
<div class="page-header">Add a user </div>
<form  method="post">
  <% if(!request.getParameter("errormessage").equals("")){ %>
  <div class="errormessage">
    <span style="background-color: white; box-shadow: 2px 2px 10px 2px #000000; padding: 5px 15px; "> <%= request.getParameter("errormessage") %>.
    <span style="background-color: white; cursor:pointer;" onclick="this.parentNode.hidden=true;"> &#10007; </span></span>
  </div>
  <% } %>
  <% if(!request.getParameter("message").equals("")){ %>
  <div class="errormessage" style="color:green;">
    <span style="background-color: white; box-shadow: 2px 2px 10px 2px #000000; padding: 5px 15px; "> <%= request.getParameter("message") %>.
    <span style="background-color: white; cursor:pointer;" onclick="this.parentNode.hidden=true;"> &#10004; </span></span>
  </div>
  <% } %>


  <div class="">
    <div class="form-input">
      <label for="firstname">First Name</label>
      <input type="text" name="firstname" value="" required placeholder="First Name" id="firstname">
    </div>
    <div class="form-input">
      <label for="lastname">Last Name</label>
      <input type="text" name="lastname" required placeholder="Last Name" value="" id="lastname">
    </div>
  </div>
  <div class="">
    <div class="form-input">
      <label for="mobile">Mobile No</label>
      <input type="text" pattern="\d*" name="mobile"  placeholder="10 Digit Mobile No" id="mobile" minlength=10 maxlength="10" required value="">
    </div>
    <div class="form-input">
      <label for="email">Email (Optional)</label>
      <input type="email" name="email" value="" placeholder="abc@example.com" id="email">
    </div>

  </div>
  <div class="">
    <div class="form-input">
      <label for="password1">Password</label>
      <input type="password" name="password1" id="password1"  required minlength="8" maxlength="20" placeholder="Password" value="">
    </div>
    <div class="form-input">
      <label for="password2">Confirm Password</label>
      <input type="password" name="password2" id="password2" required minlength="8" maxlength="20" placeholder="Confirm Password" value="">
    </div>
  </div>
  <div class="">
    <div class="form-input">
      <label for="role">Role</label>
      <select class="form-select" name="role" id='role' required>
        <option value="" disabled>Choose an option</option>
        <option value="ADMIN">Admin</option>
        <option value="EXPERT">Expert</option>
        <option value="FARMER">Farmer</option>
      </select>
    </div>
    <div class="form-input">
      <label for="premium">Premium User</label>
      <select class="form-select" name="premium" id="premium">
        <option value="" disabled>Choose an option</option>
        <option value="true">Yes</option>
        <option value="No">No</option>
      </select>

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
<script src="${pageContext.request.contextPath}/assets/js/admin/add_user.js" charset="utf-8"></script>
