require "readline"
require "csv"
require_relative "shell_commands"
require 'tty-spinner'

module Retscli
  class Shell
    EXIT_COMMANDS = ['quit', 'exit'].freeze

    def initialize(client)
      @stty_save = `stty -g`.chomp
      setup_readline_autocomplete
      @client = client
      @client.login
      @display_adapter = Retscli::DisplayAdapter.new(client)
      @colorer = ::Thor::Shell::Color.new
      retrieve_metadata
    end

    def start
      begin
        while line = readline_with_hist_management
          if EXIT_COMMANDS.include?(line)
            close
          else
            execute_shell_command(line)
          end
        end
      rescue Interrupt
        close
      end
    end

    # NOTE: this should probably be private, but making it public allowed
    # for easier testing without having to deal with mocking readline. Can we
    # find a better way?
    def execute_shell_command(line)
      Retscli::ShellCommands.start(split_line(line), :display_adapter => @display_adapter)
    end

    private
    # Split line, immitating ARGV behavior where it splits on spaces
    # except when quoted
    def split_line(line)
      CSV.parse_line(line, :col_sep => ' ')
    end

    def retrieve_metadata
      spinner = TTY::Spinner.new("Retrieving metadata #{@colorer.set_color(':spinner', :yellow)} ...", format: :box_bounce)
      spinner.start

      begin
        @client.metadata
      rescue => e
        puts "Error retrieving metadata. #{e.message}"
      ensure
        spinner.stop(@colorer.set_color('done', :green))
        puts ''
      end
    end

    def setup_readline_autocomplete
      comp = proc { |s| Retscli::ShellCommands.command_list.grep( /^#{Regexp.escape(s)}/ ) }
      Readline.completion_append_character = " "
      Readline.completion_proc = comp
    end

    def readline_with_hist_management
      line = Readline.readline(prompt, true)
      return nil if line.nil?

      if line =~ /^\s*$/ || Readline::HISTORY.to_a[-2] == line
        Readline::HISTORY.pop
      end

      line
    end

    def prompt
      @prompt ||=
        begin
          uri = URI.parse(@client.login_url)
          @colorer.set_color("#{@client.options[:username]}@#{uri.host} > ", :blue)
        end
    end

    def close
      system('stty', @stty_save)
      @client.logout
      exit
    end
  end
end

# HACK: because HTTPClient warnings
# are super annoying
class HTTPClient
  module Util
    def warning(msg); end
  end
end
