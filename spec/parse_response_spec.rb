require 'spec_helper'
require 'parse_response'

describe 'HTTPResponseParser' do
  def read_file(file)
    my_file = ""
    File.open(file,'r') do |f|
      f.each_line {|line| my_file += line}
    end
    my_file
  end

  def parse_response(file)
    HTTPResponseParser.new(read_file(file))
  end

  describe 'response_200.txt' do
    it 'should return response code 200' do
      expect(parse_response('lib/response_200.txt').response_code).to eq(200)
    end

    it 'should return HTTP version 1.1' do
      expect(parse_response('lib/response_200.txt').version).to eq("HTTP/1.1")
    end

    it 'should return the body' do
      expect(parse_response('lib/response_200.txt').body).to eq("<!DOCTYPE html><html lang=\"en\"><head><meta charset=\"utf-8\" />  <meta name=\"description\" content=\"should i test private methods?\" />  <meta name=\"keywords\" content=\"test,private,methods,oo,object,oriented,tdd\" />  <title>Should I Test Private Methods?</title></head><body>  <div style='font-size: 96px; font-weight: bold; text-align: center; padding-top: 200px; font-family: Verdana, Helvetica, sans-serif'>NO</div>  <!-- Every time you consider testing a private method, your code is telling you that you haven't allocated responsibilities well.  Are you listening to it? --></body></html>")
    end

    it 'should return the header' do
      expect(parse_response('lib/response_200.txt').header).to eq({"Server:"=>"nginx/1.4.6 (Ubuntu)", "Date:"=>"Tue, 06 May 2014 02:17:16 GMT", "Content-Type:"=>"text/html", "Last-Modified:"=>"Sun, 27 Apr 2014 04:03:41 GMT", "Transfer-Encoding:"=>"chunked", "Connection:"=>"keep-alive", "Content-Encoding:"=>"gzip"})
    end

    it 'should return Content-type: text' do
      expect(parse_response('lib/response_200.txt').content_type).to eq("text/html")
    end

    it 'should return server' do
      expect(parse_response('lib/response_200.txt').server).to eq("nginx/1.4.6 (Ubuntu)")
    end

  end

  describe 'response_301.txt' do
    it 'should return response code 301' do
      expect(parse_response('lib/response_301.txt').response_code).to eq(301)
    end

    it 'should return location' do
      expect(parse_response('lib/response_301.txt').location).to eq("http://www.pivotaltracker.com/")
    end

    it 'should return server' do
      expect(parse_response('lib/response_301.txt').server).to eq("nginx/1.6.0")
    end

  end

end