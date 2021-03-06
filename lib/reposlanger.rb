module Reposlanger

  require File.join(File.dirname(__FILE__), "reposlanger", "provider")
  require File.join(File.dirname(__FILE__), "reposlanger", "commander")

  def self.providers
    @@providers ||= {}
  end

  # TODO: make me editable some day
  # maybe you should define a working folder
  # maybe it should be system-level
  def self.data_path
    File.expand_path File.join File.dirname(__FILE__), "..", "data"
  end

  def self.new_provider(name, options = {})
    @@providers[options["provider"].to_s].new(name, options)
  end
end

# TOOD: is this idiomatic? Where's the best place to put this?

unless String.new.respond_to? :underscore
  class String
    def underscore
      word = self.dup
      word.gsub!(/::/, '/')
      word.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
      word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
      word.tr!("-", "_")
      word.downcase!
      word
    end
  end
end

unless Hash.new.respond_to? :symbolize_keys
  class Hash
    def symbolize_keys
      self.each_with_object({}){ |(k, v), h| h[k.to_sym] = v }
    end
  end
end