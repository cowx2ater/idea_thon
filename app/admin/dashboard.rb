ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "학교별 top 15 순위" do
          div class: "blank_slate_container", id: "dashboard_default_message" do
            span class: "blank_slate" do
              span "이 순위는 원노의 주관적인 알고리즘으로 나온 결과입니다."
              br
              span "(학생들이 속한 팀의 투표 수 합계 / 학생 수)"
            end
          end
          ol do
            User.univ_rank(15).each do |name,cnt|
              li name
            end
          end
        end
      end

      column do
        panel "아이디어별 top 20 순위" do
          div class: "blank_slate_container", id: "dashboard_default_message" do
            span class: "blank_slate" do
              span "이 순위는 원노의 주관적인 알고리즘으로 나온 결과입니다."
              br
              span "(7월 21일 7시 까지의 투표 수 합계)"
            end
          end
          ol do
            Team.rank_id(20).each do |id|
              li link_to(Team.find(id).name, admin_team_path(id))
            end
          end
        end
      end
    end
  end # content
end
