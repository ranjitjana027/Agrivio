<div class="plant-frontpage">


    <div class="filter-item">
      <input type="text" name="filter-plant" placeholder="Filter by Crop Name">
    </div>
    <div class="no-result hidden">
      <header>
        No Result Found
        <span>Try searching with other keywords.</span>
      </header>
    </div>
    <div class="search-result">
      <header>
        Crop Cultivation Guides
        <span>Click on a crop to get detailed article on how to cultivate it.</span>
      </header>
      <div class="parent">
        <div class="custom-class">
          <div class="plant-article-card">
            <div class="article-image">
              <a href="#"><img src="../../assets/img/homepage.jpg" alt=""></a>
            </div>
            <div class="plant-name">
              <a href="#">Lorem ipsum dolor</a>
            </div>
          </div>
        </div>
        <div class="custom-class">
          <div class="plant-article-card">
            <div class="article-image">
              <a href="#"><img src="../../assets/img/homepage.jpg" alt=""></a>
            </div>
            <div class="plant-name">
              <a href="#">Aliquam volutpat ligula</a>
            </div>
          </div>
        </div>
        <div class="custom-class">
          <div class="plant-article-card">
            <div class="article-image">
              <a href="#"><img src="../../assets/img/homepage.jpg" alt=""></a>
            </div>
            <div class="plant-name">
              <a href="#">Praesent venenatis ligula</a>
            </div>
          </div>
        </div>
        <div class="custom-class">
          <div class="plant-article-card">
            <div class="article-image">
              <a href="#"><img src="../../assets/img/homepage.jpg" alt=""></a>
            </div>
            <div class="plant-name">
              <a href="#">Fusce facilisis</a>
            </div>
          </div>
        </div>
        <div class="custom-class">
          <div class="plant-article-card">
            <div class="article-image">
              <a href="#"><img src="../../assets/img/homepage.jpg" alt=""></a>
            </div>
            <div class="plant-name">
              <a href="#">Aenean vulputate</a>
            </div>
          </div>
        </div>
        <div class="custom-class">
          <div class="plant-article-card">
            <div class="article-image">
              <a href="#"><img src="../../assets/img/homepage.jpg" alt=""></a>
            </div>
            <div class="plant-name">
              <a href="#">Phasellus ultricies</a>
            </div>
          </div>
        </div>
        <div class="custom-class">
          <div class="plant-article-card">
            <div class="article-image">
              <a href="#"><img src="../../assets/img/homepage.jpg" alt=""></a>
            </div>
            <div class="plant-name">
              <a href="#">hendrerit pellentesque </a>
            </div>
          </div>
        </div>
        <div class="custom-class">
          <div class="plant-article-card">
            <div class="article-image">
              <a href="#"><img src="../../assets/img/homepage.jpg" alt=""></a>
            </div>
            <div class="plant-name">
              <a href="#">Aenean vel tristique</a>
            </div>
          </div>
        </div>
        <div class="custom-class">
          <div class="plant-article-card">
            <div class="article-image">
              <a href="#"><img src="../../assets/img/homepage.jpg" alt=""></a>
            </div>
            <div class="plant-name">
              <a href="#">nulla eros ultrices</a>
            </div>
          </div>
        </div>
        <div class="custom-class">
          <div class="plant-article-card">
            <div class="article-image">
              <a href="#"><img src="../../assets/img/homepage.jpg" alt=""></a>
            </div>
            <div class="plant-name">
              <a href="#">Aliquam sed</a>
            </div>
          </div>
        </div>
      </div>
    </div>


</div>
<script type="text/javascript">
  var v=document.querySelector('.plant-frontpage > .search-result > .parent').children;
  document.querySelector("input[name='filter-plant']").onkeyup=evt=>{
    var flag=false;
    for (var i of v) {
      i.classList.remove("hidden");
      if(evt.target.value.trim()!="" && !i.innerText.toLowerCase().includes(evt.target.value.trim().toLowerCase())){
        i.classList.add("hidden");
      }
      else {
        flag=true;
      }
    }

    if(!flag){
      document.querySelector(".search-result").classList.add("hidden");
      document.querySelector(".no-result").classList.remove("hidden");
    }
    else{
      document.querySelector(".search-result").classList.remove("hidden");
      document.querySelector(".no-result").classList.add("hidden");
    }
  }
</script>
