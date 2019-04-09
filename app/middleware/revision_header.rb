class RevisionHeader
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, response = @app.call(env)
    headers['X-Revision'] = revision if revision
    [status, headers, response]
  end

  def revision
    @revision ||= begin
      file_path = Rails.root.join('REVISION')
      return unless File.exist?(file_path)

      File.read(file_path)
    end
  end
end
