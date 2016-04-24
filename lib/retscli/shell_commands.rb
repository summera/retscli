require "thor"

module Retscli
  class ShellCommands < Thor
    def initialize(args, options, config)
      super
      @display_adapter = config[:display_adapter]
    end

    # since we are using thor for shell commands we want to remove executable
    # name from command help menu
    def self.banner(command, namespace = nil, subcommand = false)
      super.gsub("#{basename} ", "")
    end

    def self.command_list
      all_commands.keys.map{ |command| command.gsub('_', '-') }
    end

    desc 'login', 'Re-Login to RETS server. Use if session is no longer valid'
    def login
      puts @display_adapter.login
    end

    desc 'capabilities', 'Display capabilities for rets server'
    def capabilities
      @display_adapter.page(@display_adapter.capabilities)
    end

    desc 'resources', 'List available resources'
    method_option :editor, :aliases => '-e', :desc => 'Open resources in editor'
    def resources
      if options[:editor]
        @display_adapter.open_in_editor(@display_adapter.resources, options[:editor])
      else
        @display_adapter.page(@display_adapter.resources)
      end
    end

    desc 'classes [RESOURCE]', 'List available classes for resource'
    method_option :editor, :aliases => '-e', :desc => 'Open classes in editor'
    def classes(resource)
      if options[:editor]
        @display_adapter.open_in_editor(@display_adapter.classes(resource), options[:editor])
      else
        @display_adapter.page(@display_adapter.classes(resource))
      end
    end

    desc 'tables [RESOURCE] [CLASS]', 'List available tables for class of resource'
    method_option :editor, :aliases => '-e', :desc => 'Open tables in editor'
    def tables(resource, klass)
      if options[:editor]
        @display_adapter.open_in_editor(@display_adapter.tables(resource, klass), options[:editor])
      else
        @display_adapter.page(@display_adapter.tables(resource, klass))
      end
    end

    desc 'objects [RESOURCE]', 'List available objects for resource'
    method_option :editor, :aliases => '-e', :desc => 'Open objects in editor'
    def objects(resource)
      if options[:editor]
        @display_adapter.open_in_editor(@display_adapter.objects(resource), options[:editor])
      else
        @display_adapter.page(@display_adapter.objects(resource))
      end
    end

    desc 'timezone-offset', 'System timezone offset'
    def timezone_offset
      puts @display_adapter.timezone_offset
    end

    map 'timezone-offset' => :timezone_offset

    desc 'metadata', 'View metadata'
    method_option :editor, :aliases => '-e', :desc => 'Open metadata in editor'
    def metadata
      if options[:editor]
        @display_adapter.open_in_editor(@display_adapter.metadata, options[:editor])
      else
        @display_adapter.page(@display_adapter.metadata)
      end
    end

    desc 'search-metadata', 'Search metadata tables'
    method_option :resources, :aliases => '-r', :desc => 'Filter metadata by resources', :type => :array, :default => []
    method_option :classes, :aliases => '-c', :desc => 'Filter metadata by classes', :type => :array, :default => []
    method_option :editor, :aliases => '-e', :desc => 'Open search results in editor'
    def search_metadata(search)
      search_options = {
        :classes => options[:classes],
        :resources => options[:resources]
      }

      if options[:editor]
        @display_adapter.open_in_editor(@display_adapter.search_metadata(search, search_options.merge(:color => false)), options[:editor])
      else
        @display_adapter.page(@display_adapter.search_metadata(search, search_options))
      end
    end

    map 'search-metadata' => :search_metadata

    desc 'search [RESOURCE] [CLASS] [QUERY]', 'Search resources, e.g. properties, open houses, etc.'
    method_option :limit, :aliases => '-l', :desc => 'limit', :type => :numeric, :default => 20
    method_option :offset, :aliases => '-o', :desc => 'Offset', :type => :numeric
    method_option :count, :aliases => '-c', :desc => 'Return result count', :type => :boolean, :default => false
    method_option :select, :aliases => '-s', :desc => 'Select specific fields from records', :type => :array, :default => []
    method_option :format, :aliases => '-f', :desc => 'Rets data return format', :enum => ['COMPACT', 'COMPACT-DECODED', 'STANDARD-XML'], :default => 'COMPACT-DECODED'
    def search(resource, klass, query)
      search_options = {
        :limit => options[:limit],
        :offset => options[:offset],
        :count => options[:count],
        :select => options[:select],
        :format => options[:format]
      }

      results = @display_adapter.search(resource, klass, query, search_options)
      @display_adapter.page(results)
    end
  end
end
