//= require active_admin/base
//= require active_admin_flat_skin
      (function() {
        $(function() {
            return setTimeout((function() {
              $('#diplay-filter').text('필터 설정');

              all = $('.all').children();
              all_cnt = all.children().text();
              all.text("");
              all.append("모두 "+"<span class='count'>"+all_cnt+"</span>");

              staff = $('.no_team').children();
              staff_cnt = staff.children().text();
              staff.text("");
              staff.append("팀미정 "+"<span class='count'>"+staff_cnt+"</span>");

              staff = $('.tutor').children();
              staff_cnt = staff.children().text();
              staff.text("");
              staff.append("운영진 "+"<span class='count'>"+staff_cnt+"</span>");

              staff = $('.student').children();
              staff_cnt = staff.children().text();
              staff.text("");
              staff.append("학생 "+"<span class='count'>"+staff_cnt+"</span>");

            }), 1);
        });

      }).call(this);
