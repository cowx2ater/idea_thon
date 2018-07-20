require 'rubygems'
require 'mechanize'

agent = Mechanize.new
page = agent.get('http://uni.likelion.org/users/sign_in')

#pp page
my_page = page.form_with(:action => '/users/sign_in') do |f|
  f.field_with(:name => 'user[email]').value = 'jongwonno@likelion.org'
  f.field_with(:name => 'user[password]').value = '35115502'
end.submit
(1..1142).each do |i|
  puts i
  a = my_page.open(:href => "/users/#{i}")
  puts a.search('.header__content').search('h1').text.strip
  puts a.search('.mt-2').search('span').text.strip.split(" ")[4]
end


# doc = Nokogiri::HTML(open("#{a.url}"))
# doc.css(".title").each { |x| puts x.inner_text }
