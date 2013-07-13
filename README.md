jekyll-greycite
===============

Jekyll plugin providing a Liquid tag inserting bibliographic information links for blog posts, and scripts for 
walking a site and inserting posts into Greycite in bulk.


### Usage ###

In a Jekyll layout or page, use:  
```
{% greycite_bib_link  type: TYPE %}
```

where TYPE is one of "bib" (for BibTeX citation entry) or "ris" for RIS formatted entry.  These are the only 
two useful formats (for bibliography curation) that Greycite supports.  


The code generated is very vanilla HTML, targeting a new tab or window.  An example:

```html
<a href=http://greycite.knowledgeblog.org/ris/?uri=http://notebook.madsenlab.org/evolutionary%20theory/2013/06/13/gabora2013-response-notes.html 
target='_blank'>RIS Citation</a>
```

The Liquid tag can obviously be wrapped in whatever DIV or formatting you like, given your layout.  I find that Twitter
Bootstrap has some excellent formatting options and miniature icons.  

### Greycite Notes ###

In order for Greycite to usefully index your content, you should include metadata in the HEAD portion of your default HTML
template, so that Jekyll includes it in each completed HTML page.  Carl Boettiger has an excellent discussion of 
[semantic markup for his lab notebook](http://carlboettiger.info/2013/02/22/semantic-citations-for-the-notebook-and-knitr.html)
which I followed pretty exactly.  

My own layout includes metadata in Dublin Core, Google Scholar, and OpenGraph formats, and uses Jekyll variables to 
fill in many of the metadata aspects.  Here is a snapshot of my current metadata header, in case you just want to use it:

```html
<meta charset="utf-8"/>
    <title>{{ page.title }}</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="description" content="{{ site.title }}"/>
    <meta name="author" content="{{ site.author.name }}"/>

  <!-- Get date last modified from git log. (Uses current time if file entry not found, e.g. projects/)  -->
	{% capture modified %} {{ page.path | git_modified }} {% endcapture %}


	<!-- For posts, page.date is the date they are published under, which we use as their 'canonical' dc:date -->
	{% if page.date %} 
	  {% assign date = page.date %}
	  {% else %} <!-- If we don't have a page.date, then use modified time (pages) -->
	  {% assign date = modified %} 
	{% endif %}

	<!-- Posts declare modified timestamps in the sidebar, so would be redundant to put here. But then 
	     pages don't have a dc:modified... unless we give them their own (modified) sidebar?  
	-->
	<!-- Ideally we would want date originally created from the _oldest_ git commit too...-->

	<!-- RDFa Metadata (in DublinCore) -->
	<meta property="dc:title" content="{{ page.title }}" />
	<meta property="dc:creator" content="{{ site.author.name }}" />
	<meta property="dc:date" content="{{date | date_to_xmlschema }}" />
	<meta property="dc:format" content="text/html" />
	<meta property="dc:language" content="en" />
	<meta property="dc:identifier" content="{{ page.url }}" />
	<meta property="dc:rights" content="CC BY-NC-SA 3.0" />
	<meta property="dc:source" content="{{ site.title }}" />
	<meta property="dc:subject" content="Anthropology" /> 
	<meta property="dc:type" content="website" /> 
	<!-- RDFa Metadata (in OpenGraph) -->
	<meta property="og:title" content="{{ page.title }}" />
	<meta property="og:author" content="{{site.url}}/bio.html" />  <!-- Should be Liquid? URI? -->
	<meta property="og:site_name" content="{{ site.title }}" /> <!-- Same as dc:source? -->
	<meta property="og:url" content="{{site.url}}{{ page.url }}" />
	<meta property="og:type" content="website" /> 
	<!-- Google Scholar Metadata -->
	<meta name="citation_author" content="{{ site.author.name }}"/>
	<meta name="citation_date" content="{{date | date_to_xmlschema }}"/>
	<meta name="citation_title" content="{{page.title}}"/>
	<meta name="citation_journal_title" content="{{site.title}}"/>
```
