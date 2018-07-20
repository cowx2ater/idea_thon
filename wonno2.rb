require 'rubygems'
require 'mechanize'
require 'byebug'
agent = Mechanize.new
# url
page = agent.get('http://uni.likelion.org/users/sign_in')

#pp page
my_page = page.form_with(:action => '/users/sign_in') do |f|
  f.field_with(:name => 'user[email]').value = 'jongwonno@likelion.org'
  f.field_with(:name => 'user[password]').value = '35115502'
end.submit

a = agent.get("https://uni.likelion.org/ideathon/ideas")
ideas = a.search(".idea")
ideas.each do |i|
  p "투표수 : " + i.search(".idea__votes").text.strip
  p "팀 명 : " + i.search(".idea__head").text.strip
  p "팀 소개 : " + i.search(".idea__text").text.strip
  p "팀 url : " + i.search(".hit").search("a").to_s.split("href=\"")[1].split("\">")[0]
  p "팀 사진 : " + i.search(".user__img").to_s.split("<img src=\"")[1].split("\"")[0]
  p "-----------------------"
end

# (1..1142).each do |i|
#   puts i
#   begin
#     a = agent.get("http://uni.likelion.org/users/#{i}")
#     puts "학생 : "+a.search('.header__content').search('h1').text.strip
#     puts "email : "+a.search('.meta').search("span").text.strip
#     puts "학교 : "+a.search('.mt-2').search('span').text.strip.split(" ")[4]
#   rescue
#     puts "없습니다."
#   end
#
# end


# doc = Nokogiri::HTML(open("#{a.url}"))
# doc.css(".title").each { |x| puts x.inner_text }
