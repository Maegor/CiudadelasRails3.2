module ActionsHelper

  def form_action(partial_name, change = '')
    #noinspection RubyResolve
    action = current_user.player.get_action_from_partial(partial_name)
    '/parties/' + @game.id.to_s + '/action/'+ action.id.to_s + '/' + change
  end



end
