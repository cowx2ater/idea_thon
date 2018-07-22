require 'rubygems'
require 'mechanize'


class User < ApplicationRecord
  belongs_to :team, optional: true
  scope :no_team, -> {where(team_id: nil, role: "학생")}
  scope :tutor, -> {where(role: "운영진")}
  scope :student, -> {where(role: "학생")}

  # 일단 학생이 받은 팀 투표 수 합계입니다.
  def self.univ_rank(cnt=nil)
    univ_ary = all.pluck("univ").uniq
    univ_hash = {}
    univ_ary.each do |univ|
      total_cnt = 0
      where(univ: univ).where.not(team: nil).each do |u|
        total_cnt += u.team.max_cnt
      end
      result = total_cnt / User.where(univ: univ).length
      univ_hash[univ] = result

    end
    univ_hash = univ_hash.sort_by {|_key, value| value}.reverse.to_h
    puts univ_hash.class
    if cnt.nil?
      univ_hash
    else
      univ_hash.first(cnt)
    end
  end

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
        year = a.search('.mt-2').search('span').text.strip.split(" ")[0].split("년부터").first.to_i
        role = a.search('.mt-2').search('span').text.strip.split(" ")[5]
        lion_id = i
        puts i
        puts "학생 : " + name
        puts "email : " + email
        puts "학교 : " + univ
        puts "year : #{year}"
        puts "roel : #{role}"
        user = find_or_create_by(lion_id: i)
        user.update(name: name, email: email, univ: univ, year: year, role: role)
      rescue
      end
    end
  end

  def self.set_team
    agent = Mechanize.new
    # url
    page = agent.get('http://uni.likelion.org/users/sign_in')
    #pp page
    my_page = page.form_with(:action => '/users/sign_in') do |f|
      f.field_with(:name => 'user[email]').value = 'jongwonno@likelion.org'
      f.field_with(:name => 'user[password]').value = '35115502'
    end.submit

    Team.all.each do |team|
      puts team.url
      a = agent.get(team.url)
      a.search(".header__member").each do |mem|
        user_id = mem.to_s.split("href=\"/users/")[1].split("\">")[0].to_i
        puts user_id
        User.find_by(lion_id: user_id).update(team: team)
      end
    end
  end
end
