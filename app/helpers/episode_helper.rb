module EpisodeHelper
  def episode_state_icon_class_for(state)
    case state.to_s
    when 'pending' then 'far fa-clock text-muted'
    when 'processed' then 'far fa-check-circle text-success'
    when 'failed' then 'far fa-times-circle text-danger'
    end
  end
end
