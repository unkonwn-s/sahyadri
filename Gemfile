# frozen_string_literal: true

# ==============================================================================
# RubyGems Source Configuration
# Sets the standard package repository for all required gems.
# ==============================================================================
source "https://rubygems.org"

# ------------------------------------------------------------------------------
# GitHub Pages Environment Synchronization
# The 'github-pages' metapackage locks Jekyll, Kramdown, Liquid, and all standard
# GitHub Pages plugins to match GitHub's live build environment exactly.
# ------------------------------------------------------------------------------
group :jekyll_plugins do
  gem "github-pages"
end

# ------------------------------------------------------------------------------
# Windows & JRuby Platform Support
# Ensures timezone data is available on environments (like Windows) that lack 
# native system timezone database access.
# ------------------------------------------------------------------------------
platforms :mingw, :x64_mingw, :mswin, :jruby do
  gem "tzinfo", ">= 1", "< 3"
  gem "tzinfo-data"
end

# ------------------------------------------------------------------------------
# Windows Directory Watcher
# Provides native directory polling optimizations when running 'jekyll serve'
# on Windows environments.
# ------------------------------------------------------------------------------
gem "wdm", "~> 0.1", platforms: [:mingw, :x64_mingw, :mswin]

# ------------------------------------------------------------------------------
# Local Gem Specification
# Includes additional dependencies defined in the repository's .gemspec file 
# (useful when developing Beautiful Jekyll as a gem or theme plugin).
# ------------------------------------------------------------------------------
gemspec
