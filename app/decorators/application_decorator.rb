class ApplicationDecorator < Draper::Decorator
  delegate_all

  delegate :t, to: :h
end
