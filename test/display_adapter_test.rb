require 'test_helper'

describe Retscli::DisplayAdapter do
  let(:dummy_client) do
    Class.new do
      def login; end

      def logout; end

      def metadata
        Rets::Metadata::Root.new(nil, RETS_METADATA)
      end
    end.new
  end

  subject { Retscli::DisplayAdapter.new(dummy_client) }

  describe '#resources' do
    it 'renders resources' do
      resources = "Resource: Agent (Key Field: rets_agt_id)"\
      "\nResource: Office (Key Field: DO_OFFICE_ID)"\
      "\nResource: Property (Key Field: MST_MLS_NUMBER)"\
      "\nResource: OpenHouse (Key Field: rets_oh_id)"

      assert_equal resources, subject.resources
    end
  end

  describe '#classes' do
    let (:classes) do
      "Class: Resd"\
      "\n  Visible Name: Residential"\
      "\n  Description : Residential"\
      "\nClass: ResLand"\
      "\n  Visible Name: Residential_Land"\
      "\n  Description : Residential_Land"\
      "\nClass: CmmlSales"\
      "\n  Visible Name: Commercial_Sales"\
      "\n  Description : Commercial_Sales"\
      "\nClass: CmmlLand"\
      "\n  Visible Name: Commercial_Land"\
      "\n  Description : Commercial_Land"\
      "\nClass: ResLse"\
      "\n  Visible Name: Residential_Lease"\
      "\n  Description : Residential_Lease"\
      "\nClass: CmmlLse"\
      "\n  Visible Name: Commercial_Lease"\
      "\n  Description : Commercial_Lease"
    end

    it 'renders classes' do
      assert_equal classes, subject.classes('Property')
    end

    it 'is case independent' do
      assert_equal classes, subject.classes('proPeRty')
    end

    it 'returns resource does not exist message' do
      assert_equal "\e[31mDoesNotExist resource does not exist\e[0m", subject.classes('DoesNotExist')
    end
  end

  describe '#objects' do
    it 'renders objects' do
      objects = "Object: image"\
      "\n  MimeType: "\
      "\n  Description: Property_Photo"

      assert_equal objects, subject.objects('property')
    end
  end

  describe '#tables' do
    it 'renders open house lookup table' do
      tables = "LookupTable: rets_oh_activity_type"\
      "\n  Resource: OpenHouse"\
      "\n  ShortName: ActType"\
      "\n  LongName: Activity Type"\
      "\n  StandardName: "\
      "\n  Units: "\
      "\n  Searchable: 1"\
      "\n  Required: "\
      "\n  Types:"\
      "\n    Open -> 0"\
      "\n    Private -> 1"

      assert_equal tables, subject.tables('OpenHouse', 'OpenHouse')
    end

    it 'renders property tables for CmmlLand' do
      tables = "Table: Address"\
      "\n  Resource: Property"\
      "\n  ShortName: Str Nm"\
      "\n  LongName: Street Name"\
      "\n  StandardName: StreetName"\
      "\n  Units: "\
      "\n  Searchable: 1"\
      "\n  Required: "

      assert_equal tables, subject.tables('Property', 'CmmlLand')
    end

    it 'returns resource does not exist message' do
      assert_equal "\e[31mDoesNotExist resource does not exist\e[0m", subject.tables('DoesNotExist', '')
    end

    it 'returns class does not exist message' do
      assert_equal "\e[31mDoesNotExist class does not exist\e[0m", subject.tables('Property', 'DoesNotExist')
    end
  end

  describe '#timezone_offset' do
    it 'returns rets server timezone offset' do
      assert_equal "-07:00", subject.timezone_offset
    end

    describe 'without specified offset' do
      let(:dummy_client) do
        Class.new do
          def login; end

          def logout; end

          def metadata
            meta_with_no_tz = {}
            meta_with_no_tz['SYSTEM'] = RETS_METADATA['SYSTEM'].dup
            meta_with_no_tz['SYSTEM'].gsub!('TimeZoneOffset="-07:00"', '')
            Rets::Metadata::Root.new(nil, meta_with_no_tz)
          end
        end.new
      end

      it 'returns offset not specified message' do
        assert_equal "\e[31mNo offset specified\e[0m", subject.timezone_offset
      end
    end
  end

  describe '#metadata' do
    it 'renders full metadata' do
      assert_equal RENDERED_METDATA, subject.metadata
    end
  end

  describe "#search_metadata" do
    it 'searches long name of metadata tables' do
      result = "Resource: OpenHouse (Key Field: rets_oh_id)"\
      "\n  Class: OpenHouse"\
      "\n    Visible Name: OpenHouse"\
      "\n    Description : Open House"\
      "\n    LookupTable: rets_oh_\e[31m\e[47mactivity\e[0m_type"\
      "\n      Resource: OpenHouse"\
      "\n      ShortName: ActType"\
      "\n      LongName: \e[31m\e[47mActivity\e[0m Type"\
      "\n      StandardName: "\
      "\n      Units: "\
      "\n      Searchable: 1"\
      "\n      Required: "\
      "\n      Types:"\
      "\n        Open -> 0"\
      "\n        Private -> 1\n"

      assert_equal result, subject.search_metadata('activity')
    end

    it 'searches system name of metadata tables' do
       result = "Resource: Property (Key Field: MST_MLS_NUMBER)"\
       "\n  Class: CmmlLand"\
       "\n    Visible Name: Commercial_Land"\
       "\n    Description : Commercial_Land"\
       "\n    Table: \e[31m\e[47mAddress\e[0m"\
       "\n      Resource: Property"\
       "\n      ShortName: Str Nm"\
       "\n      LongName: Street Name"\
       "\n      StandardName: StreetName"\
       "\n      Units: "\
       "\n      Searchable: 1"\
       "\n      Required: \n"

       assert_equal result, subject.search_metadata('address')
    end

    it 'searches short name of metadata tables' do
      result = "Resource: Property (Key Field: MST_MLS_NUMBER)"\
      "\n  Class: CmmlLand"\
      "\n    Visible Name: Commercial_Land"\
      "\n    Description : Commercial_Land"\
      "\n    Table: Address"\
      "\n      Resource: Property"\
      "\n      ShortName: \e[31m\e[47mStr\e[0m Nm"\
      "\n      LongName: \e[31m\e[47mStr\e[0meet Name"\
      "\n      StandardName: \e[31m\e[47mStr\e[0meetName"\
      "\n      Units: "\
      "\n      Searchable: 1"\
      "\n      Required: \n"

      assert_equal result, subject.search_metadata('str')
    end

    it 'searches standard name of metdata tables' do
      result = "Resource: Property (Key Field: MST_MLS_NUMBER)"\
      "\n  Class: CmmlLand"\
      "\n    Visible Name: Commercial_Land"\
      "\n    Description : Commercial_Land"\
      "\n    Table: Address"\
      "\n      Resource: Property"\
      "\n      ShortName: Str Nm"\
      "\n      LongName: Street Name"\
      "\n      StandardName: \e[31m\e[47mStreetName\e[0m"\
      "\n      Units: "\
      "\n      Searchable: 1"\
      "\n      Required: \n"

      assert_equal result, subject.search_metadata('streetname')
    end

    describe 'with resource filter' do
      it 'returns no results' do
        assert_equal '', subject.search_metadata('streetname', :resources => ['openhouse'])
      end

      it 'returns results from filtered resources' do
        result = "Resource: Property (Key Field: MST_MLS_NUMBER)"\
        "\n  Class: CmmlLand"\
        "\n    Visible Name: Commercial_Land"\
        "\n    Description : Commercial_Land"\
        "\n    Table: Address"\
        "\n      Resource: Property"\
        "\n      ShortName: Str Nm"\
        "\n      LongName: Street Name"\
        "\n      StandardName: \e[31m\e[47mStreetName\e[0m"\
        "\n      Units: "\
        "\n      Searchable: 1"\
        "\n      Required: \n"

        assert_equal result, subject.search_metadata('streetname', :resources => ['property'])
      end
    end

    describe 'with class filter' do
      it 'returns no results' do
        assert_equal '', subject.search_metadata('streetname', :classes => ['resland'])
      end

      it 'returns results from filtered classes' do
        result = "Resource: Property (Key Field: MST_MLS_NUMBER)"\
        "\n  Class: CmmlLand"\
        "\n    Visible Name: Commercial_Land"\
        "\n    Description : Commercial_Land"\
        "\n    Table: Address"\
        "\n      Resource: Property"\
        "\n      ShortName: Str Nm"\
        "\n      LongName: Street Name"\
        "\n      StandardName: \e[31m\e[47mStreetName\e[0m"\
        "\n      Units: "\
        "\n      Searchable: 1"\
        "\n      Required: \n"

        assert_equal result, subject.search_metadata('streetname', :classes => ['cmmlland'])
      end
    end

    describe 'with resource and class filters' do
      it 'returns no results when resource matches but class does not' do
        assert_equal '', subject.search_metadata('streetname', :resources => ['property'], :classes => ['cool'])
      end

      it 'returns no results when class matches but resource does not' do
        assert_equal '', subject.search_metadata('streetname', :resources => ['awesome'], :classes => ['cmmlland'])
      end

      it 'returns results from filtered resources and classes' do
        result = "Resource: Property (Key Field: MST_MLS_NUMBER)"\
        "\n  Class: CmmlLand"\
        "\n    Visible Name: Commercial_Land"\
        "\n    Description : Commercial_Land"\
        "\n    Table: Address"\
        "\n      Resource: Property"\
        "\n      ShortName: Str Nm"\
        "\n      LongName: Street Name"\
        "\n      StandardName: \e[31m\e[47mStreetName\e[0m"\
        "\n      Units: "\
        "\n      Searchable: 1"\
        "\n      Required: \n"

        assert_equal result, subject.search_metadata('streetname', :resources => ['property'], :classes => ['cmmlland'])
      end
    end
  end

  describe '#page' do
    it 'uses PAGER environment variable' do
      ENV['PAGER'] = 'less'
      mock = MiniTest::Mock.new
      mock.expect(:call, nil, ['less', 'w'])

      IO.stub(:popen, mock, StringIO.new) do
        subject.page('')
      end

      mock.verify
    end
  end

  describe '#open_in_editor' do
    it 'uses EDITOR environment variable by default' do
      ENV['EDITOR'] = 'vim'
      mock = MiniTest::Mock.new
      mock.expect(:call, nil, ['vim', 'text'])

      subject.stub(:open_tempfile_with_content, mock) do
        subject.open_in_editor('text')
      end

      mock.verify
    end

    it 'uses nano when EDITOR environment variable is not set' do
      ENV.delete('EDITOR')
      mock = MiniTest::Mock.new
      mock.expect(:call, nil, ['nano', 'text'])

      subject.stub(:open_tempfile_with_content, mock) do
        subject.open_in_editor('text')
      end

      mock.verify
    end
  end
end

