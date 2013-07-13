require 'anemone'
require 'rubygems'
require 'mechanize'

root = 'http://notebook.madsenlab.org/'
Anemone.crawl(root, :discard_page_bodies => false) do |anemone|
  anemone.after_crawl do |pagestore|

    greycite_links = Hash.new { |h, k| h[k] = [] }

    pagestore.each_value do |page|

      if page.code != 200
        puts "#{page.url} link is broken"
      else

      # construct the Greycite URL reuqest for our URL

      # call the URL using Mechanize

      # Get the bibtex chunk corresponding to our URL
      # curl http://greycite.knowledgeblog.org/bib/\?uri\=http://notebook.madsenlab.org/coarse%20grained%20model%20project/2012/10/02/coarse-graining-history-ctmodels.html
        # returns a raw bibtex chunk....


      end
    end
  end
end