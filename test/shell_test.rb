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

    it 'does not raise error' do
      raise_proc = Proc.new { raise StandardError.new('Some Error') }
      Retscli::ShellCommands.stub(:start, raise_proc) do
        subject.execute_shell_command('search property res (ListingID=0+)', StringIO.new)
      end
    end

    it 'prints error to IO' do
      error = StandardError.new('Some Error')
      raise_proc = Proc.new { raise error }
      io = StringIO.new
      Retscli::ShellCommands.stub(:start, raise_proc) do
        subject.execute_shell_command('search property res (ListingID=0+)', io)

      end

      assert_match(/.*#{error.message}.*/, io.string)
    end
  end
end
