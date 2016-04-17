require "terminal-table"

module Retscli
  class DisplayAdapter
    NO_RESULTS = 'No Results'.freeze
    EMPTY_VALUE = '<empty>'.freeze

    def initialize(client)
      @client = client
      @colorer = ::Thor::Shell::Color.new
    end

    def capabilities
      Terminal::Table.new(:rows => @client.capabilities.to_a)
    end

    def resources
      retrieve_metadata.tree.map do |key, resource|
        render_resource(resource)
      end.join("\n")
    end

    def classes(resource)
      resource_tree = retrieve_metadata.tree[resource.downcase]

      if resource_tree
        resource_tree.rets_classes.map do |klass|
          render_class(klass)
        end.join("\n")
      else
        set_color("#{resource} resource does not exist", :red)
      end
    end

    def objects(resource)
      resource_tree = retrieve_metadata.tree[resource.downcase]

      if resource_tree
        resource_tree.rets_objects.map do |object|
          render_object(object)
        end.join("\n")
      else
        set_color("#{resource} resource does not exist", :red)
      end
    end

    def tables(resource, klass)
      resource_tree = retrieve_metadata.tree[resource.downcase]
      return set_color("#{resource} resource does not exist", :red) unless resource_tree

      resource_class = resource_tree.rets_classes.detect { |rc| rc.name.downcase == klass.downcase }
      return set_color("#{klass} class does not exist", :red) unless resource_class

      resource_class.tables.map do |table|
        render_table(table)
      end.join("\n")
    end

    def timezone_offset
      offset = retrieve_metadata
        .metadata_types[:system]
        .first
        .fragment
        .xpath('SYSTEM')
        .attribute('TimeZoneOffset')
        .to_s

      if offset.empty?
        set_color("No offset specified", :red)
      else
        offset
      end
    end

    def metadata
      build_tree
    end

    def search_metadata(search, options={})
      options = { :resources => [], :classes => [] , :color => true }.merge(options)
      search_results = ''
      resources = options[:resources].map!{ |res| res.downcase }
      classes = options[:classes].map!{ |klass| klass.downcase }


      retrieve_metadata.tree.each do |key, res|
        next if !resources.empty? && !resources.include?(res.id.downcase)
        match_found_for_resouce = false

        res.rets_classes.each do |klass|
          next if !classes.empty? && !classes.include?(klass.name.downcase)
          match_found_for_class = false

          klass.tables.each do |table|
            if match = search_table(table, search)
              search_results << render_resource(res) << "\n" unless match_found_for_resouce
              search_results << tab_over(render_class(klass), 1) << "\n" unless match_found_for_class

              rendered_table = tab_over(render_table(table), 2)
              search_results << rendered_table.gsub!(match.regexp) do |sub|
                options[:color] ? set_color(sub, :red, :on_white) : sub
              end << "\n"

              match_found_for_resouce = true
              match_found_for_class = true
            end
          end
        end
      end

      search_results
    end

    def search(resource, klass, query, options={})
      select = options[:select] ? options[:select].join(',') : ''
      count = options[:count] ? 2 : 0

      results = @client.find(
        :all,
        search_type: resource,
        class: klass,
        query: query,
        select: select,
        limit: options[:limit],
        offset: options[:offset],
        count: count,
        format: options[:format],
        no_records_not_an_error: true
      )

      if results.is_a?(Integer)
        resource_table([{ 'count' => results }])
      else
        resource_table(results)
      end
    end

    def page(output)
      begin
        pager = ENV['PAGER'] || 'less'
        IO.popen(pager, 'w') { |f| f.puts(output) }
      rescue Errno::EPIPE
      end
    end

    def open_in_editor(text, editor='editor')
      editor = editor == 'editor' ? (ENV['EDITOR'] || 'nano') : editor
      open_tempfile_with_content(editor, text)
    end

    private
    def resource_table(results=[])
      term_table = Terminal::Table.new
      if results.empty?
        term_table.rows = [[NO_RESULTS]]
      else
        term_table.headings = results.first.keys
        term_table.rows = results.map{ |result| result.values.map!{ |value| value.to_s.empty? ? EMPTY_VALUE : value } }
      end

     term_table
    end

    def open_tempfile_with_content(editor, initial_content)
      temp_file do |f|
        f.puts(initial_content)
        f.flush
        f.close(false)
        system(editor, f.path)
        File.read(f.path)
      end
    end

    def temp_file(ext='.txt')
      file = Tempfile.new(['retscli', ext])
      yield file
    ensure
      file.close(true) if file
    end

    def retrieve_metadata
      @client.metadata
    end

    def search_table(table, search)
      regex = /#{search}/i
      table.table_fragment['LongName'].match(regex) ||
        table.table_fragment['SystemName'].match(regex) ||
        table.table_fragment['ShortName'].match(regex) ||
        table.table_fragment['StandardName'].match(regex)
    end

    def build_tree
      tree = ''
      retrieve_metadata.tree.each do |name, resource|
        tree << render_resource(resource)

        resource.rets_classes.each do |klass|
          tree << "\n"
          tree << tab_over(render_class(klass), 1)

          klass.tables.each do |table|
            tree << "\n"
            tree << tab_over(render_table(table), 2)
          end
        end

        resource.rets_objects.each do |object|
          tree << "\n"
          tree << tab_over(render_object(object), 1)
        end

        tree << "\n"
      end

      tree
    end

    def render_resource(resource)
      "Resource: #{resource.id} (Key Field: #{resource.key_field})"
    end

    def render_class(klass)
      "Class: #{klass.name}\n"\
      "  Visible Name: #{klass.visible_name}\n"\
      "  Description : #{klass.description}"
    end

    def render_object(object)
      "Object: #{object.name}\n"\
      "  MimeType: #{object.mime_type}\n"\
      "  Description: #{object.description}"
    end

    def render_table(table)
      types = false
      if table.is_a?(::Rets::Metadata::LookupTable)
        header = "LookupTable: #{table.name}"
        types = true
      elsif table.is_a?(::Rets::Metadata::MultiLookupTable)
        header = "MultiLookupTable: #{table.name}"
        types = true
      else
        header = "Table: #{table.name}"
      end

      base = "#{header}\n"\
      "  Resource: #{table.resource_id}\n"\
      "  ShortName: #{table.table_fragment["ShortName"] }\n"\
      "  LongName: #{table.long_name }\n"\
      "  StandardName: #{table.table_fragment["StandardName"] }\n"\
      "  Units: #{table.table_fragment["Units"] }\n"\
      "  Searchable: #{table.table_fragment["Searchable"] }\n"\
      "  Required: #{table.table_fragment['Required']}"

      if types
        base << "\n  Types:"
        table.lookup_types.each do |type|
          base << "\n    #{render_lookup_type(type)}"
        end
      end

      base
    end

    def render_lookup_type(type)
      "#{type.long_value} -> #{type.value}"
    end

    def tab_over(str, num_tabs)
      tab_width = "  "
      str.prepend(tab_width*num_tabs).gsub!("\n", "\n#{tab_width*num_tabs}")
    end

    def set_color(text, *args)
      @colorer.set_color(text, *args)
    end
  end
end
