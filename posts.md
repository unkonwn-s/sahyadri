---
layout: page
title: Photos
subtitle: Click on thumbnail to open the album
---

<div class="album-grid" id="album-container">
  {% assign sorted_albums = site.albums | reverse %}
  {% for album in sorted_albums %}
    <figure class="album-item" style="display: none;"> <a href="{{ album.link }}" target="_blank">
            <img src="{{ album.img | relative_url }}" alt="{{ album.title }}">
        </a>
        <figcaption>{{ album.title }}, {{ album.date }}</figcaption>
    </figure>
  {% endfor %}
</div>

<div style="text-align: center; margin: 40px 0;">
    <button id="loadMore" class="btn btn-primary" style="font-family: 'Amatic SC', cursive; font-size: 1.5rem; padding: 10px 30px;">
        Load More Albums
    </button>
</div>

<script>
  document.addEventListener("DOMContentLoaded", function() {
    const itemsPerPage = 20;
    const items = Array.from(document.querySelectorAll('.album-item'));
    const loadMoreBtn = document.getElementById('loadMore');
    let currentIndex = 0;

    function showNextItems() {
      const nextSet = items.slice(currentIndex, currentIndex + itemsPerPage);
      nextSet.forEach(item => item.style.display = 'block');
      currentIndex += itemsPerPage;

      // Hide button if no more items
      if (currentIndex >= items.length) {
        loadMoreBtn.style.display = 'none';
      }
    }

    // Show first 20 on load
    showNextItems();

    loadMoreBtn.addEventListener('click', showNextItems);
  });
</script>
