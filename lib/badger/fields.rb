module Badger

  class Fields
  
    DEFAULT_ROLE = 'Attendee'
  
    class FormatError < ::StandardError; end
    
    delegate :size, :to => :@data
    
    attr_reader :filename
    def initialize(filename, template, default_role=nil)
      @filename = filename
      @data = YAML.load(File.read(filename))
      @template = template
      @default_role = default_role || DEFAULT_ROLE
      check_fields
    end
    
    def in_pages_of(number)
      fdf_template = ERB.new(File.read(File.join(File.dirname(__FILE__), '../../data/fields.rfdf')), nil, '>')
      page_number = 0
      @data.in_groups_of(number) do |p|
        people = p
        page_number += 1
        yield(fdf_template.result(binding), page_number)
      end
    end
  
    #######
    private
    #######
  
    def check_fields
      unless @data && @data.kind_of?(Array) && @data.all?{|item| item.kind_of?(Hash) }
        raise FormatError, "Should be array of hashes"
      end
      @data.each do |person|
        person['role'] ||= @default_role
        person['role'].capitalize!
      end
    end
    
    def escape_value(value)
      value.to_s.gsub(/[\(\)]/, '')
    end
  
  end

end


