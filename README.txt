badger
    http://codefluency.rubyforge.org/badger
    by Bruce Williams (http://codefluency.com)

== DESCRIPTION:
  
Badger is a library used to generate badge sheets for events, given a PDF template
and data for the badges.

== FEATURES/PROBLEMS:
  
It's free, it's quick, and it's easy.  That being said, it requires a few things:

* That you have the [free] PDF Toolkit (http://accesspdf.com/pdftk) installed
* That you have a way to create the PDF template (using the full version of Adobe Acrobat, for instance)

== SYNOPSYS:

The process of creating badges is easy.

* Create a one-page PDF template with the badge design
* Create a file containing information on the people attending the event
* Run badger

Here's the details:

=== The PDF Template

Create a one-page PDF with the badge design you'd like to use.  Fit as many
badges in the page as you'd like.

For each badge, make fields as in the following example:

	For the first badge, fields "first_name1", "last_name1", "company1", "role1"
	.. badges 2 - 5 ...
	For the sixth badge, fields "first_name6", "last_name6", "company6", "role6"
	
You can use Adobe Acrobat to create the fields.

* Fields should be named consecutively from 1 to the number of the last badge on the page.  If the last
  badge has a field like "last_name8" it's assumed there are fields "last_name1" through "last_name7" somewhere
  on the page.
* What order the badges are in is completely up to you; left-to-right, top-to-bottom, etc
* With the exception of "first_name," use whatever field [base]names you like.  If you use "role" fields, however,
  keep in mind that, by default, it will be filled to "Attendee" if there if no data provided for the badge (you
  can override the default, as well, see "badger -h")

=== The Data Source

Create a YAML document.  Inside the document should be an array of hashes, as in the following example:

  ---
  - first_name: Foo
    last_name: Bar
    company: Foo Bar, Inc.
    role: Speaker
  - first_name: Jane
    last_name: Jungle
  - first_name: Yukihiro
    last_name: Matsumoto
    role: matz
 
You don't need to break them up by pages, or have them in any special order.

=== Building the badges

Assuming you have pdftk (in your PATH) and badger installed:

  badger -t your_template.pdf your_data.yml

See badger -h for more information about the possible options.  

== REQUIREMENTS:

PDF Toolkit, freely available from http://accesspdf.com/pdftk
* The pdftk executable must be in your PATH

Ruby requirements: activesupport

== INSTALL:

Install PDF Toolkit (http://accesspdf.com/pdftk)
sudo gem install badger

== LICENSE:

(The MIT License)

Copyright (c) 2006 Bruce Williams

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
