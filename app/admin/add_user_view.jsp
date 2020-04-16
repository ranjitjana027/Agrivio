<form action="add_user.jsp" method="post">
  <div class="errormessage">
    <span style="background-color: white; box-shadow: 2px 2px 10px 2px #000000; padding:5px 15px; "> Some Error Occured while adding new article.
    <span style="background-color: white; cursor:pointer;" onclick="this.parentNode.hidden=true;"> &#10007; </span></span>
  </div>
  <div class="page-header">Add a user </div>

  <div class="">
    <div class="form-input">
      <label for="firstname">First Name</label>
      <input type="text" name="firstname" value="" required placeholder="First Name" id="firstname">
    </div>
    <div class="form-input">
      <label for="">Last Name</label>
      <input type="text" name="lastname" required placeholder="Last Name" value="">
    </div>
  </div>
  <div class="">
    <div class="form-input">
      <label for="">Mobile No</label>
      <input type="number" name="mobile"  placeholder="Mobile No" required value="">
    </div>
    <div class="form-input">
      <label for="">Email (Optional)</label>
      <input type="email" name="email" value="" placeholder="abc@example.com">
    </div>

  </div>
  <div class="">
    <div class="form-input">
      <label for="">Password</label>
      <input type="password" name="password1"  required minlength="8" placeholder="Password" value="">
    </div>
    <div class="form-input">
      <label for="">Confirm Password</label>
      <input type="password" name="password2" required minlength="8" placeholder="Confirm Password" value="">
    </div>
  </div>
  <div class="">
    <div class="form-input">
      <label for="">Role</label>
      <select class="" name="role">
        <option value="ADMIN">Admin</option>
        <option value="EXPERT">Expert</option>
        <option value="FARMER">Farmer</option>
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
