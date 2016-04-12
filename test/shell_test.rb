require 'test_helper'

describe Retscli::Shell do
  let(:dummy_client) do
    Class.new do
      def login; end

      def logout; end

      def metadata
        Rets::Metadata::Root.new(nil, RETS_METADATA)
      end
    end.new
  end

  subject do
    class DummyShell < Retscli::Shell
      def retrieve_metadata
        @client.metadata
      end
    end

    DummyShell.new(dummy_client)
  end

  describe '#start' do
    it 'does not split quoted text' do
      mock = MiniTest::Mock.new
      mock.expect(:call, '', [['search-metadata', 'this is my quoted search'], Hash])

      Retscli::ShellCommands.stub(:start, mock) do
        subject.execute_shell_command('search-metadata "this is my quoted search"')
      end

      mock.verify
    end

    it 'splits on command flags' do
      mock = MiniTest::Mock.new
      mock.expect(:call, '', [['search-metadata', 'quoted search', 'with', '-f', 'flags', '-and', 'another'], Hash])

      Retscli::ShellCommands.stub(:start, mock) do
        subject.execute_shell_command('search-metadata "quoted search" with -f flags -and another')
      end

      mock.verify
    end
  end
end
