module BootstrapHelper
  def bootstrap_alert_class_for(key)
    case key.to_s
    when 'alert' then 'alert-danger'
    when 'notice' then 'alert-success'
    else 'alert-primary'
    end
  end
end
