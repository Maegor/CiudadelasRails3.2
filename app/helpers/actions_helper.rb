module ActionsHelper

  def form_action(partial_name, change = '')
    #noinspection RubyResolve
    action = current_user.player.actions.find_by_base_action_id(BaseAction.find_by_partialname(partial_name))
    '/parties/' + @game.id.to_s + '/action/'+ action.id.to_s + '/' + change
  end



end
