$ ->
  $('.admin-select-team').on 'change', (event) ->
    row = event.currentTarget.closest('tr')
    gameId = $(row).data().gameId
    team1Id = $('#team1_id_'+gameId).val()
    team2Id = $('#team2_id_'+gameId).val()
    $(row).find('.js--team1-id').val(team1Id)
    $(row).find('.js--team2-id').val(team2Id)

  $('.admin-predict-team').on 'change', (event) ->
    row = event.currentTarget.closest('tr')
    userId = $(row).data().userId
    teamId = $('#tmp_team_id__'+userId).val()
    $(row).find('.js--team-id').val(teamId)

  $('#staffs_predict_champion').on 'hide.bs.collapse', ->
    $('.toogle-btn').text 'Hiển thị'
  $('#staffs_predict_champion').on 'show.bs.collapse', ->
    $('.toogle-btn').text 'Thu gọn'