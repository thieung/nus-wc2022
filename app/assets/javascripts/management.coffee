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

  $('.admin-update-score--select').on 'change', (event) ->
    selectedValue =  $(this).val()
    if selectedValue
      scoreText = $(this).find('option[value='+selectedValue+']').text()
      score1 = parseInt(scoreText.split("-")[0])
      score2 = parseInt(scoreText.split("-")[1])
      if score1 == score2
        $('.js--choose-winner-when-draw').show()
      else
        $('.js--choose-winner-when-draw').hide()
    else
      $('.js--choose-winner-when-draw').hide()
