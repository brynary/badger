module Badger
  
  DEFAULT_OUTPUT_FILE = 'badges.pdf'
  BUILD_BASE = 'build'
  
  ::Time::DATE_FORMATS[:build_number] = '%Y%m%d%H%M%S'
  
  class Driver
    
    class BuildError < ::StandardError; end    
    
    def initialize(input_file, options)
      @options = options
      @template = Template.new(options.template_file)
      @fields = Fields.new(input_file, @template, options.default_role)
      @number_of_pages = @fields.size / @template.badges_per_page
      @number_of_pages += 1 if @fields.size % @template.badges_per_page > 0
      @build_number = Time.now.to_s(:build_number)
    end
    
    def run
      setup
      archive_template_and_data
      $stderr.puts "Building in #{build_dir}"
      write_fdfs
      build_pages
      append_pages
    end
    
    #######
    private
    #######
    
    def archive_template_and_data
      FileUtils.cp @template.filename, build_path('src/template.yml')
      FileUtils.cp @fields.filename, build_path('src/fields.yml')
    end
    
    def write_fdfs
      @fields.in_pages_of(@template.badges_per_page) do |fdf, page_number|
        File.open(build_path("src/page#{page_number}.fdf"), 'w'){|f| f.puts(fdf) }
      end
    end
    
    def build_pages
      1.upto(@number_of_pages){|n| build_page(n) }
    end
    
    def build_page(number)
      pdf = build_path("src/page#{number}.pdf")
      args = ["pdftk", @template.filename,
              'fill_form', build_path("src/page#{number}.fdf"),
              "output", pdf, 
              "flatten"]
      puts args.join(" ")
      unless system(*args) && File.file?(pdf)
        raise BuildError, "Could not build Page ##{number} (bad response from pdftk)"
      end
    end
    
    def append_pages
      pdf = @options.output_file || build_path(DEFAULT_OUTPUT_FILE)
      if @number_of_pages > 1
        $stderr.puts "Appending pages..."
        args = ["pdftk", Dir[build_path('src/page*.pdf')] , "cat", "output", pdf].flatten
        puts args.join(" ")
        unless system(*args) && File.file?(pdf)
          raise BuildError, "Could not append pages to #{pdf} (bad response from pdftk)"
        end
      else
        $stderr.puts "Only one page, skipping append..."
        FileUtils.cp build_path("src/page1.pdf"), pdf
      end
      pdf
    end
    
    def setup
      FileUtils.mkdir_p build_path('src')
    end
    
    def build_path(basename)
      File.join(build_dir, basename)
    end
    
    def build_dir
      File.join(BUILD_BASE, @build_number)
    end
    
  end

end