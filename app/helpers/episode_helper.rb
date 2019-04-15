module EpisodeHelper
  def episode_state_icon(state)
    case state.to_s
    when 'pending'
      icon 'far', 'clock', class: 'text-muted'
    when 'processed'
      icon 'far', 'check-circle', class: 'text-success'
    when 'failed'
      icon 'far', 'times-circle', class: 'text-danger'
    end
  end
end
