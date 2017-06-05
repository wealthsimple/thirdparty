module Thirdparty
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  def self.reset_configuration!
    @configuration = Configuration.new
  end

  class Configuration
    ATTRIBUTES = [:base_url, :client_id, :client_secret]
    attr_accessor *ATTRIBUTES

    def validate!
      raise "Invalid or missing configuration"  unless ATTRIBUTES.all? { |attribute| send(attribute).present? }
    end
  end
end
