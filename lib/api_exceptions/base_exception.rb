module ApiExceptions
  class BaseException < StandardError
    include ActiveModel::Serialization
    attr_reader :status, :code, :message

    ERROR_DESCRIPTION = Proc.new { |code, message| {status: "error | failure", code: code, message: message} }
    ERROR_CODE_MAP = {
      "CreateEventError::MissingNameError" =>
        ERROR_DESCRIPTION.call(3000, 'Event need a name to be created'),
    }

    def initialize
      error_type = self.class.name.scan(/ApiExceptions::(.*)/).flatten.first
      ApiExceptions::BaseException::ERROR_CODE_MAP
        .fetch(error_type ,{}).each do |attr, value|
          instance_variable_set("@#{attr}".to_sym, value)
        end
    end
  end
end