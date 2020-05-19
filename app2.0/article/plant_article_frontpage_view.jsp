<div class="plant-frontpage">

  <div>
    <div class="filter-item">
      <input type="text" name="filter-plant" placeholder="Filter by Crop Name">
    </div>
  </div>
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
<script type="text/javascript">
  var v=document.querySelector('.plant-frontpage > .parent').children;
  document.querySelector("input[name='filter-plant']").onkeyup=evt=>{

    for (var i of v) {
      i.classList.remove("hidden");
      if(evt.target.value!="" && !i.innerText.toLowerCase().includes(evt.target.value.toLowerCase())){
        console.log(evt.target.value.toLowerCase());
        i.classList.add("hidden");
      }
    }
  }
</script>
