require 'rubygems'
require 'mechanize'


class User < ApplicationRecord
  def self.import_lion
    agent = Mechanize.new
    # url
    page = agent.get('http://uni.likelion.org/users/sign_in')
    #pp page
    my_page = page.form_with(:action => '/users/sign_in') do |f|
      f.field_with(:name => 'user[email]').value = 'jongwonno@likelion.org'
      f.field_with(:name => 'user[password]').value = '35115502'
    end.submit
    (1..1142).each do |i|
      begin
        a = agent.get("http://uni.likelion.org/users/#{i}")
        name = a.search('.header__content').search('h1').text.strip
        email = a.search('.meta').search("span").text.strip.split("\n").first
        univ = a.search('.mt-2').search('span').text.strip.split(" ")[4]
        puts "학생 : " + name
        puts "email : " + email
        puts "학교 : " + univ
        find_or_create_by(name: name, email: email, univ: univ)
      rescue
      end
    end
  end
end
