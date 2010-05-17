module Badger
  
  class Template
    
    class FormatError < ::ArgumentError; end
    
    attr_reader :filename
    def initialize(filename)
      @filename = filename
    end
    
    def absolute_path
      File.expand_path(@filename)
    end

    def badges_per_page
      @badges_per_page ||= begin
        cmd = "pdftk '#{@filename}' dump_data_fields"
        puts cmd
        data_fields = `#{cmd}`
        per_page = data_fields.scan(/f[a-z]+_name(\d+)/).flatten.map(&:to_i).max
        if per_page.nil? || per_page.zero?
          raise FormatError, "No badges found in template #{@filename}; see badger -h"
        else
          per_page
        end
      end
    end
    
  end
  
end