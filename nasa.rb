require "uri"
require "net/http"
require "json"

def request(address, keys)
    url= URI(address+"&api_key="+keys)
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = https.request(request)
    JSON.parse(response.read_body)
end
link=request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10", "EnF4kajfy3cXDobp44PuNIrcTMEHqSsr791MmiUE")


def buid_web_page(link)
    imagen=link["photos"].map {|img| img["img_src"]}
    html = "<html\n\t<head>\n\t</head>\n\t<body>\n\t\t<ul>"

    imagen.each do |nasa|
        html +="\n\t\t\t<li><img src=#{nasa}></li>"
    end
    html += "\n\t\t</ul>\n\t</body>\n</html>"
    File.write('nasa.html', html)
end
    
buid_web_page(link)

