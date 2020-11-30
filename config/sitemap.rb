require 'rubygems'
require 'sitemap_generator'

SitemapGenerator::Sitemap.default_host = 'https://safe-forest-76649.herokuapp.com/'
SitemapGenerator::Sitemap.create do
  add '/home', :changefreq => 'daily', :priority => 0.9
  add '/contact_us', :changefreq => 'weekly'
  add '/products', :changefreq => 'daily'
  add '/blog', :changefreq => 'daily'
end
SitemapGenerator::Sitemap.ping_search_engines # Not needed if you use the rake tasks