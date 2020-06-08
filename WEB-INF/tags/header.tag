
<div class="page-header">
  <div class="header-top">
      <div class="top-subheader row">
        <div class="col-xs-4 col-sm-2 desktop-hidden menu-icon-container" style="">
          <div class="menu-icon">

          </div>
        </div>

        <div class="col-3 col-sm-3 mobile-hidden  main-logo">
          <a href="${pageContext.request.contextPath}/index">Agriculture</a>

        </div>

        <!--div class="col-6 tablet-hidden mobile-hidden caption" >
          An ambitious agricultural expermient
        </div-->
        <div class="col-9 col-xs-8 col-sm-7 user-nav-bar" style="">

          <!-- Search Box for tablet and desktop -->
          <div class="search-box mobile-hidden">
            <form action="search" id="search-form" >
              <div class="inline-input" style="">
                <input type="search" name="q" placeholder="Search...">
              </div>
              <div class="search-icon" onclick="document.querySelector('#search-form').submit();">
                 <svg viewBox="0 0 20 20">
                    <circle cx="8" cy="10" r="7" fill="none" stroke="snow" stroke-width="2px" />
                    <path d="M13,13 L20,19" stroke="snow" stroke-width="4px" />
                  </svg>
              </div>
            </form>
          </div>
          <!-- search icon logo for mobile-->
          <div class="search-logo tablet-hidden desktop-hidden">
            <svg viewBox="0 0 40 40">
              <circle cx="20" cy="20" r="10" stroke="white" stroke-width="3px" fill="none" />
              <path d="M28,28 L35,33" stroke="white" stroke-width="5px"/>
            </svg>
          </div>
          <!-- notification bell icon -->
          <div class="bell-icon">
            <svg width="60px" viewBox="0 0 100 100" style="position:relative;">
              <path d="M0,85 S15,85 20,35 A10,10 0 0,1 80,35 S85,85 100,85 z" stroke-width="1px"  />
              <circle cx="50" cy="2" r="7" stroke-width="1px" />
              <path d="M35,87 A17,17 0 0,0 65,87" stroke-width="1px"/>
              <div>25</div>
            </svg>
          </div>
          <!-- notification list -->
          <div class="notification-list hidden">
            <div class="notification-header" >
              <header>
                Notifications
              </header>
            </div>
            <div class="notifications">
              <div class="notification">
                Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                Nullam eu suscipit dolor. Curabitur eget faucibus odio.
              </div>
              <div class="notification">
                Quisque condimentum lacinia felis, ut commodo ligula rhoncus eu.
                Vivamus interdum purus nisl, eget pulvinar sem pellentesque nec.
              </div>
              <div class="notification">
                Nullam sodales est a dui laoreet, facilisis hendrerit dui commodo.
                Integer ac massa nibh. In sagittis nisl sed dolor vehicula, eget accumsan odio ullamcorper.
              </div>
              <div class="notification">
                Nulla posuere lacus eu arcu luctus mattis.
                Pellentesque varius nisi dui, vel convallis ligula egestas porttitor.
              </div>
              <div class="notification">
                Class aptent taciti sociosqu ad litora torquent per conubia nostra,
                per inceptos himenaeos.
                Quisque tincidunt nunc eu placerat laoreet.
              </div>
              <div class="notification">
                Nunc erat lorem, consectetur sed viverra at, finibus ut massa.
                Sed ligula leo, fringilla a dapibus vel, venenatis at velit.
              </div>
              <div class="notification">
                Integer vel lacus malesuada, laoreet est a, convallis ipsum.
                Nulla tincidunt neque non dui aliquet condimentum.
              </div>
              <div class="notification">
                Vestibulum tincidunt volutpat tempor.
                Vivamus congue hendrerit iaculis.
              </div>
              <div class="notification">
                Praesent placerat lectus eros, a bibendum velit ullamcorper quis.
                Vestibulum sagittis felis sodales sagittis mattis.
              </div>
              <div class="notification">
                Vivamus pulvinar tortor eros, auctor eleifend tellus pellentesque in.
                Maecenas in placerat nisi, id euismod massa.
              </div>
            </div>

          </div>

          <!-- user icon -->
          <div class="user-icon-container">
            <svg class="user-icon" viewBox=" 0 0 40 40">
              <defs>
                <pattern id="user-icon-pattern" x="0" y="0" height="200" width="200" patternUnits="userSpaceOnUse" >
                  <circle cx="20" cy="14" r="9" stroke="black" fill="none" stroke-width="2px" />
                  <path d="M0,40 S20,0 40,40" stroke="black" fill="none" stroke-width="2px" />
                </pattern>
              </defs>
              <circle cx="20" cy="20" r="20" stroke="black"  fill="url(#user-icon-pattern)" stroke-width="2px" />
            </svg>
          </div>
          <!-- account navigation -->
          <div class="account-nav hidden" >
            <ul>
              <li><a href="${pageContext.request.contextPath}/latest/profile">Account</a> </li>
              <li><a href="#">Subscription</a> </li>
              <li><a href="${pageContext.request.contextPath}/logout">Logout</a> </li>
            </ul>
          </div>

        </div>
      </div>
  </div>
  <div class="header-bottom">
    <!-- mobile search bar -->
    <div class="mobile-search-bar" >
      <div class="search-box desktop-hidden tablet-hidden">
        <form action="search" id="search-form-mobile" >
          <div class="inline-input" >
            <input type="search" name="q"  placeholder="Search...">
          </div>
          <div class="search-icon" onclick="document.querySelector('#search-form-mobile').submit();" style="">
             <!---svg viewBox="0 0 20 20">
                <circle cx="8" cy="10" r="7" fill="none" stroke="snow" stroke-width="2px" />
                <path d="M13,13 L20,19" stroke="snow" stroke-width="4px" />
              </svg-->
              <span>&#10153;</span>
          </div>
        </form>
      </div>
    </div>
    <!--user nav link -->
    <div class="row user-nav" >
      <div  class="col-12 col-sm-12 col-xs-12">
        <ul>
          <li class="desktop-hidden tablet-hidden">
            <a href="${pageContext.request.contextPath}/index">Home</a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/latest/suggestion/crops">Suggestion</a>
          </li>
          <li >
            <a href="${pageContext.request.contextPath}/latest/article/all"><span class="desktop-hidden">Cultivation </span> Guides</a>
          </li>

          <li>
            <a href="${pageContext.request.contextPath}/latest/price/crops" >Crop Price</a>
          </li>
          <!--li>
            <a href="/weather" id="link-forecast"><span class="desktop-hidden">Weather </span> Forecast</a>
          </li-->
          <li>
            <a href="${pageContext.request.contextPath}/latest/events" ><span class="desktop-hidden">Cultivation </span> Events</a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/latest/ask-expert">Ask Expert</a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/latest/article/plants/all">Plants</a>
          </li>
          <li>
            <a href="${pageContext.request.contextPath}/latest/article/pests/all">Pests</a>
          </li>
          <li>
            <a href="#">About <span class="desktop-hidden"> Website</span></a>
          </li>
          <li>
            <a href="#">Contact <span class="desktop-hidden"> Us</span></a>
          </li>

        </ul>
      </div>
    </div>
  </div>
</div>
