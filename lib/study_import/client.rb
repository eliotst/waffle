class StudyImport::HTTPClient
  def initialize(base_url)
    @base_url = base_url
    @cookies = {}
    @auth_token = ""
  end

  def post(uri, body)
    @cookies[:auth_token] = @auth_token
    begin
      response = RestClient.post(@base_url + uri, body,
                                cookies: @cookies)
    rescue RestClient::Exception => exception
      response = exception.response
    end
    @cookies = response.cookies
    if @cookies.has_key?("auth_token")
      @auth_token = @cookies["auth_token"]
    end

    response
  end
end
