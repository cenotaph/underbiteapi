if defined?(RubyVM::YJIT) && RubyVM::YJIT.respond_to?(:enable)
  RubyVM::YJIT.enable
else
  Rails.logger.debug 'YJIT is not enabled'
end
