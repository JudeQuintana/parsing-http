class HTTPResponseParser

  def initialize(http_response)
    @http_res = http_response
  end

  def response_code
    resp_code = @http_res.split("\n")[0]

    if resp_code =~ /200 OK/
      200
    elsif resp_code =~ /301 Moved Permanently/
      301
    end

  end

  def version
    @http_res =~ /(HTTP\/\d\.\d)/
    $1
  end

  def body
    @http_res =~ /(<!DOCTYPE html>.*<\/html>)/m
    $1.gsub!("\n","")
  end

  def header
    headers_hsh = {}

    @http_res =~ /(Server.*)\n\n/m
    headers = $1

    headers.split("\n").each do |h|
      h =~ /(^.*\:)\s(.*)/
      headers_hsh[$1] = $2
    end

    headers_hsh
  end

  def content_type
    header["Content-Type:"]
  end

  def server
    header["Server:"]
  end

  def location
    header["Location:"]
  end

end