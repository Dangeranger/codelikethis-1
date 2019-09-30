require 'erector'
require 'views'

require 'util'
require 'track'
require 'tracks_table'

require 'site'
require 'nav_bar'

class Bootcamp < Site

  # base site has all tracks
  def hostname
    ["bootcamp.burlingtoncodeacademy.com", "bootcamp", "localhost"]
  end

  def google_calendar_id
    'YnVybGluZ3RvbmNvZGVhY2FkZW15LmNvbV9hazFxMDRvNzBwYXBqODJkb2ZsYXVnMGM1c0Bncm91cC5jYWxlbmRhci5nb29nbGUuY29t'
  end

  def tracks
    [
      ::Track::Javascript,
      ::Track::Www,
      ::Track::ResponsiveLayout,
      ::Track::ClientSideCoding,
      ::Track::Bootstrap,
      ::Track::ServerSideJavascript,
      ::Track::Oo,
      ::Track::Db,
      ::Track::React,

      ::Track::Separator,

      ::Track::Prerequisites,
      ::Track::Agile,
      ::Track::Git,
      ::Track::TricksOfTheTrade, # or "trade secrets" ?
      ::Track::Career,
    ]
  end

  def view
    View.new(site: self)
  end

  class View < Erector::Widget
    def content
      div.row {
        div(class: 'col-sm') {
          div.card {
            div(class: 'card-body') {
              p(class: 'card-text') {
                b "Burlington Code Academy"
                text " offers in-person coding classes in Burlington, Vermont."
              }
              p(class: 'card-text') {
                text "This site contains the curriculum for our "
                a "2018 Web Development Bootcamp", href: "http://www.burlingtoncodeacademy.com/bootcamp/"
                text "."
              }
            }
          }
          br
          div.card {
            div(class: 'card-body') {
              p(class: 'card-text') {
                h2 "What next?"
                ul {
                  li {
                    text "Peruse the "
                    i(class: 'fas fa-angle-double-left')
                    b "Tracks"
                    i(class: 'fas fa-angle-double-left')
                    text " in the sidebar to see what we are teaching."
                  }
                  li {
                    text "Look at the "
                    a "class schedule", href: "/schedule"
                    text " or a "
                    a "list of possible projects", href: "/projects"
                    text " the students will work on during the course."
                  }
                  li {
                    text "Browse the "
                    a "GitHub repository", href: "http://github.com/alexch/codelikethis"
                    text "."
                  }
                  li {
                    text "Visit the central "
                    a "Code Like This", href: "http://codelikethis.com/"
                    text " site, with even more lessons."
                  }
                }
              }
            }
          }
          div.card do
            div(class: "help", style: 'border: 10px solid #ddddee') {
              img(src: "/images/tracks-lessons-slides.png")
            }
          end
        }
      }

    end
  end

  class NavBar < ::NavBar
    def logo klass: nil, style: nil
      a(href: '/',
        class: 'navbar-brand') {
        img.logo(src: '/images/burlingtoncodeacademy-logo.png',
                 width: 265, height: 36,
                 alt: "Burlington Code Academy",
                 class: ['logo', klass].compact,
                 style: [style].compact)
      }
    end

    def nav_items
      nav_item name: "Bootcamp", href: "http://www.burlingtoncodeacademy.com/bootcamp/"
      nav_item name: "Hire Our Grads", href: "http://www.burlingtoncodeacademy.com/hiring-partners/"
      nav_item name: "Events", href: "http://www.burlingtoncodeacademy.com/events/"
      nav_item name: "Blog", href: "http://www.burlingtoncodeacademy.com/blog/"
      nav_item name: "Schedule", href: "/schedule"
      nav_item name: "Apply", href: "http://www.burlingtoncodeacademy.com/apply/", button: true
    end
  end

end
