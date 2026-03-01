---
layout: page
title: Photos
subtitle: Click on thumbnail to open the album
---

<div class="album-grid" id="album-container">
  {% comment %} 
    'reverse' ensures the newest albums (2026) appear first, 
    fixing the order issues seen in your screenshot.
  {% endcomment %}
  {% assign sorted_albums = site.albums | reverse %}
  
  {% for album in sorted_albums %}
    <figure class="album-item" style="display: none;">
        <a href="{{ album.link }}" target="_blank">
            <img src="{{ album.img | relative_url }}" alt="{{ album.title }}">
        </a>
        <figcaption>
          <strong>{{ album.title }}</strong><br>
          {{ album.date }}
        </figcaption>
    </figure>
  {% endfor %}
</div>

<div style="text-align: center; margin: 50px 0;">
    <button id="loadMore" class="btn-load-more">
        Load More Albums
    </button>
</div>

<script>
  document.addEventListener("DOMContentLoaded", function() {
    const itemsPerPage = 10; // Reduced because items are now 2x larger
    const items = Array.from(document.querySelectorAll('.album-item'));
    const loadMoreBtn = document.getElementById('loadMore');
    let currentIndex = 0;

    function showNextItems() {
      const nextSet = items.slice(currentIndex, currentIndex + itemsPerPage);
      nextSet.forEach(item => item.style.display = 'flex');
      currentIndex += itemsPerPage;

      if (currentIndex >= items.length) {
        loadMoreBtn.style.display = 'none';
      }
    }

    showNextItems();
    loadMoreBtn.addEventListener('click', showNextItems);
  });
</script>
