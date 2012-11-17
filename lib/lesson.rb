require 'erector'
require 'active_support'
require 'deck'

class Lesson < Erector::Widget

  external :style, "
  a.button {
    padding: .2em .5em;
    border: 1px solid blue;
    background-color: #EEEEF2;
    display: block;
    text-decoration: none;
  }


  .extras {
    float:right;
    margin-right: 1em;
    min-width: 10em;
    border-left: .5em solid white;
  }
  .extras a.button {
    border-top: none;
  }
  .extras a.button:first-child {
    border-top: 1px solid blue;
  }


  div.next_and_previous a.next_lesson {
    float: right;
    margin-right: -1em;
  }
  div.next_and_previous a.previous_lesson {
    float: left;
    margin-left: -1em;
  }
  div.next_and_previous {
    margin: 2px;
    height: 3em;
  }
  div.footer {
    clear: both;
  }

  div.toc {
    margin-top: 1em;
    margin-bottom: 1em;
    font-size: 80%;
    background-color: white;
    border: 1px solid gray;
  }
  div.toc h2 {
    margin: 0;
    padding-left: 5px;
    border-bottom: 1px dashed gray;
  }
  div.toc ul {
    list-style: none;
    padding: .5em .2em;

    -webkit-margin-before: 0;
    -webkit-margin-after: 0;
    -webkit-margin-start: 0;
    -webkit-margin-end: 0;
    -webkit-padding-start: 0;
  }
  div.toc li {
  }
  div.toc a {
    padding: 2px 10px;
    text-decoration: none;
    color: black;
    display: block;
  }
  div.toc a:visited {
    color: black;
  }
  div.toc a:hover {
    color: blue;
    text-decoration: underline;
    background: #EEEEF2;
  }

  div#disqus_thread {
    border-top: 1px dotted gray;
    padding-top: 1em;
  }
"

  attr_reader :name

  def initialize course, name
    @course, @name = course, name
    @videos = []
  end

  def display_name
    name.titleize
  end

  def href
    @course.href + "/" + name
  end

  def video youtube_id
    @videos << youtube_id
  end

  def content
    div.extras {
      a.slides.button "Slides", href: "#{name}.slides"
      next_labs.each do |lab|
        widget lab
      end

      div.toc {
        h2 "Contents"
        ul {
          slides.each do |slide|
            li {
              a slide.title, href: "##{slide.slide_id}"
            }
          end
        }
      }
      div {
        next_lesson_button
      }
    }
    widget Breadcrumbs, :parents => [Courses.new, @course], :display_name => display_name

    div.videos {
      @videos.each do |youtube_id|
        # see https://developers.google.com/youtube/player_parameters
        s = %Q(<iframe class="video youtube" type="text/html" width="640" height="390" src="http://www.youtube.com/embed/#{youtube_id}" frameborder="0"></iframe>\n)
        rawtext s
      end
    }

    div.main_column {
      slides.each do |slide|
        widget slide
      end

      div.next_and_previous do
        next_lesson_button
        previous_lesson_button
      end

      widget Disqus, shortname: "codelikethis", developer: (Thread.current[:development] ? 1 : nil), identifier: "lesson_#{@course.name}_#{name}", title: "#{@course.display_name}: #{display_name}"
    }
  end

  def previous_lesson_button
    if previous_lesson
      a.button.previous_lesson href: previous_lesson.name do
        text "<< "
        text "Previous: "
        text previous_lesson.display_name
      end
    end
  end

  def next_lesson_button
    if next_lesson
      a.button.next_lesson href: next_lesson.name do
        text "Next: "
        text next_lesson.display_name
        text " >>"
      end
    end
  end

  def slides
    Deck::Slide.from_file File.new(File.join(@course.dir, "#{@name}.md"))
  end

  def next_lesson
    @course.next_lesson(name)
  end

  def previous_lesson
    @course.previous_lesson(name)
  end

  def next_labs
    @course.next_labs(name)
  end

  def video?
    !@videos.empty?
  end

end
