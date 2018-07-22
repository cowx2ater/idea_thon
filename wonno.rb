require 'rubygems'
require 'mechanize'

agent = Mechanize.new
# url
page = agent.get('http://uni.likelion.org/users/sign_in')

#pp page
my_page = page.form_with(:action => '/users/sign_in') do |f|
  f.field_with(:name => 'user[email]').value = 'jongwonno@likelion.org'
  f.field_with(:name => 'user[password]').value = '35115502'
end.submit
(1..1142).each do |i|
  puts i
  begin
    a = agent.get("http://uni.likelion.org/users/#{i}")
    puts "학생 : "+a.search('.header__content').search('h1').text.strip
    puts "email : "+a.search('.meta').search("span").text.strip.split("\n").first
    puts "기수 : "+a.search('.mt-2').search('span').text.strip.split(" ")[0].split("년부터").first
    puts "학교 : "+a.search('.mt-2').search('span').text.strip.split(" ")[4]
  rescue
    puts "없습니다."
  end

end


# doc = Nokogiri::HTML(open("#{a.url}"))
# doc.css(".title").each { |x| puts x.inner_text }
