require 'rubygems'
require 'mechanize'

class Team < ApplicationRecord
  has_many :users
  has_many :votes

  IMG = "/assets/univ-logo-f7b42ac475d76685a746bfd55e9d9de8c5e006f9b6afb90331a72c5942da7e59.png"

  default_scope { order(cnt: :desc) }

  def max_cnt
    votes.pluck("cnt").max
  end

  def self.univ_rank(univ="동국대")
    User.where(univ: univ).where.not(team: nil).each do |u|
      puts u.team.max_cnt
    end
  end

  def self.rank_id(cnt=nil)
    team_hash = {}
    all.each do |t|
      team_hash[t.id] = t.max_cnt
    end
    team_hash.sort_by {|_key, value| value}.reverse.to_h
    if cnt.nil?
      team_hash.keys
    else
      team_hash.keys.first(cnt)
    end
  end

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
      team = self.find_or_create_by(url: "https://uni.likelion.org"+url)
      team.update(name: name, desc: desc, image: image)
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
