RETS_METADATA = {
  "SYSTEM"=>"<RETS ReplyCode=\"0\" ReplyText=\"Operation Successful\">\r\n  <METADATA-SYSTEM Version=\"01.00.01685\" Date=\"2015-12-18T02:12:24\">\r\n    <SYSTEM SystemID=\"TEST\" SystemDescription=\"TEST BOARD\" TimeZoneOffset=\"-07:00\"/>\r\n    <COMMENTS>TEST BOARD</COMMENTS>\r\n  </METADATA-SYSTEM>\r\n</RETS>",
  "RESOURCE"=>"<RETS ReplyCode=\"0\" ReplyText=\"Operation Successful\">\r\n  <METADATA-RESOURCE Version=\"01.00.01684\" Date=\"2015-12-18T02:12:24\">\r\n    <COLUMNS>\tResourceID\tStandardName\tVisibleName\tDescription\tKeyField\tClassCount\tClassVersion\tClassDate\tObjectVersion\tObjectDate\tSearchHelpVersion\tSearchHelpDate\tEditMaskVersion\tEditMaskDate\tLookupVersion\tLookupDate\tUpdateHelpVersion\tUpdateHelpDate\tValidationExpressionVersion\tValidationExpressionDate\tValidationLookupVersion\tValidationLookupDate\tValidationExternalVersion\tValidationExternalDate\t</COLUMNS>\r\n    <DATA>\tAgent\tAgent\tAgent\tAgent\trets_agt_id\t1\t01.00.00000\t2012-07-16T23:33:24\t01.00.00000\t2015-06-24T23:11:25\t\t\t\t\t01.00.00002\t2015-10-26T23:19:19\t\t\t\t\t\t\t\t\t</DATA>\r\n    <DATA>\tOffice\tOffice\tOffice\tOffice\tDO_OFFICE_ID\t1\t01.00.00000\t2012-07-16T23:33:36\t\t\t\t\t\t\t01.00.00002\t2015-10-26T23:19:43\t\t\t\t\t\t\t\t\t</DATA>\r\n    <DATA>\tProperty\tProperty\tProperty\tProperty\tMST_MLS_NUMBER\t6\t01.00.00006\t2015-09-26T17:48:29\t01.00.00000\t2012-07-17T00:30:03\t\t\t\t\t01.00.00113\t2015-12-18T02:08:50\t\t\t\t\t\t\t\t\t</DATA>\r\n    <DATA>\tOpenHouse\tOpenHouse\tOpenHouse\tOpenHouse\trets_oh_id\t1\t01.00.00000\t2015-09-26T17:48:04\t\t\t\t\t\t\t01.00.00000\t2015-10-26T23:19:57\t\t\t\t\t\t\t\t\t</DATA>\r\n  </METADATA-RESOURCE>\r\n</RETS>",
  "CLASS"=>"<RETS ReplyCode=\"0\" ReplyText=\"Operation Successful\">\r\n  <METADATA-CLASS Resource=\"Agent\" Version=\"01.00.00028\" Date=\"2015-12-15T20:28:58\">\r\n    <COLUMNS>\tClassName\tStandardName\tVisibleName\tDescription\tTableVersion\tTableDate\tUpdateVersion\tUpdateDate\tClassTimeStamp\tDeletedFlagField\tDeletedFlagValue\t</COLUMNS>\r\n    <DATA>\tAgent\tAgent\tAgent\tAgent\t01.00.00026\t2015-12-15T20:28:58\t\t\t\t\t\t</DATA>\r\n  </METADATA-CLASS>\r\n  <METADATA-CLASS Resource=\"Office\" Version=\"01.00.00023\" Date=\"2015-10-26T23:22:54\">\r\n    <COLUMNS>\tClassName\tStandardName\tVisibleName\tDescription\tTableVersion\tTableDate\tUpdateVersion\tUpdateDate\tClassTimeStamp\tDeletedFlagField\tDeletedFlagValue\t</COLUMNS>\r\n    <DATA>\tOffice\tOffice\tOffice\tOffice\t01.00.00021\t2015-10-26T23:22:54\t\t\t\t\t\t</DATA>\r\n  </METADATA-CLASS>\r\n  <METADATA-CLASS Resource=\"Property\" Version=\"01.00.01495\" Date=\"2015-12-18T02:12:24\">\r\n    <COLUMNS>\tClassName\tStandardName\tVisibleName\tDescription\tTableVersion\tTableDate\tUpdateVersion\tUpdateDate\tClassTimeStamp\tDeletedFlagField\tDeletedFlagValue\t</COLUMNS>\r\n    <DATA>\tResd\tResidentialProperty\tResidential\tResidential\t01.00.00288\t2015-12-18T02:11:22\t\t\t\t\t\t</DATA>\r\n    <DATA>\tResLand\tLotsAndLand\tResidential_Land\tResidential_Land\t01.00.00218\t2015-12-18T02:11:54\t\t\t\t\t\t</DATA>\r\n    <DATA>\tCmmlSales\tCommonInterest\tCommercial_Sales\tCommercial_Sales\t01.00.00245\t2015-12-18T02:10:49\t\t\t\t\t\t</DATA>\r\n    <DATA>\tCmmlLand\tLotsAndLand\tCommercial_Land\tCommercial_Land\t01.00.00239\t2015-12-18T02:09:47\t\t\t\t\t\t</DATA>\r\n    <DATA>\tResLse\tResidentialProperty\tResidential_Lease\tResidential_Lease\t01.00.00273\t2015-12-18T02:12:24\t\t\t\t\t\t</DATA>\r\n    <DATA>\tCmmlLse\tCommonInterest\tCommercial_Lease\tCommercial_Lease\t01.00.00219\t2015-12-18T02:10:18\t\t\t\t\t\t</DATA>\r\n  </METADATA-CLASS>\r\n  <METADATA-CLASS Resource=\"OpenHouse\" Version=\"01.00.00011\" Date=\"2015-10-26T23:23:03\">\r\n    <COLUMNS>\tClassName\tStandardName\tVisibleName\tDescription\tTableVersion\tTableDate\tUpdateVersion\tUpdateDate\tClassTimeStamp\tDeletedFlagField\tDeletedFlagValue\t</COLUMNS>\r\n    <DATA>\tOpenHouse\tOpenHouse\tOpenHouse\tOpen House\t01.00.00009\t2015-10-26T23:23:03\t\t\t\t\t\t</DATA>\r\n  </METADATA-CLASS>\r\n</RETS>",
  "TABLE"=>"<RETS ReplyCode=\"0\" ReplyText=\"Operation Successful\">\r\n <METADATA-TABLE Resource=\"Property\" Class=\"CmmlLand\" Version=\"01.00.00240\" Date=\"2015-12-18T02:09:47\">\r\n    <COLUMNS>\tMetadataEntryID\tSystemName\tStandardName\tLongName\tDBName\tShortName\tMaximumLength\tDataType\tPrecision\tSearchable\tInterpretation\tAlignment\tUseSeparator\tEditMaskID\tLookupName\tMaxSelect\tUnits\tIndex\tMinimum\tMaximum\tDefault\tRequired\tSearchHelpID\tUnique\tModTimeStampName\tForeignKeyName\tForeignField\tKeyQuery\tKeySelect\tInKeyIndex\t</COLUMNS>\r\n    <DATA>\td7c4c89fe41c44b88c9ef9b2f51b2d71\tAddress\tStreetName\tStreet Name\tStrNm\tStr Nm\t50\tCharacter\t\t1\t\t\t\t\t\t\t\t\t\t\t\t\t\t0\t\t\t\t\t\t1\t</DATA>\r\n  </METADATA-TABLE>\r\n  <METADATA-TABLE Resource=\"OpenHouse\" Class=\"OpenHouse\" Version=\"01.00.00010\" Date=\"2015-10-26T23:23:03\">\r\n    <COLUMNS>\tMetadataEntryID\tSystemName\tStandardName\tLongName\tDBName\tShortName\tMaximumLength\tDataType\tPrecision\tSearchable\tInterpretation\tAlignment\tUseSeparator\tEditMaskID\tLookupName\tMaxSelect\tUnits\tIndex\tMinimum\tMaximum\tDefault\tRequired\tSearchHelpID\tUnique\tModTimeStampName\tForeignKeyName\tForeignField\tKeyQuery\tKeySelect\tInKeyIndex\t</COLUMNS>\r\n    <DATA>\t75dd7c37bb9149229cdfc517fba445e1\trets_oh_activity_type\t\tActivity Type\tActType\tActType\t4\tCharacter\t\t1\tLookup\t\t\t\tOHActivityType\t1\t\t\t\t\t\t\t\t0\t\t\t\t\t\t1\t</DATA>\r\n   </METADATA-TABLE>\r\n</RETS>",
  "LOOKUP"=>"<RETS ReplyCode=\"0\" ReplyText=\"Operation Successful\">\r\n <METADATA-LOOKUP Resource=\"OpenHouse\" Version=\"01.00.00001\" Date=\"2015-10-26T23:19:57\">\r\n    <COLUMNS>\tMetadataEntryID\tLookupName\tVisibleName\tLookupTypeVersion\tLookupTypeDate\t</COLUMNS>\r\n    <DATA>\t6756719706b2460aa04a3170a0fa2f24\tOHActivityType\tOHActivityType\t1.00.000\t2015-10-26T23:19:57\t</DATA>\r\n  </METADATA-LOOKUP>\r\n</RETS>",
  "LOOKUP_TYPE"=>"<RETS ReplyCode=\"0\" ReplyText=\"Operation Successful\">\r\n <METADATA-LOOKUP_TYPE Resource=\"OpenHouse\" Lookup=\"OHActivityType\" Version=\"01.00.00001\" Date=\"2015-10-26T23:19:57\">\r\n    <COLUMNS>\tMetadataEntryID\tLongValue\tShortValue\tValue\t</COLUMNS>\r\n    <DATA>\t7859ccdcd754426980379a26bd840cf4\tOpen\tOpen\t0\t</DATA>\r\n    <DATA>\t0c0e8922e2b544609d9e3bdf9bdfee09\tPrivate\tPrivate\t1\t</DATA>\r\n  </METADATA-LOOKUP_TYPE>\r\n</RETS>",
  "OBJECT"=>"<RETS ReplyCode=\"0\" ReplyText=\"Operation Successful\">\r\n  <METADATA-OBJECT Resource=\"Agent\" Version=\"01.00.00001\" Date=\"2015-06-24T23:11:25\">\r\n    <COLUMNS>\tMetadataEntryID\tObjectType\tMimeType\tVisibleName\tDescription\tObjectTimeStamp\tObjectCount\t</COLUMNS>\r\n    <DATA>\tbfce80be2f0b400d852119e9323f5ef6\tPhoto\timage/jpeg\timage\tAgent Photo\trets_photo_timestamp\trets_photo_count\t</DATA>\r\n  </METADATA-OBJECT>\r\n  <METADATA-OBJECT Resource=\"Property\" Version=\"01.00.00001\" Date=\"2012-07-17T00:30:03\">\r\n    <COLUMNS>\tMetadataEntryID\tObjectType\tMimeType\tVisibleName\tDescription\tObjectTimeStamp\tObjectCount\t</COLUMNS>\r\n    <DATA>\t4de7ad1fb4e1460784a497f318aa9198\tPhoto\timage/jpeg\timage\tProperty_Photo\trets_photo_timestamp\trets_photo_count\t</DATA>\r\n  </METADATA-OBJECT>\r\n</RETS>"
}

