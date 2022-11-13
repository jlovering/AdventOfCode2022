require "http"
require "uri"
require "json"
require "xml"

require "./config"

enum ProblemPart
  A = 1
  B = 2
end

class AdventOfCodeClient
  AOC_SCHEME             = "https"
  AOC_HOST               = "adventofcode.com"
  AOC_PUZZLE_PATH        = "/%<year>d/day/%<day>d"
  AOC_PUZZLE_INPUT_PATH  = "/input"
  AOC_PUZZLE_SUBMIT_PATH = "/answer"

  getter stored_cookies : Hash(String, String)
  getter tested_solutions : Hash(String, Bool)
  getter day : Int32
  getter year : Int32

  def initialize(@day, @year = 2022)
    @stored_cookies = Config.new.read_cookies
    @tested_solutions = Hash(String, Bool).new(JSON::PullParser.new(File.read("./testedsolutions.json")))
  end

  def flush
    File.write("./testedsolutions.json", @tested_solutions.to_json)
  end

  def finalize
    flush
  end

  def get_input : String
    path = (AOC_PUZZLE_PATH + AOC_PUZZLE_INPUT_PATH) % {year: year, day: day}
    uri = URI.new scheme: AOC_SCHEME, host: AOC_HOST
    client = HTTP::Client.new uri
    response = client.get(path: path, headers: get_headers)

    unless response.status.ok?
      raise "Failed to get input for #{year} day #{day}"
    end

    response.body
  end

  def submit_solution(part : ProblemPart, value : String) : Bool
    if (tested_solutions[day.to_s + year.to_s + part.to_s + value]? != nil)
      p "You already tried that"
      return tested_solutions[day.to_s + year.to_s + part.to_s + value]
    end  
    p "Submitting to AoC"
    ret = parse_aoc_response post_solution(part, value)
    tested_solutions[day.to_s + year.to_s + part.to_s + value] = ret
    return ret
  end

  def post_solution(part : ProblemPart, value : String) : String
    path = (AOC_PUZZLE_PATH + AOC_PUZZLE_SUBMIT_PATH) % {year: year, day: day}
    uri = URI.new scheme: AOC_SCHEME, host: AOC_HOST
    client = HTTP::Client.new uri
    client.post(path: path, headers: post_headers, form: get_form_encoded(part, value)) do |response|
      raise "Unable to post response" if !response.status.ok?

      response.body_io.gets_to_end
    end
  end

  private def search_xml(xml : XML::Node, name : String) : XML::Node?
    if xml.name == name
      return xml
    end

    if xml.children.size > 0
      xml.children.each do |e|
        if (found = search_xml(e, name))
          return found
        end
      end
    end
    return nil
  end

  def parse_aoc_response(response : String) : Bool
    doc = XML.parse_html(response)
    if (html = doc.first_element_child)
      if (art = search_xml(html, "article"))
        if (p = search_xml(art, "p"))
          p.children.select do |e|
            e.name == "text"
          end.each do |text|
            case text.content
            when /That's not the right answer.*/
              return false
            when /That's the right answer.*/
              return true
            end
          end
        end
      end
    end
    raise "Unable to parse response"
  end

  private def get_headers
    add_cookie(HTTP::Headers.new)
  end

  private def post_headers
    headers = HTTP::Headers.new
    headers.add("accept", "text/html")
    headers.add("user-agent", "advent of code submitter")
    add_cookie(headers)
  end

  private def add_cookie(headers : HTTP::Headers)
    cookies = stored_cookies.reduce(HTTP::Cookies.new) do |cookies, (name, value)|
      cookie = HTTP::Cookie.new name: name, value: value
      cookies << cookie
      cookies
    end
    cookies.add_request_headers(headers)
  end

  private def get_form_encoded(level : ProblemPart, answer : String) : String
    "level=#{level.value}&answer=#{answer}"
  end
end