require 'rubygems'
require 'mechanize'

class Team < ApplicationRecord
  has_many :users
  has_many :votes

  default_scope { order(cnt: :desc) }

  def self.import_team
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
      name = i.search(".idea__head").text.strip
      desc = i.search(".idea__text").text.strip
      url = i.search(".hit").search("a").to_s.split("href=\"")[1].split("\">")[0]
      image = i.search(".user__img").to_s.split("<img src=\"")[1].split("\"")[0]
      p "투표수 : " + i.search(".idea__votes").text.strip
      p "팀 명 : " + name
      p "팀 소개 : " + desc
      p "팀 url : " + url
      p "-----------------------"
      team = self.find_or_create_by(name: name, desc: desc, url: "https://uni.likelion.org"+url)
      team.update(image: image)
    end
  end

  def self.update_vote
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
      cnt = i.search(".idea__votes").text.strip
      name = i.search(".idea__head").text.strip
      desc = i.search(".idea__text").text.strip
      url = i.search(".hit").search("a").to_s.split("href=\"")[1].split("\">")[0]
      image = i.search(".user__img").to_s.split("<img src=\"")[1].split("\"")[0]
      p "투표수 : " + cnt
      p "팀 명 : " + name
      p "팀 소개 : " + desc
      p "팀 url : " + url
      p "-----------------------"
      team = Team.find_by(url: "https://uni.likelion.org"+url)
      team.votes.create(cnt: cnt, crawl_date: Time.now)
      team.update(cnt: cnt,image: image, desc: desc, name: name)
    end
  end

  def self.random(num)
    offset = rand(self.count)

    return offset(offset).limit(num)
  end

  def recent_vote
    votes.order(crawl_date: :desc).first
  end
end
