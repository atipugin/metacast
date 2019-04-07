class ApplicationService
  class ValidationError < StandardError; end

  include ActiveModel::Model

  define_model_callbacks :perform

  def self.run(*args)
    new(*args).run
  end

  def self.run!(*args)
    service = new(*args)
    if service.invalid?
      raise ValidationError, service.errors.full_messages.first
    end

    service.run
  end

  def run
    return if invalid?

    run_callbacks(:perform) do
      perform
    end
  end

  def perform
    raise NotImplementedError, 'You need to implement this method first.'
  end
end
