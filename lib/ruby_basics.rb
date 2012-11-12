require "course"

class Course
  RubyBasics = Course.new("ruby_basics") do
    lesson "more_neat_things"
    lesson "functions"
    lab "hello"
    lesson "types"
    lesson "numbers"
    lab "temperature"
    lab "calculator"
    lesson "conditionals"
    lesson "strings"
    lesson "chaining"
    lab "simon_says"
    lesson "regexp"
    lab "pig_latin"
    lesson "symbols"
    lesson "loops"
    lesson "collections"
    lesson "arrays"
    # todo: lab on arrays
    lesson "ranges"
    lesson "hashes"
    # todo: lab on hashes
    lesson "exceptions"
    #todo: lab "exceptions"

    #lesson "time"
    #lesson "io"
    #todo: lab on file/io exercise, like scraper

  end
end