RENDERED_METDATA = "Resource: Agent (Key Field: rets_agt_id)"\
"\n  Class: Agent"\
"\n    Visible Name: Agent"\
"\n    Description : Agent"\
"\n  Object: image"\
"\n    MimeType: "\
"\n    Description: Agent Photo"\
"\nResource: Office (Key Field: DO_OFFICE_ID)"\
"\n  Class: Office"\
"\n    Visible Name: Office"\
"\n    Description : Office"\
"\nResource: Property (Key Field: MST_MLS_NUMBER)"\
"\n  Class: Resd"\
"\n    Visible Name: Residential"\
"\n    Description : Residential"\
"\n  Class: ResLand"\
"\n    Visible Name: Residential_Land"\
"\n    Description : Residential_Land"\
"\n  Class: CmmlSales"\
"\n    Visible Name: Commercial_Sales"\
"\n    Description : Commercial_Sales"\
"\n  Class: CmmlLand"\
"\n    Visible Name: Commercial_Land"\
"\n    Description : Commercial_Land"\
"\n    Table: Address"\
"\n      Resource: Property"\
"\n      ShortName: Str Nm"\
"\n      LongName: Street Name"\
"\n      StandardName: StreetName"\
"\n      Units: "\
"\n      Searchable: 1"\
"\n      Required: "\
"\n  Class: ResLse"\
"\n    Visible Name: Residential_Lease"\
"\n    Description : Residential_Lease"\
"\n  Class: CmmlLse"\
"\n    Visible Name: Commercial_Lease"\
"\n    Description : Commercial_Lease"\
"\n  Object: image"\
"\n    MimeType: "\
"\n    Description: Property_Photo"\
"\nResource: OpenHouse (Key Field: rets_oh_id)"\
"\n  Class: OpenHouse"\
"\n    Visible Name: OpenHouse"\
"\n    Description : Open House"\
"\n    LookupTable: rets_oh_activity_type"\
"\n      Resource: OpenHouse"\
"\n      ShortName: ActType"\
"\n      LongName: Activity Type"\
"\n      StandardName: "\
"\n      Units: "\
"\n      Searchable: 1"\
"\n      Required: "\
"\n      Types:"\
"\n        Open -> 0"\
"\n        Private -> 1\n"
