---
# FILE: geeth-gunjan.md
# PURPOSE: Geeth Gunjan document listing page. NOTE: known issue — two cards share the same
# Google Drive thumbnail ID; needs the correct second document ID from the site owner.
layout: page
title: Geet Gunjan
subtitle: Click thumbnail to download Geeth Gunjan
permalink: /geeth
---
<!-- Embedded CSS Stylesheet for PDF Card Grid & Layout Styling -->
<style>
  /* Flexbox Grid Container to horizontally align and wrap document cards */
  .pdf-grid-container {
    display: flex;
    flex-wrap: wrap;
    gap: 30px;
    justify-content: center;
    padding: 20px 0;
  }
  /* Structural Card Component for individual PDF downloads */
  .ninad-card {
    display: flex;
    flex-direction: column;
    width: 220px;
    background-color: white;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    transition: transform 0.2s ease;
    overflow: hidden; 
  }
  /* Interactive hover lift effect */
  .ninad-card:hover {
    transform: translateY(-8px);
  }
  /* Caption Banner styling displayed below the thumbnail */
  .ninad-caption-banner {
    background-color: #f7fff7; 
    color: #333; 
    padding: 12px 5px;
    text-align: center;
    font-weight: 600;
    font-size: 1rem;
    margin: 0;
    order: 1; 
    margin-top: 15px; 
    border-top: 1px solid #e0e0e0; 
  }
  /* Forces uniform height and aspect-ratio cropping across all card thumbnails */
  .ninad-card img {
    width: 100%;
    height: 300px; 
    object-fit: cover;
    display: block;
  }
</style>
<!-- Main Container holding the Geet Gunjan PDF items -->
<div class="pdf-grid-container">
  <!-- Document Card 1: English Transliterated Version -->
  <figure class="ninad-card">
    {% include pdf.html 
       thumbnail_path="https://drive.google.com/thumbnail?id=1jMUgEMR5LOFygyomN17iWU47JBsXrTOR&sz=s0"
       pdf_path="https://drive.google.com/uc?export=download&id=1o1U1PIGIDH2eo_rkz38BUjVd5DxU5sDt" 
       only_thumbnail=true %} 
    <figcaption class="ninad-caption-banner">Geet Gunjan (English Transliterated)</figcaption>
  </figure>
  <!-- Document Card 2: Original Version -->
  <figure class="ninad-card">
    {% include pdf.html 
       thumbnail_path="https://drive.google.com/thumbnail?id=1jMUgEMR5LOFygyomN17iWU47JBsXrTOR&sz=s0"
       pdf_path="https://drive.google.com/uc?export=download&id=1ybQifay7oFupzEqj_le-JemM0szJZEEo" 
       only_thumbnail=true %} 
    <figcaption class="ninad-caption-banner">Geet Gunjan (Original)</figcaption>
  </figure>
</div>
