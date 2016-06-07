$ ->
  $('.select-team').on 'change', (event) ->
    row = event.currentTarget.closest('tr')
    gameId = $(row).data().gameId
    team1Id = $('#team1_id_'+gameId).val()
    team2Id = $('#team2_id_'+gameId).val()
    $(row).find('#tmp_team1_id').val(team1Id)
    $(row).find('#tmp_team2_id').val(team2Id)