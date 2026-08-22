---
# FILE: ninad.md
# PURPOSE: Ninad (school magazine/PDF archive) listing page — card grid of downloadable PDFs.
layout: page
title: Ninad
subtitle: Click thumbnail to download ninad
---

<!-- Page-specific styles for PDF Card Layout and Flexbox Reordering -->
<style>
  /* Flexbox grid wrapping container for document cards */
  .pdf-grid-container {
    display: flex;
    flex-wrap: wrap;
    gap: 30px;
    justify-content: center;
    padding: 20px 0;
  }

  /* Individual card container styling */
  .ninad-card {
    display: flex;
    flex-direction: column;
    width: 220px;
    background-color: white; /* Card background */
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    transition: transform 0.2s ease;
    overflow: hidden; 
  }

  /* Interactive hover state for card lift effect */
  .ninad-card:hover {
    transform: translateY(-8px);
  }

  /* Caption banner layout & typography settings */
  .ninad-caption-banner {
    background-color: #f7fff7; /* Subtle greenish-white background */
    color: #333; /* Dark text for visual contrast */
    padding: 12px 5px;
    text-align: center;
    font-weight: 600;
    font-size: 1rem;
    margin: 0;
    
    /* 
       Flexbox ordering: order: 1 moves the caption block below 
       unassigned/default order: 0 elements (like the image link)
    */
    order: 1; 
    margin-top: 15px; /* Spacing between thumbnail and text */
    border-top: 1px solid #e0e0e0; /* Subtle divider line above caption */
  }

  /* Enforces fixed height and aspect ratio cropping for PDF thumbnails */
  .ninad-card img {
    width: 100%;
    height: 300px; 
    object-fit: cover;
    display: block;
  }
</style>

<!-- Main Container for Ninad PDF Cards -->
<div class="pdf-grid-container">

  <!-- Ninad Issue 2025-26 -->
  <figure class="ninad-card">
    {% include pdf.html 
       thumbnail_path="/assets/Ninads/25-26.png" 
       pdf_path="https://drive.google.com/uc?export=download&id=1BOHZ1iYSJ9j9mpoCR4AyvWRJUxMwauNh" 
       only_thumbnail=true %} 
    <figcaption class="ninad-caption-banner">Ninad 2025-26</figcaption>
  </figure>

  <!-- Ninad Issue 2023-24 -->
  <figure class="ninad-card">
    {% include pdf.html 
       thumbnail_path="/assets/Ninads/23-24.png" 
       pdf_path="https://drive.google.com/uc?export=download&id=161g-gIkPTlV3mbLBJH5srVOQKo626C26" 
       only_thumbnail=true %} 
    <figcaption class="ninad-caption-banner">Ninad 2023-24</figcaption>
  </figure>

  <!-- Ninad Issue 2020-21 -->
  <figure class="ninad-card">
    {% include pdf.html 
       thumbnail_path="/assets/Ninads/20-21.png" 
       pdf_path="https://drive.google.com/uc?export=download&id=1PHivXhIcHCvNP4rXcgtujfAU9xH9wEFF" 
       only_thumbnail=true %}
    <figcaption class="ninad-caption-banner">Ninad 2020-21</figcaption>
  </figure>

  <!-- Ninad Issue 2019-20 -->
  <figure class="ninad-card">
    {% include pdf.html 
       thumbnail_path="/assets/Ninads/19-20.png" 
       pdf_path="https://drive.google.com/uc?export=download&id=19S9ppPF3vfPfE5EKnAzJYvylu442QgLg" 
       only_thumbnail=true %}
    <figcaption class="ninad-caption-banner">Ninad 2019-20</figcaption>
  </figure>

  <!-- Ninad Issue 2017 -->
  <figure class="ninad-card">
    {% include pdf.html 
       thumbnail_path="/assets/Ninads/17.png" 
       pdf_path="https://drive.google.com/uc?export=download&id=1w8JTz5IaMSysoqtxqyiFksKrQ9it64VJ" 
       only_thumbnail=true %} 
    <figcaption class="ninad-caption-banner">Ninad 2017</figcaption>
  </figure>

</div>
