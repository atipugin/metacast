module EpisodeHelper
  def episode_state_icon(state, title)
    h = { title: title, data: { toggle: 'tooltip' } }
    case state.to_s
    when 'pending'
      icon('far', 'clock', h.merge(class: 'text-muted'))
    when 'processed'
      icon('far', 'check-circle', h.merge(class: 'text-success'))
    when 'failed'
      icon('far', 'times-circle', h.merge(class: 'text-danger'))
    end
  end
end
