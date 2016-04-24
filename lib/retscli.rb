require "retscli/version"
require "rets"
require "thor"
require "terminal-table"
require "retscli/shell"
require "retscli/display_adapter"

module Retscli
  class Cli < Thor

    desc 'validate [LOGIN URL]', 'Validate rets credentials'
    method_option :username, aliases: '-u', :desc => 'Username'
    method_option :password, aliases: '-p', :desc => 'Password'
    method_option :version, aliases: '-v', :desc => 'Rets version', :default => 'RETS/1.7.2'
    method_option :agent, aliases: '-a', :desc => 'User agent'
    method_option :ua_password, aliases: '-t', :desc => 'User agent password'
    method_option :debug, :aliases => '-d', :desc => 'Debug mode', :type => :boolean, :default => false
    def validate(url)
      client = rets_client(url, options)

      begin
        client.login
        client.logout
        puts set_color("\u2713 Valid Credentials", :green)
        true
      rescue => e
        puts set_color("\u2717 Invalid Credential\n#{e.message}", :red)
        false
      end
    end

    desc 'capabilities [LOGIN URL]', 'Display capabilities for rets server'
    method_option :username, aliases: '-u', :desc => 'Username'
    method_option :password, aliases: '-p', :desc => 'Password'
    method_option :version, aliases: '-v', :desc => 'Rets version', :default => 'RETS/1.7.2'
    method_option :agent, aliases: '-a', :desc => 'User agent'
    method_option :ua_password, aliases: '-t', :desc => 'User agent password'
    method_option :debug, :aliases => '-d', :desc => 'Debug mode', :type => :boolean, :default => false
    def capabilities(url)
      client = rets_client(url, options)

      begin
        client.login
        display_adapter = Retscli::DisplayAdapter.new(client)
        display_adapter.page(display_adapter.capabilities)
        client.logout
      rescue => e
        puts set_color("#{e.message}", :red)
      end
    end

    desc 'console [LOGIN URL]', 'Start rets console'
    method_option :username, aliases: '-u', :desc => 'Username'
    method_option :password, aliases: '-p', :desc => 'Password'
    method_option :version, aliases: '-v', :desc => 'Rets version', :default => 'RETS/1.7.2'
    method_option :agent, aliases: '-a', :desc => 'User agent'
    method_option :ua_password, aliases: '-t', :desc => 'User agent password'
    method_option :debug, :aliases => '-d', :desc => 'Debug mode', :type => :boolean, :default => false
    def console(url)
      client = rets_client(url, options)
      Retscli::Shell.new(client).start
    end

    no_commands do
      def rets_client(url, params={})
        logger = options[:debug] ? Logger.new($stdout) : nil

        ::Rets::Client.new({
          :login_url => url,
          :username => params[:username],
          :password => params[:password],
          :version => params[:version],
          :agent => params[:agent],
          :ua_password => params[:ua_password],
          :logger => logger
        })
      end
    end
  end
end
